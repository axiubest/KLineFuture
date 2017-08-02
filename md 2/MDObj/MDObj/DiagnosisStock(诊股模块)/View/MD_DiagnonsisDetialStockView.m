//
//  MD_DiagnonsisDetialStockView.m
//  MDObj
//
//  Created by Apple on 17/7/6.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnonsisDetialStockView.h"

#import "MD_SelectStockKLineDateModel.h"
#import "Charts-Swift.h"


@interface MD_DiagnonsisDetialStockView ()<ChartViewDelegate>

@property (nonatomic, strong) IBOutlet CandleStickChartView *chartView;
@property (nonatomic,strong) NSMutableArray *tarr;


@end

@implementation MD_DiagnonsisDetialStockView


-(void)awakeFromNib {
    [super awakeFromNib];
    _tarr = [NSMutableArray array];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    _chartView.extraTopOffset = 50 *SCREEN_SCALE;
    _chartView.scaleYEnabled = NO;//取消Y轴缩放
    _chartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    _chartView.dragEnabled = NO;//启用拖拽图表
    _chartView.maxVisibleCount = 60;
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    [_chartView animateWithXAxisDuration:CandleAnimationTime];
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.enabled = NO;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.enabled = NO;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = NO;
    
    _chartView.legend.enabled = NO;

}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}




- (void)setData:(NSArray *)data {
    
    _layerIView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.4];
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < data.count; i++)
    {
        
        double high = [[data[i] MaxPrice] doubleValue] * 10;
        double low = [[data[i] MinPrice] doubleValue] * 10;
        double open = [[data[i] OpenPrice] doubleValue] * 10;
        double close = [[data[i] ClosePrice] doubleValue] * 10;
        
        [yVals1 addObject:[[CandleChartDataEntry alloc] initWithX:i shadowH:high shadowL:low open:open close: close icon: [UIImage imageNamed:@"icon"]]];
    }
    
    CandleChartDataSet *set1 = [[CandleChartDataSet alloc] initWithValues:yVals1 label:@"Data Set"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithWhite:80/255.f alpha:1.f]];
    
    set1.drawIconsEnabled = NO;
    
    set1.shadowColor = UIColor.darkGrayColor;
    set1.shadowWidth = 0.7;
    set1.decreasingColor = [UIColor colorWithHexString:@"1cb54a"];
    set1.decreasingFilled = YES;
    set1.increasingColor = [UIColor colorWithHexString:@"ff5e45"];//颜色
    set1.increasingFilled = YES;
    set1.neutralColor = UIColor.blueColor;
    set1.shadowColorSameAsCandle = YES;
    set1.valueTextColor = [UIColor clearColor];
    CandleChartData *datas = [[CandleChartData alloc] initWithDataSet:set1];
    
    _chartView.data = datas;


}
@end
