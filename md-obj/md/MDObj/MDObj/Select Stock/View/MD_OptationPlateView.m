//
//  MD_OptationPlateView.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptationPlateView.h"
#import "MD_OptationPlateCell.h"
#import "MD_QuotationPlateDetialVC.h"
#import "MD_QuotationPlateModel.h"

#import "MD_QuotationMoreVC.h"

static NSString *xorder = @"DESC";
@interface MD_OptationPlateView ()<UITableViewDelegate, UITableViewDataSource,MD_OptationPlateCellDelegate>

@property (nonatomic, strong)UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataSource2;
@property (nonatomic, strong) XIU_ViewController *baseVC;
@end
@implementation MD_OptationPlateView

/**
 板块
 */
-(instancetype)initWithFrame:(CGRect)frame Controller:(XIU_ViewController *)VC{
    _baseVC = VC;
    if (self = [super initWithFrame:frame]) {
        _XIUTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, self.size.height) style:UITableViewStyleGrouped];
        _XIUTableView.delegate = self;
        _XIUTableView.dataSource = self;
        _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
        [self addSubview:_XIUTableView];
        [_XIUTableView registerNib:[MD_OptationPlateCell XIU_ClassNib] forCellReuseIdentifier:[MD_OptationPlateCell XIU_ClassIdentifier]];
        [self request:0 Order:xorder];
        [self request:1 Order:xorder];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180 *SCREEN_SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MD_OptationPlateCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_OptationPlateCell XIU_ClassIdentifier]];
    cell.delegate = self;
    if (indexPath.section == 0) {
        [cell setData:self.dataSource];
        
    }if (indexPath.section == 1) {
        [cell setData:self.dataSource2];
        
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 0 ? [self createHeaderUIWithName:@"行业板块" Section:section] : [self createHeaderUIWithName:@"概念板块" Section:section];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)createHeaderUIWithName:(NSString *)name Section:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 30)];
    UIView *img = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 4, view.height - 10)];
    img.backgroundColor = [UIColor colorWithHexString:@"378AD6"];
    [view addSubview:img];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = name;
    lab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [view addSubview:lab];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"price_btn_more"] forState:UIControlStateNormal];
    btn.tag = section;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(clcikMore:) forControlEvents:UIControlEventTouchUpInside];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).with.offset(10);
        make.centerY.equalTo(img);
        make.size.mas_equalTo(CGSizeMake(80,18));
        
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(15,13));
        make.right.equalTo(view).with.offset(-20);
    }];
    return view;
}

- (void)clcikMore:(UIButton *)sender {
    
    MD_QuotationMoreVC *v = [[MD_QuotationMoreVC alloc] init];
    v.type = sender.tag;
    [_baseVC.navigationController pushViewController:v animated:YES];
    
    
}
- (void)request:(NSInteger)type Order:(NSString *)order{
    
    //0行业  1 概念
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_GetStockBlockList withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"type":[NSNumber numberWithInteger:type],@"nowPage":@"1",@"pageSize":@"10",@"field":@"diff_money", @"order":order} withMethodType:Post andBlock:^(id data, NSError *error) {
        NSArray *arr = [data objectForKey:@"List"];
        
        if (type == 0) {
            
            for (NSDictionary *dic in arr) {
                MD_QuotationPlateModel *model = [[MD_QuotationPlateModel alloc] init];
                model.type = 0;//区分行业概念
                model.Code = [dic objectForKey:@"Code"];
                model.Name = [dic objectForKey:@"Name"];
                model.diff_rate =[NSString stringWithFormat:@"%@%%",[NSString MD_StringToFloatWithString:[dic objectForKey:@"diff_rate"]]];
                model.stockName =[NSString MD_StringToFloatWithString:[dic objectForKey:@"stockName"]];
                
                [self.dataSource addObject:model];
            }
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.XIUTableView reloadData];
            });
        }if (type == 1) {
            
            for (NSDictionary *dic in arr) {
                MD_QuotationPlateModel *model = [[MD_QuotationPlateModel alloc] init];
                model.type = 1;
                model.Code = [dic objectForKey:@"Code"];
                model.Name = [dic objectForKey:@"Name"];
                model.diff_rate =[NSString stringWithFormat:@"%@%%",[NSString MD_StringToFloatWithString:[dic objectForKey:@"diff_rate"]]];
                model.stockName =[NSString MD_StringToFloatWithString:[dic objectForKey:@"stockName"]];
                
                [self.dataSource2 addObject:model];
            }
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.XIUTableView reloadData];
            });
        }
        
    }];
}


#pragma mark 点击六个按钮
- (void)clickViewWithTag:(NSInteger)tag {
    MD_QuotationPlateDetialVC *vc = [[MD_QuotationPlateDetialVC alloc] init];
    for (MD_QuotationPlateModel *obj in self.dataSource) {
        if ([[self.dataSource[tag] Code] isEqualToString:[obj Code]]) {
            
        }
    }
    [_baseVC.navigationController pushViewController:vc animated:YES];
    
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)dataSource2 {
    if (!_dataSource2) {
        
        _dataSource2 = [NSMutableArray array];
    }
    return _dataSource2;
}

@end
