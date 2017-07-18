//
//  MD_DiagnosisDetialAnimalStockCell.m
//  MDObj
//
//  Created by Apple on 17/6/30.
//  Copyright © 2017年 A_XIU. All rights reserved.
//
#import "MD_DiagnosisDetialAnimalStockCell.h"
#import "YKLineChart.h"
#import "MD_SelectStockKLineDateModel.h"
@interface MD_DiagnosisDetialAnimalStockCell ()<YKLineChartViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *dateStartLab;
@property (weak, nonatomic) IBOutlet UILabel *dateEndLab;

@property (weak, nonatomic) IBOutlet YKLineChartView *stockKLineView;


@property (weak, nonatomic) IBOutlet UIView *lineAnimationView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end

@implementation MD_DiagnosisDetialAnimalStockCell


//数据源赋值
- (void)setDataWithModel:(MD_DiagnosisDetialModel *)model {
    _titleLab.text =[NSString stringWithFormat:@"%@(%@)", model.StockName, model.Code];
    _dateStartLab.text = model.detialSelfModel.DateStart;
    _dateEndLab.text = model.detialSelfModel.DateEnd;

    
    [self setLineValueWithData:[model.detialSelfModel.Ks copy]];
    

    _mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mainView.layer.borderWidth = 0.5;
    NSArray *arr = model.FutureDatas;


    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    
    [path moveToPoint:CGPointMake(0, 70)];
    
    if (model.FutureDatas.count == 15) {
        
        for (int i = 0; i < 15; i++ ) {
            if ((i == 14 ? arr[i] : arr[i + 1]) > arr[i]) {
                NSLog(@"--%@", arr[i]);
                
              CGPoint point = CGPointMake(0 + i * (_lineAnimationView.width / 15), 70 *SCREEN_SCALE + [arr[i] floatValue]);
                [path addLineToPoint:point];

            }else {
                CGPoint point = CGPointMake(0 + i * (_lineAnimationView.width / 15), 70 *SCREEN_SCALE - [arr[i] floatValue]);
                [path addLineToPoint:point];
            }
        }
    }
    

    [path stroke];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    layer.strokeColor = [UIColor colorWithHexString:@"FF5F45"].CGColor;
    
    [self.lineAnimationView.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 2;
    [layer addAnimation:animation forKey:nil];
}
- (void)awakeFromNib {
    [super awakeFromNib];


}

- (void)setLineValueWithData:(NSArray *)data {
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
