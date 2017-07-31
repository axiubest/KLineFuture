//
//  MD_SelectStockScrollFirstView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockScrollFirstView.h"
#import "Charts-Swift.h"

@interface MD_SelectStockScrollFirstView ()<ChartViewDelegate, IChartAxisValueFormatter>
{
    NSArray *arr2x;
}
@property (nonatomic, strong)  BarChartView *chartView;
@end
@implementation MD_SelectStockScrollFirstView


- (void)setData:(NSDictionary *)dic {
    [self setChartData:dic];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupBarLineChartView:_chartView];
        
        
        _chartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 200)];
        [self addSubview:_chartView];
        _chartView.delegate = self;
        
        _chartView.extraLeftOffset = 20.f;
        _chartView.extraRightOffset = 20.f;
        _chartView.extraTopOffset = 80.f;
        _chartView.doubleTapToZoomEnabled = NO;
        _chartView.dragEnabled = YES;
        _chartView.drawBarShadowEnabled = NO;
        _chartView.drawValueAboveBarEnabled = YES;
        
        _chartView.chartDescription.enabled = NO;
        
        // scaling can now only be done on x- and y-axis separately
        _chartView.pinchZoomEnabled = NO;
        
        _chartView.drawGridBackgroundEnabled = NO;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.labelFont = [UIFont systemFontOfSize:13.f];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.drawAxisLineEnabled = NO;
        xAxis.labelTextColor = [UIColor lightGrayColor];
        xAxis.labelCount = 5;
        xAxis.centerAxisLabelsEnabled = YES;
        xAxis.granularity = 1.0;
        xAxis.valueFormatter = self;
        
        
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.drawLabelsEnabled = NO;
        leftAxis.spaceTop = 0.25;
        leftAxis.forceLabelsEnabled = NO;
        leftAxis.spaceBottom = 0.25;
        leftAxis.drawAxisLineEnabled = NO;
        leftAxis.drawGridLinesEnabled = NO;
        leftAxis.drawZeroLineEnabled = YES;
        leftAxis.zeroLineColor = UIColor.grayColor;
        leftAxis.zeroLineWidth = 0.7f;
        
        _chartView.legend.enabled = NO;
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.drawLabelsEnabled = YES;
        rightAxis.spaceTop = 0.25;
        rightAxis.forceLabelsEnabled = NO;
        rightAxis.spaceBottom = 0.25;
        rightAxis.drawAxisLineEnabled = NO;
        rightAxis.drawGridLinesEnabled = NO;
        rightAxis.drawZeroLineEnabled = YES;
        rightAxis.zeroLineColor = UIColor.grayColor;
    

        
        
        
        
        
        
        
        MD_SelectStockFirstHeaderView *view = [[NSBundle mainBundle]loadNibNamed:[MD_SelectStockFirstHeaderView XIU_ClassIdentifier] owner:self options:nil].firstObject;
        view.frame = CGRectMake(0, 0, KWIDTH, 60);
        _headerView = view;
        [self addSubview:view];
        
        UIButton *weekBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, view.height, 80, 20)];
         [weekBtn setTitleColor:[UIColor colorWithHexString:@"FF5E45"] forState:UIControlStateNormal];
        weekBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [weekBtn setTitle:@"周收益率" forState:UIControlStateNormal];
        [self addSubview:weekBtn];
        
        CALayer *lay = [CALayer layer];
        lay.frame = CGRectMake(weekBtn.x + weekBtn.width + 2 , weekBtn.y + 4, 0.5, weekBtn.height - 8);
        lay.backgroundColor = [UIColor colorWithHexString:@"999999"].CGColor;
        [self.layer addSublayer:lay];
        
        UIButton *monthBtn = [[UIButton alloc] initWithFrame:CGRectMake(weekBtn.width + weekBtn.x, weekBtn.y, 80, 20)];
        [monthBtn setTitleColor:[UIColor colorWithHexString:@"FF5E45"] forState:UIControlStateNormal];
        monthBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        monthBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [monthBtn setTitle:@"月收益率" forState:UIControlStateNormal];
        [self addSubview:monthBtn];
        
    }
    return self;
}


- (void)setChartData:(NSDictionary *)dic
{
    // THIS IS THE ORIGINAL DATA YOU WANT TO PLOT

    NSMutableArray<BarChartDataEntry *> *values = [[NSMutableArray alloc] init];
    NSMutableArray<UIColor *> *colors = [[NSMutableArray alloc] init];
    NSMutableArray *textColor = [NSMutableArray array];
    
    UIColor *green = [UIColor colorWithRed:110/255.f green:190/255.f blue:102/255.f alpha:1.f];
    UIColor *red = [UIColor colorWithRed:211/255.f green:74/255.f blue:88/255.f alpha:1.f];
    
    
    NSArray *arr2y = dic[@"WeekIncome"][1];
    arr2x = dic[@"WeekIncome"][0];
    for (int i = 0; i < arr2y.count; i++)
    {
        [textColor addObject:[UIColor clearColor]];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:[arr2y[i] doubleValue]];
        [values addObject:entry];
        
        // specific colors
        if ([arr2y[i] doubleValue]>= 0.f)
        {
            [colors addObject:red];
        }
        else
        {
            [colors addObject:green];
        }
    }
    
    BarChartDataSet *set = set = [[BarChartDataSet alloc] initWithValues:values label:@"Values"];
    set.colors = colors;
    set.valueColors = textColor;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    [data setValueFont:[UIFont systemFontOfSize:13.f]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 1;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    
    data.barWidth = 0.8;
    
    _chartView.data = data;
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView
{
    chartView.chartDescription.enabled = NO;
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;
    
    // ChartYAxis *leftAxis = chartView.leftAxis;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return arr2x[MIN(MAX((int) value, 0), arr2x.count - 1)];
    
}
@end
