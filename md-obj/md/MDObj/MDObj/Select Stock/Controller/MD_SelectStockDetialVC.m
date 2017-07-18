//
//  MD_SelectStockDetialVC.m
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockDetialVC.h"
#import "MD_SelectStockDetialTCell.h"
#import "MD_SelectStockHeaderView.h"
#import "MD_SingleStockChartVC.h"
#import "MD_SelectStockDetialModel.h"
#import "MD_SelectStockKLineDateModel.h"
#import "MD_LoginViewController.h"
@interface MD_SelectStockDetialVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@property (nonatomic, strong)NSMutableArray* dataSource;

@end

@implementation MD_SelectStockDetialVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    self.navigationItem.title = _DecriptionName;
    [_XIUTableView registerNib:[MD_SelectStockDetialTCell XIU_ClassNib] forCellReuseIdentifier:[MD_SelectStockDetialTCell XIU_ClassIdentifier]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_SingleStockChartVC *vc = [[MD_SingleStockChartVC alloc] init];
    vc.CodeString =[NSString stringWithFormat:@"%@", [self.dataSource[indexPath.row] Code]];
    vc.CodeName =[self.dataSource[indexPath.row] Name];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250 * SCREEN_SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_SelectStockDetialTCell *cell  =[tableView dequeueReusableCellWithIdentifier:[MD_SelectStockDetialTCell XIU_ClassIdentifier]];
    [cell setValueWithData:self.dataSource[indexPath.row] Controller:self];
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    MD_SelectStockHeaderView *view = [[NSBundle mainBundle]loadNibNamed:[MD_SelectStockHeaderView XIU_ClassIdentifier] owner:self options:nil].lastObject;
//    view.frame = CGRectMake(0, 0, KWIDTH, 250 * SCREEN_SCALE);
//    [view setDataSourceWithData:self.dataSource Controller:self.XIUTableView];
//    return view;
//    
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 150 * SCREEN_SCALE;
//}

- (void)request {
 
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_XG withParams:@{@"patternId":[NSString stringWithFormat:@"%ld", _Id],@"userId":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        NSArray *arr= [data objectForKey:@"Result"];
        for (NSDictionary *dic in arr) {
            MD_SelectStockDetialModel *model = [[MD_SelectStockDetialModel alloc] init];
            model.Code = [dic objectForKey:@"Code"];
            model.IsAdded = [dic objectForKey:@"IsAdded"];
            model.Name = [dic objectForKey:@"Name"];
            model.SuggestHoldDay = [dic objectForKey:@"SuggestHoldDay"];
            model.UpRate = [dic objectForKey:@"UpRate"];
            model.Up = [dic objectForKey:@"Up"];
            NSMutableArray *lineArr = [NSMutableArray array];
            for (NSDictionary *obj in [dic objectForKey:@"Ks"]) {
                MD_SelectStockKLineDateModel *model = [[MD_SelectStockKLineDateModel alloc] init];
                model.ClosePrice = [obj objectForKey:@"ClosePrice"];
                model.Date = [obj objectForKey:@"Date"];
                model.MaxPrice = [obj objectForKey:@"MaxPrice"];
                model.MinPrice = [obj objectForKey:@"MinPrice"];
                model.OpenPrice = [obj objectForKey:@"OpenPrice"];
                model.TradeNum = [obj objectForKey:@"TradeNum"];
                
                [lineArr addObject:model];
            }
            model.Ks = lineArr;
            [self.dataSource addObject:model];
        }
        
        [self.XIUTableView reloadData];
    }];
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end

