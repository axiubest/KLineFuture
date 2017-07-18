//
//  MD_OptionalViewController.m
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptionalViewController.h"
#import "MD_SearchStockVC.h"

#import "MD_OptionalStockEditCell.h"
#import "MD_SingleStockChartVC.h"
#import "MD_OptionalListModel.h"
@interface MD_OptionalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *addStockImageView;

@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *  navRightImageString = @"editshoose_btn_search";
@implementation MD_OptionalViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"我的自选";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    自选股票实时动态，网络请求，有无股票在此写
    [self request];
    
    //本地保存我的自选记录
    
    
    
   }

- (void)request {
    if (![XIU_Login isLogin]) {
        return;
    }
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_GetStockOptions withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"userId":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        [self.dataSource removeAllObjects];
        NSArray *arr = [data objectForKey:@"StockOptions"];
        if (arr.count > 0) {//if dataSource is empty means my stock is empty show empty View
            for (NSDictionary *dic in arr) {
                MD_OptionalListModel *model = [[MD_OptionalListModel alloc] init];
                model.Code = [dic objectForKey:@"Code"];
                model.DiffMoney = [dic objectForKey:@"DiffMoney"];
                model.DiffRate = [dic objectForKey:@"DiffRate"];
                model.Id = [dic objectForKey:@"Id"];
                model.Name = [dic objectForKey:@"Name"];
                model.NowPrice = [dic objectForKey:@"NowPrice"];
                [self.dataSource addObject:model];
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *arr = [NSMutableArray array];
            for (MD_OptionalListModel *model in self.dataSource) {
                NSDictionary *dic = @{@"Code":model.Code,@"Name":model.Name};
                [arr addObject:dic];
            }
            
            [XIU_NSUserDefaut addObject:arr WithObjName:myOptional_list];
            
                        });
            NSLog(@"%@", kPathDocument);
            self.XIUTableView.hidden = NO;
            self.addStockImageView.hidden = YES;
            [self.navigationController.navigationBar.subviews.lastObject setHidden:NO];
            

            

            
            
        }else {
            self.XIUTableView.hidden = YES;
            self.addStockImageView.hidden = NO;
            
            [self.navigationController.navigationBar.subviews.lastObject setHidden:YES];
        }
        
        [self.XIUTableView  reloadData];
 

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self createNavgationButtonWithImageNmae:nil title:@"编辑" target:self action:@selector(clickNavEditBtn) type:UINavigationItem_Type_LeftItem];
    [self createNavgationButtonWithImageNmae:navRightImageString title:nil target:self action:@selector(clickNavSearchBtn) type:UINavigationItem_Type_RightItem];
    self.XIUTableView.editing = NO;
    _addStockImageView.userInteractionEnabled = YES;
    [_addStockImageView bk_whenTapped:^{
        [self clickNavSearchBtn];
    }];

    [_XIUTableView registerNib:[MD_OptionalStockEditCell XIU_ClassNib] forCellReuseIdentifier:[MD_OptionalStockEditCell XIU_ClassIdentifier]];
}

- (void)clickNavEditBtn {
    self.XIUTableView.editing = !self.XIUTableView.editing;
    [self.XIUTableView reloadData];
}

- (void)clickNavSearchBtn {
    
    [self.navigationController pushViewController:[[MD_SearchStockVC alloc] init] animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_SingleStockChartVC *vc = [[MD_SingleStockChartVC alloc] init];
    vc.CodeName = [self.dataSource[indexPath.row] Name];
    vc.CodeString = [self.dataSource[indexPath.row] Code];
    [self.navigationController pushViewController:vc animated:YES];
}

//edit
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

// 移动 cell 时触发
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 移动cell之后更换数据数组里的循序
    [self.dataSource exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

//delete
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        [self deleteRequestWithRow:indexPath.row];

        [self.dataSource removeObjectAtIndex:indexPath.row];
        [_XIUTableView  deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

        MD_OptionalStockEditCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_OptionalStockEditCell XIU_ClassIdentifier]];
    [cell setData:self.dataSource[indexPath.row]];
        return cell;
    
}

- (void)deleteRequestWithRow:(NSInteger)row {
    
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_RemoveStockOption withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"userId":[XIU_Login userId], @"code":[self.dataSource[row] Code]} withMethodType:Post andBlock:^(id data, NSError *error) {
        ERROR_HUD(@"删除成功");
    }];
    [self.XIUTableView reloadData];
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];

    }
    return _dataSource;
}

@end
