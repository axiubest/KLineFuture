//
//  MD_SelectStockViewController.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockViewController.h"
#import "MD_SelectStockListMainCell.h"
#import "MD_SelectStockListHeaderCell.h"

#import "MD_SelectStockDetialVC.h"

#import "MD_SelectStockKLineDateModel.h"
#import "MD_LoginViewController.h"
static NSInteger typeid = 1;
static NSString * typeName;

@interface MD_SelectStockViewController ()<UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate, MD_SelectStockListMainCellDelegate,MD_SelectStockListHeaderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;


@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *headerArr;

@property (nonatomic, strong) NSMutableDictionary *mainCellDic;

@property (nonatomic, strong)MBProgressHUD *hud;

@end

@implementation MD_SelectStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"形态选股";
    [_XIUTableView registerNib:[MD_SelectStockListMainCell XIU_ClassNib] forCellReuseIdentifier:[MD_SelectStockListMainCell XIU_ClassIdentifier]];
    
        [_XIUTableView registerNib:[MD_SelectStockListHeaderCell XIU_ClassNib] forCellReuseIdentifier:[MD_SelectStockListHeaderCell XIU_ClassIdentifier]];
    
    //进入默认显示第一个
    [self clickBtnRequestWithId:1];
    [self requestSixBtn];
    [NSString showHUD:@"" andView:self.view andHUD:self.hud];

 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 130 * SCREEN_SCALE : 440 * SCREEN_SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MD_SelectStockListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SelectStockListHeaderCell XIU_ClassIdentifier]];
        cell.delegate = self;
        [cell setHeaderData:self.headerArr];
        return cell;
    }
    MD_SelectStockListMainCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SelectStockListMainCell XIU_ClassIdentifier]];
    [cell setHeaderDic:self.mainCellDic];
    cell.delegate = self;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)clickChooseStock {

    MD_SelectStockDetialVC *vc = [[MD_SelectStockDetialVC alloc]init];
    vc.Id = typeid;
    vc.DecriptionName = typeName;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestSixBtn {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_ChooseStock withParams:@{@"APPID":APPID, @"timestamp":XIU_Timestamp, @"signed":XIU_Signed} withMethodType:Post andBlock:^(id data, NSError *error) {
    //看接口你能哭
        NSArray *arr = [data objectForKey:@"ChooseStocks"];
        for (NSDictionary *dic in arr) {
            MD_SelectStockKLineDateModel *model = [[MD_SelectStockKLineDateModel alloc] init];
            model.Id = [dic objectForKey:@"Id"];
            model.Imgs = [dic objectForKey:@"Imgs"];
            [self.headerArr addObject:model];
            
        }
        
        [self.hud hide:YES];
        [self.XIUTableView reloadData];
    }];
}


#pragma mark  click top six btn delegate
- (void)clickSixBtn:(UIButton *)btn {

    [self clickBtnRequestWithId:btn.tag + 1];
    
}

- (void)clickBtnRequestWithId:(NSInteger)Id {
    //    btn.tag 即为Id值
    typeid = Id;
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_ChooseStockForId withParams:@{@"id":[NSNumber numberWithInteger:typeid]} withMethodType:Post andBlock:^(id data, NSError *error) {
        [self.mainCellDic removeAllObjects];
        
        [self.mainCellDic setObject:[data objectForKey:@"WeekIncome"] forKey:@"WeekIncome"];
        [self.mainCellDic setObject:[data objectForKey:@"MonthIncome"] forKey:@"MonthIncome"];
        [self.mainCellDic setObject:[data objectForKey:@"Hs300All"] forKey:@"Hs300All"];
        [self.mainCellDic setObject:[data objectForKey:@"IncomeAll"] forKey:@"IncomeAll"];
         [self.mainCellDic setObject:[data objectForKey:@"Description"] forKey:@"Description"];
        [self.mainCellDic setObject:[data objectForKey:@"Day"] forKey:@"Day"];
        [self.mainCellDic setObject:[data objectForKey:@"Example"] forKey:@"Example"];
        [self.mainCellDic setObject:[data objectForKey:@"NetProfit"] forKey:@"NetProfit"];
        [self.mainCellDic setObject:[data objectForKey:@"Id"] forKey:@"Id"];
        [self.mainCellDic setObject:[data objectForKey:@"Overall"] forKey:@"Overall"];
        [self.mainCellDic setObject:[data objectForKey:@"RefText"] forKey:@"RefText"];
        typeName = data[@"RefText"];
        [self.mainCellDic setObject:[data objectForKey:@"SuccessRate"] forKey:@"SuccessRate"];
        
        [self.XIUTableView reloadData];
        
    }];


}

-(NSMutableArray *)headerArr {
    if (!_headerArr) {
        _headerArr = [NSMutableArray array];
    }
    return _headerArr;
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableDictionary *)mainCellDic {
    if (!_mainCellDic) {
        _mainCellDic = [NSMutableDictionary dictionary];
    }
    return _mainCellDic;
}

-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];
        
    }
    return _hud;
}

@end
