//
//  MD_DiagnonsisDetialStockView.m
//  MDObj
//
//  Created by Apple on 17/7/6.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnonsisDetialStockView.h"
#import "YKLineChart.h"
#import "MD_SelectStockKLineDateModel.h"
@implementation MD_DiagnonsisDetialStockView


- (void)setData:(NSArray *)data {
    
    _layerIView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.4];
    NSMutableArray * array = [NSMutableArray array];
    
    for (MD_SelectStockKLineDateModel * dic in data) {
        
        
        YKLineEntity * entity = [[YKLineEntity alloc]init];
        entity.high = [dic.MaxPrice doubleValue];
        entity.open = [dic.OpenPrice doubleValue];
        
        entity.low = [dic.MinPrice doubleValue];
        
        entity.close = [dic.ClosePrice doubleValue];
        
        entity.date = @"";
        //        entity.ma5 =  [dic[@"avg5"] doubleValue];
        //        entity.ma10 = [dic[@"avg10"] doubleValue];
        //        entity.ma20 = [dic[@"avg20"] doubleValue];
        entity.Volume = [dic.TradeNum doubleValue];
        [array addObject:entity];
    }
    
    YKLineDataSet * dataset = [[YKLineDataSet alloc]init];
    dataset.data = array;
    dataset.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    dataset.highlightLineWidth = 0.7;
    dataset.candleRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
    dataset.candleFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];
    dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];
    dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];
    dataset.candleTopBottmLineWidth = 1;
    
    [self.stockKLineView setupChartOffsetWithLeft:0 top:50 right:0 bottom:0];
    self.stockKLineView.gridBackgroundColor = [UIColor whiteColor];
    self.stockKLineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
    self.stockKLineView.borderWidth = .5;
    self.stockKLineView.candleWidth = 12;
    self.stockKLineView.candleMaxWidth = 30;
    self.stockKLineView.candleMinWidth = 1;
    self.stockKLineView.uperChartHeightScale = 0.7;
    self.stockKLineView.xAxisHeitht = 25;
    self.stockKLineView.delegate = self;
    self.stockKLineView.highlightLineShowEnabled = YES;
    self.stockKLineView.zoomEnabled = YES;
    self.stockKLineView.scrollEnabled = YES;
    [self.stockKLineView setupData:dataset];
    
 
}
@end
