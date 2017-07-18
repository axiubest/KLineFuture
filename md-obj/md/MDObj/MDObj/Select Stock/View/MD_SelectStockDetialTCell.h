//
//  MD_SelectStockDetialTCell.h
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_SelectStockDetialModel.h"
#import "MD_SelectStockKLineDateModel.h"
#import "YKLineChart.h"

@interface MD_SelectStockDetialTCell : UITableViewCell<YKLineChartViewDelegate>
@property (weak, nonatomic) IBOutlet YKLineChartView *klineView;

@property (weak, nonatomic) IBOutlet UILabel *stockNameCode;//股票名字代码
@property (weak, nonatomic) UIViewController *controller;
@property (weak, nonatomic) IBOutlet UIButton *quotationBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (void)setValueWithData:(MD_SelectStockDetialModel *)data Controller:(UIViewController *)vc;

@end
