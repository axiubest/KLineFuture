//
//  MD_SelectStockScrollSecondView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockScrollSecondView.h"
#import "Charts-Swift.h"

@interface MD_SelectStockScrollSecondView ()<ChartViewDelegate, IChartAxisValueFormatter>
{
    NSArray *arr2x;
}
@property (nonatomic, strong)LineChartView *chartView;

@end

@implementation MD_SelectStockScrollSecondView


- (void)setData:(NSDictionary *)dic {
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    
    NSArray *arry = dic[@"Hs300"][1];
    NSArray *arrx = dic[@"Hs300"][0];
    for (int i = 0; i < arry.count; i++)
    {

        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:[arrx[i] doubleValue] y:[arry[i] doubleValue]]];
    }
    
    
    NSArray *arr2y = dic[@"IncomeAll"][1];
    arr2x = dic[@"IncomeAll"][0];

    for (int i = 0; i < arr2y.count; i++)
    {
        
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:[arr2x[i] doubleValue] y:[arr2y[i] doubleValue]]];
    }
    
    LineChartDataSet *set1 = nil, *set2 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        
        set1.values = yVals1;
        set2.values = yVals2;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        [set1 setCircleColor:UIColor.clearColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        set2 = [[LineChartDataSet alloc] initWithValues:yVals2 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyRight;
        [set2 setColor:UIColor.redColor];
        [set2 setCircleColor:UIColor.clearColor];
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 65/255.0;
        set2.fillColor = UIColor.redColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set2.drawCircleHoleEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.clearColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _chartView.data = data;
    }

}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {

        _chartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 30, KWIDTH - 15, 200)];
        _chartView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_chartView];
        _chartView.delegate = self;
        _chartView.doubleTapToZoomEnabled = NO;
        _chartView.legend.enabled = NO;
        _chartView.chartDescription.enabled = YES;
        
        
        _chartView.dragEnabled = NO;
        [_chartView setScaleEnabled:YES];
        _chartView.drawGridBackgroundEnabled = NO;
        _chartView.pinchZoomEnabled = YES;
        
        _chartView.backgroundColor = [UIColor whiteColor];
        
        ChartLegend *l = _chartView.legend;
        l.form = ChartLegendFormLine;
        l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        l.textColor = UIColor.clearColor;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
        l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        l.orientation = ChartLegendOrientationHorizontal;
        l.drawInside = NO;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:11.f];
        xAxis.valueFormatter = self;
        xAxis.labelCount = 1;

        xAxis.labelTextColor = [UIColor clearColor];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.drawAxisLineEnabled = NO;
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelTextColor = [UIColor clearColor];
        leftAxis.drawGridLinesEnabled = NO;
        leftAxis.drawZeroLineEnabled = NO;
        leftAxis.drawAxisLineEnabled = NO;
        leftAxis.granularityEnabled = NO;
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.labelTextColor = UIColor.darkGrayColor;
        rightAxis.drawGridLinesEnabled = NO;
        rightAxis.drawAxisLineEnabled = NO;
        
        rightAxis.granularityEnabled = NO;
        
        [_chartView animateWithXAxisDuration:2.5];
 
        
        
        [self setUpDescribtion];

        
    }
    return self;
}

- (void)setUpDescribtion {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 15, 2)];
    v.backgroundColor = [UIColor colorWithHexString:@"FF5e45"];
    [self addSubview: v];
    UILabel *lab  = [[UILabel alloc] initWithFrame:CGRectMake(v.x + v.width + 5, 0, 40, 20)];
    lab.font = NB_FONT(12);
    lab.text = @"收益率";
    lab.textColor = [UIColor colorWithHexString:@"FF5e45"];
    [self addSubview: lab];
    
    
    
    
    UIView *vs = [[UIView alloc] initWithFrame:CGRectMake(10, v.height + 25, 15, 2)];
    vs.backgroundColor = [UIColor colorWithHexString:@"5cb4ff"];
    [self addSubview: vs];
    UILabel *labs  = [[UILabel alloc] initWithFrame:CGRectMake(lab.x, vs.y - 10, 100, 20)];
    labs.font = NB_FONT(12);
    labs.text = @"沪深300涨幅";
    labs.textColor = [UIColor colorWithHexString:@"5cb4ff"];
    [self addSubview: labs];
}

- (void)setData
{
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < 10; i++)
    {
        double mult = 30 / 2.0;
        double val = (double) (arc4random_uniform(mult)) + 50;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    for (int i = 0; i < 10 - 1; i++)
    {
        double mult = 30;
        double val = (double) (arc4random_uniform(mult)) + 45;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    LineChartDataSet *set1 = nil, *set2 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        
        set1.values = yVals1;
        set2.values = yVals2;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        [set1 setCircleColor:UIColor.clearColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        set2 = [[LineChartDataSet alloc] initWithValues:yVals2 label:@"DataSet 2"];
        set2.axisDependency = AxisDependencyRight;
        [set2 setColor:UIColor.redColor];
        [set2 setCircleColor:UIColor.clearColor];
        set2.lineWidth = 2.0;
        set2.circleRadius = 3.0;
        set2.fillAlpha = 65/255.0;
        set2.fillColor = UIColor.redColor;
        set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set2.drawCircleHoleEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.clearColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _chartView.data = data;
    }
}


- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return arr2x[MIN(MAX((int) value, 0), arr2x.count - 1)];
    
}
@end
