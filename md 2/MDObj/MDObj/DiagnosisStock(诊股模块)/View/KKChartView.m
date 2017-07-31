//
//  KKChartView.m
//  KKChartView
//
//  Created by lk on 2017/5/9.
//  Copyright © 2017年 lukai. All rights reserved.
//


#define KKWidth self.frame.size.width
//#define KKHeight self.frame.size.height
#define KKTop 30
#define KKRight 5


#import "KKChartView.h"
//#import "UIColor+expanded.h"
//#import <objc/runtime.h>
@interface KKChartView ()
@property(nonatomic, strong)UILabel *titilLable;
@end

@implementation KKChartView
{
    NSMutableArray *_pointAry;
    CAShapeLayer *layer;
    CGPoint _endPoint;
    CALayer *baseLayer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _pointAry = [NSMutableArray array];
//        self.marginX = 00;
//        self.marginY = 20;
//        _coordinateColor = [UIColor whiteColor];
//        _lineWidth = 4;
//        _gradientColor = @"0xf38b10";
//        _lineColor = [UIColor yellowColor];
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if (self) {
                _pointAry = [NSMutableArray array];
                self.marginX = 0;
                self.marginY = 20;
                _coordinateColor = [UIColor whiteColor];
                _lineWidth = 4;
                _gradientColor = @"0xf38b10";
                _lineColor = [UIColor yellowColor];
    }
    return self;
}

-(void)kk_drawRect{
    
//    [self.layer removeAllAnimations];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_marginX, KKTop)];
    [path addLineToPoint:CGPointMake(_marginX, KHEIGHT - _marginY)];
    [path moveToPoint:CGPointMake(_marginX, KHEIGHT - _marginY)];
    [path addLineToPoint:CGPointMake(KKWidth - KKRight, KHEIGHT - _marginY)];
    

    if (layer) {
        [layer removeFromSuperlayer];
    }
    layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = _lineWidth;
    layer.strokeColor = _coordinateColor.CGColor;
    [self.layer addSublayer:layer];
    
}

-(void)kk_addLeftBezierPoint{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointFromString(_pointAry.firstObject)];
        
    for (int i=0; i<_pointAry.count; i++) {

        if (i != 0) {
            CGPoint nowPoint = CGPointFromString(_pointAry[i]);
            CGPoint oldPoint = CGPointFromString(_pointAry[i-1]);
            [path addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+oldPoint.x)/2, oldPoint.y) controlPoint2:CGPointMake((nowPoint.x+oldPoint.x)/2, nowPoint.y)];
            
        }
    }
    
    CAShapeLayer *lineLay = [CAShapeLayer new];
    lineLay.path = path.CGPath;
    lineLay.lineWidth = 2;
    lineLay.strokeColor = _lineColor.CGColor;
    lineLay.lineJoin = kCALineJoinRound;
    lineLay.lineCap = kCALineCapRound;
    lineLay.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:lineLay];

    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=3;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [lineLay addAnimation:bas forKey:@"key"];


}

-(void)kk_addGradientLayer{
    

    if (baseLayer) {
        [baseLayer removeFromSuperlayer];
    }//需要删除原来的

}


-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self kk_addLeftBezierPoint];
}
-(void)setLineWidth:(NSInteger)lineWidth{
    _lineWidth = lineWidth;
    [self kk_drawRect];
}
-(void)setCoordinateColor:(UIColor *)coordinateColor{
    _coordinateColor = coordinateColor;
    
    _pointAry = [NSMutableArray array];
    self.marginX = 00;
    self.marginY = 20;
    _coordinateColor = [UIColor whiteColor];
    _lineWidth = 4;
    _gradientColor = @"0xf38b10";
    _lineColor = [UIColor yellowColor];
    [self kk_drawRect];
}

-(void)setDataAry:(NSArray *)dataAry{
    _dataAry = dataAry;
    if (!dataAry || dataAry.count<1) return;
    
    CGFloat max = [self getMaxValueForAry:dataAry];
    for (int i=0; i<dataAry.count; i++) {
        CGFloat value = [dataAry[i] floatValue];
        CGFloat x =_marginX + (KKWidth - _marginX - KKRight)/dataAry.count*(i+1);
        CGFloat y = KHEIGHT-_marginY-(KHEIGHT - _marginY - KKTop)/max*value;
        CGPoint point = CGPointMake(x, y);
        [_pointAry addObject:NSStringFromCGPoint(point)];
        

    }
    [self kk_drawRect];
    [self kk_addLeftBezierPoint];
}
-(void)setIsShowGradient:(BOOL)isShowGradient{
    
    _isShowGradient = isShowGradient;
    
    if (isShowGradient == YES) {
//        [self kk_addGradientLayer];
    }

}
-(void)setGradientColor:(NSString *)gradientColor{
    
    _gradientColor = gradientColor;
    [self kk_addGradientLayer];
}

-(void)showLable:(UIButton *)sender{
    NSInteger i = sender.tag;
    
    if (_titilLable) {
        [_titilLable removeFromSuperview];
        _titilLable = nil;
    }
    
    [self addSubview:self.titilLable];
    self.titilLable.text = _dataAry[i];
    [_titilLable sizeToFit];
    _titilLable.center = CGPointMake(sender.center.x, sender.center.y - _titilLable.frame.size.height);
}

-(CGFloat)getMaxValueForAry:(NSArray *)ary{
    
    CGFloat max = [ary[0] floatValue];
    for (int i=0; i<ary.count; i++) {
        if (max < [ary[i] floatValue]) {
            max = [ary[i] floatValue];
        }
    }
    return max;
}

-(UILabel *)titilLable{
    
    if (_titilLable == nil) {
        _titilLable = [UILabel new];
        _titilLable.font = [UIFont systemFontOfSize:10.0f];
        _titilLable.textColor = _lineColor;
    }
    return _titilLable;
}

@end
