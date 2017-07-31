//
//  MD_OptationDiagnosisView.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptationDiagnosisView.h"
#import "MD_OptationDiagnosisCell.h"
#import "MD_QuotationPlateModel.h"
#import "MJRefresh.h"
#import "MD_SingleStockChartVC.h"
#import "MD_OptationDiagnosisHeaderView.h"
@interface MD_OptationDiagnosisView ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger pages;
}
@property (nonatomic, strong)UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UIViewController *vc;
@end

@implementation MD_OptationDiagnosisView


-(instancetype)initWithFrame:(CGRect)frame Controller:(UIViewController *)vc{
    if (self = [super initWithFrame:frame]) {
        _vc = vc;
        pages = 1;
        _XIUTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, frame.size.height) style:UITableViewStylePlain];
        _XIUTableView.delegate = self;
        _XIUTableView.dataSource = self;
        
           [self addSubview:_XIUTableView];
        [_XIUTableView registerNib:[MD_OptationDiagnosisCell XIU_ClassNib] forCellReuseIdentifier:[MD_OptationDiagnosisCell XIU_ClassIdentifier]];
        [self requestWithPage:pages];
        [self refresh];
    }
    return self;
}


- (void)refresh {
    self.XIUTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        pages+=1;
        
        [self requestWithPage:pages];
        
    }];
    
    self.XIUTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataSource removeAllObjects];
        pages = 1;
        [self requestWithPage:pages];
        
        [self.XIUTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_SingleStockChartVC *vc = [[MD_SingleStockChartVC alloc] init];
    vc.CodeName = [self.dataSource[indexPath.row] stockName];
     vc.CodeString = [self.dataSource[indexPath.row] Code];
    [_vc.navigationController pushViewController:vc animated:YES];
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MD_OptationDiagnosisCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_OptationDiagnosisCell XIU_ClassIdentifier]];
    
    [cell setData:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
       MD_OptationDiagnosisHeaderView *v =  [[NSBundle mainBundle]loadNibNamed:@"MD_OptationDiagnosisHeaderView" owner:self options:nil].lastObject;
        v.frame = CGRectMake(0, 0, KWIDTH, 30);
        return v;
    }
    return nil;
}



- (void)requestWithPage:(NSInteger)page {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_ZGRanking withParams:@{@"nowPage":[NSString stringWithFormat:@"%ld", pages],@"pageSize":@"20"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        for (NSDictionary *obj in [data objectForKey:@"Result"]) {
            MD_QuotationPlateModel *model = [[MD_QuotationPlateModel alloc] init];
            model.Code = obj[@"Code"];
            model.stockName = obj[@"StockName"];
            model.Num = obj[@"Num"];
            [self.dataSource addObject:model];
        }
        [self.XIUTableView reloadData];
        [self endRefresh];
    }];
}

-(void)endRefresh{
    [self.XIUTableView.mj_header endRefreshing];
    [self.XIUTableView.mj_footer endRefreshing];
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
