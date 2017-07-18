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

@end
@implementation XIU_DiagnosisPopView

- (void)setDataWithModel:(MD_DiagnosisDetialModel *)model {
    NSLog(@"%@", model);
    
    _tomorrowPresentLab.text =[NSString appendingPresentWithString:model.DayRise] ;
    _tomorrowRoseLab.text = [NSString appendingPresentWithString:model.DayRiseRate];
    
    _nextWeekRoseLab.text =[NSString appendingPresentWithString:model.WeekRise];
    _nextWeekRoseLab.text =[NSString appendingPresentWithString:model.WeekRiseRate];
    
    _nextMonthRoseLab.text =[NSString appendingPresentWithString:model.MonthRise];
    _nextMonthRoseLab.text =[NSString appendingPresentWithString:model.MonthRiseRate];
    
    _jiRoseLab.text = [NSString appendingPresentWithString:model.QuarterRise];
    _jiPresentLab.text =[NSString appendingPresentWithString:model.QuarterRiseRate];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8.f;
}

@end
