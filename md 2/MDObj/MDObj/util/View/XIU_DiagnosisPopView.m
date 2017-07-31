//
//  XIU_DiagnosisPopView.m
//  MDObj
//
//  Created by Apple on 17/7/7.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_DiagnosisPopView.h"


@interface XIU_DiagnosisPopView ()

@property (weak, nonatomic) IBOutlet UILabel *tomorrowPresentLab;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowRoseLab;

@property (weak, nonatomic) IBOutlet UILabel *nextWeekPresentLab;
@property (weak, nonatomic) IBOutlet UILabel *nextWeekRoseLab;

@property (weak, nonatomic) IBOutlet UILabel *nextMonthPresentLab;
@property (weak, nonatomic) IBOutlet UILabel *nextMonthRoseLab;

@property (weak, nonatomic) IBOutlet UILabel *jiPresentLab;
@property (weak, nonatomic) IBOutlet UILabel *jiRoseLab;


@property (weak, nonatomic) IBOutlet UILabel *t1;
@property (weak, nonatomic) IBOutlet UILabel *tt1;

@property (weak, nonatomic) IBOutlet UILabel *t2;
@property (weak, nonatomic) IBOutlet UILabel *tt2;

@property (weak, nonatomic) IBOutlet UILabel *t3;
@property (weak, nonatomic) IBOutlet UILabel *tt3;

@property (weak, nonatomic) IBOutlet UILabel *t4;
@property (weak, nonatomic) IBOutlet UILabel *tt4;
@end
@implementation XIU_DiagnosisPopView

- (void)setDataWithModel:(MD_DiagnosisDetialModel *)model {
    
    _tomorrowPresentLab.text =[NSString appendingPresentWithString:model.DayRise] ;

    _tomorrowRoseLab.text = [NSString appendingPresentWithString:model.DayRiseRate];
    if ([_tomorrowPresentLab.text hasPrefix:@"-"]) {
        _tomorrowPresentLab.textColor = [UIColor colorWithHexString:@"1CB54A"];
        _t1.text = @"下跌概率";
        _tt1.text = @"跌幅";
    }else {
           _tomorrowPresentLab.textColor = [UIColor colorWithHexString:@"FF5E45"];
        _t1.text = @"上涨概率";
        _tt1.text = @"涨幅";
    }
    _tomorrowRoseLab.textColor =  _tomorrowPresentLab.textColor;

    
    
    _nextWeekPresentLab.text =[NSString appendingPresentWithString:model.WeekRise];
    _nextWeekRoseLab.text =[NSString appendingPresentWithString:model.WeekRiseRate];
    if ([_nextWeekPresentLab.text hasPrefix:@"-"]) {
        _nextWeekPresentLab.textColor =  [UIColor colorWithHexString:@"1CB54A"];
        _t2.text = @"下跌概率";
        _tt2.text = @"跌幅";
    }else {
        _nextWeekPresentLab.textColor =  [UIColor colorWithHexString:@"FF5E45"];
        _t2.text = @"上涨概率";
        _tt2.text = @"涨幅";
    }
    _nextWeekRoseLab.textColor = _nextWeekPresentLab.textColor;
    
    
    
    
    _nextMonthPresentLab.text =[NSString appendingPresentWithString:model.MonthRise];
    _nextMonthRoseLab.text =[NSString appendingPresentWithString:model.MonthRiseRate];
    if ([_nextMonthPresentLab.text hasPrefix:@"-"]) {
        _nextMonthPresentLab.textColor =  [UIColor colorWithHexString:@"1CB54A"];
        _t3.text = @"下跌概率";
        _tt3.text = @"跌幅";
    }else {
        _nextMonthPresentLab.textColor =  [UIColor colorWithHexString:@"FF5E45"];
        _t3.text = @"上涨概率";
        _tt3.text = @"涨幅";
    }
    _nextMonthRoseLab.textColor = _nextMonthPresentLab.textColor;

    
    
    
    
    _jiPresentLab.text = [NSString appendingPresentWithString:model.QuarterRise];
    _jiRoseLab.text =[NSString appendingPresentWithString:model.QuarterRiseRate];
    if ([_jiPresentLab.text hasPrefix:@"-"]) {
        _jiPresentLab.textColor =  [UIColor colorWithHexString:@"1CB54A"];
        _t4.text = @"下跌概率";
        _tt4.text = @"跌幅";
    }else {
        _jiPresentLab.textColor =  [UIColor colorWithHexString:@"FF5E45"];
        _t4.text = @"上涨概率";
        _tt4.text = @"涨幅";
    }
    _jiRoseLab.textColor = _jiPresentLab.textColor;

}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8.f;
}

@end
