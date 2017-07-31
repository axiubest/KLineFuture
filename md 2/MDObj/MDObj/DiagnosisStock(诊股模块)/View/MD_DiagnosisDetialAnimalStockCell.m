//
//  MD_DiagnosisDetialAnimalStockCell.m
//  MDObj
//
//  Created by Apple on 17/6/30.
//  Copyright © 2017年 A_XIU. All rights reserved.
//
#import "MD_DiagnosisDetialAnimalStockCell.h"
#import "MD_SelectStockKLineDateModel.h"
#import "KKChartView.h"
#import "Charts-Swift.h"


@interface MD_DiagnosisDetialAnimalStockCell ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *dateStartLab;
@property (weak, nonatomic) IBOutlet UILabel *dateEndLab;

@property (nonatomic, strong) IBOutlet CandleStickChartView *chartView;



@property (weak, nonatomic) IBOutlet KKChartView *lineAnimationView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic,strong) NSMutableArray *tarr;

@end

@implementation MD_DiagnosisDetialAnimalStockCell


//数据源赋值
- (void)setDataWithModel:(MD_DiagnosisDetialModel *)model {
    _titleLab.text =[NSString stringWithFormat:@"%@(%@)", model.StockName, model.Code];
    _dateStartLab.text = model.detialSelfModel.DateStart;
    _dateEndLab.text = model.detialSelfModel.DateEnd;


    [self setLineValueWithData:[model.detialSelfModel.Ks copy]];

    NSArray *arr = model.FutureDatas;


    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CandleAnimationTime * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        _mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _mainView.layer.borderWidth = 0.5;
        _lineAnimationView.coordinateColor = [UIColor clearColor];
        _lineAnimationView.lineWidth = 2;
        _lineAnimationView.lineColor = [UIColor redColor];
        _lineAnimationView.dataAry = arr;
        _lineAnimationView.isShowGradient = NO;
        _lineAnimationView.gradientColor = @"3xf48";

        
    });
   
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

    _tarr = [NSMutableArray array];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    _chartView.extraTopOffset = 50 *SCREEN_SCALE;

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

- (void)setLineValueWithData:(NSArray *)data {
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < data.count; i++)
    {
//        double mult = 1;
        
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

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}
@end
