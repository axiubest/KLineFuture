//
//  MD_QuotationMoreVC.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_QuotationMoreVC.h"
#import "MD_QuotationMoreListCell.h"
#import "MD_QuotationPlateModel.h"
#import "MJRefresh.h"
static NSInteger xnowPage;

static NSString *xsortField;
static NSString *xsortOrder = @"ASC";
static NSInteger total;
@interface MD_QuotationMoreVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (nonatomic, strong)MBProgressHUD *hud;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIView *segmentView;

//行业概念， 原谅我不愿意查单词
@property (weak, nonatomic) IBOutlet UIButton *segmentHY;
@property (weak, nonatomic) IBOutlet UIButton *segmentGN;
@property (weak, nonatomic) IBOutlet UIView *HYLine;
@property (weak, nonatomic) IBOutlet UIView *GNLine;

@property (weak, nonatomic) IBOutlet UIButton *upPresentBtn;

#define HeaderHeight 30
@end

@implementation MD_QuotationMoreVC


- (IBAction)clickUpOrDownPresentBtn:(id)sender {
    
    [self.dataSource removeAllObjects];
    xnowPage = 1;
    if ([xsortOrder isEqualToString:@"DESC"]) {
        //大在前
        xsortOrder = @"ASC";
        [self request:_type Order:xsortOrder];
        [_upPresentBtn setImage:[UIImage imageNamed:@"price_btn_gray_up"] forState:UIControlStateNormal];
    }else {
        //小在前
        xsortOrder = @"DESC";
        [self request:_type Order:xsortOrder];
        [_upPresentBtn setImage:[UIImage imageNamed:@"price_btn_gray_down"] forState:UIControlStateNormal];

    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_QuotationMoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_QuotationMoreListCell XIU_ClassIdentifier]];
    [cell setModel:self.dataSource[indexPath.row]];
    NSLog(@"%@", self.dataSource[indexPath.row]);
    
    return cell;
}

- (void)addRefresh {
    self.XIUTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        xnowPage+=1;
        
        [self request:_type Order:xsortOrder];

        [self.XIUTableView reloadData];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    xnowPage = 1;
    
    [self addRefresh];
    [self changeSegmentWithTag:_type];
    [self navgationItemTitleWithTag:_type];
    [_XIUTableView registerNib:[MD_QuotationMoreListCell XIU_ClassNib] forCellReuseIdentifier:[MD_QuotationMoreListCell XIU_ClassIdentifier]];
    [self.dataSource removeAllObjects];
    [self request:_type Order:xsortOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSegment:(UIButton *)sender {
    [NSString showHUD:@"" andView:self.view andHUD:self.hud];
    [self navgationItemTitleWithTag:sender.tag];
    [self changeSegmentWithTag:sender.tag];
    [self.dataSource removeAllObjects];
    [self request:sender.tag Order:xsortOrder];
    
  }


- (void)navgationItemTitleWithTag:(NSInteger)tag {
         self.navigationItem.title = tag == 0 ? @"行业板块":@"概念板块";
}

- (void)changeSegmentWithTag:(NSInteger)tag {
    
    for (id obj in self.segmentView.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            if (theButton.tag == tag) {//the btn is select
                [theButton setTitleColor:[UIColor colorWithHexString:@"378AD6"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
                
            }else {
                [theButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
                
            }
        }
    }
    if (tag == 0) {
        //hy
        _GNLine.hidden = YES;
        _HYLine.hidden = NO;
    }else {//1
        //gn
        _GNLine.hidden = NO;
        _HYLine.hidden = YES;
    }

}



- (void)request:(NSInteger)type Order:(NSString *)order{

    [NSString showHUD:@"" andView:self.view andHUD:self.hud];

    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_GetStockBlockList withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"type":[NSNumber numberWithInteger:type],@"nowPage":[NSString stringWithFormat:@"%ld", xnowPage],@"pageSize":@"20",@"field":@"diff_rate", @"order":order} withMethodType:Post andBlock:^(id data, NSError *error) {
       total = (NSInteger)[data objectForKey:@"TotalCount"];
        NSArray *arr = [data objectForKey:@"List"];
        
            for (NSDictionary *dic in arr) {
                MD_QuotationPlateModel *model = [[MD_QuotationPlateModel alloc] init];
                
                model.Name = [dic objectForKey:@"Name"];
                model.diff_rate =[NSString stringWithFormat:@"%@", [NSString XIU_IsEmpty:[dic objectForKey:@"diff_rate"]]];
               model.diff_money =[NSString stringWithFormat:@"%@", [NSString XIU_IsEmpty:[dic objectForKey:@"diff_money"]]];
                model.stockName = [NSString stringWithFormat:@"%@", [NSString XIU_IsEmpty:[dic objectForKey:@"stock_name"]]];
                
                [self.dataSource addObject:model];
            }
        

        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [_hud hide:YES];
             [self.hud removeFromSuperview];
            [self.XIUTableView reloadData];
        });
    }];
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];

    }
    return _hud;
}
@end
