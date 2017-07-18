//
//  MD_DiagnonsisDetialStockView.h
//  MDObj
//
//  Created by Apple on 17/7/6.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKLineChartView.h"
@interface MD_DiagnonsisDetialStockView : UIView<YKLineChartViewDelegate>


@property (weak, nonatomic) IBOutlet YKLineChartView *stockKLineView;
@property (weak, nonatomic) IBOutlet UIView *layerIView;


- (void)setData:(NSArray *)data;
@end
