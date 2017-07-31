//
//  MD_DiagnosisDetialModel.h
//  MDObj
//
//  Created by Apple on 17/7/5.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MD_DiagnosisDetialSelfModel.h"

@interface MD_DiagnosisDetialModel : NSObject

@property (nonatomic, strong)MD_DiagnosisDetialSelfModel *detialSelfModel;
@property (nonatomic, strong)MD_DiagnosisDetialSelfModel *detialSectionModel;



@property (nonatomic, strong) NSString *Code, *StockName, *Num, *DayRise, *DayRiseRate, *WeekRise, *WeekRiseRate, *MonthRise, *MonthRiseRate, *QuarterRise, *QuarterRiseRate;

@property (nonatomic, strong)NSMutableArray *FutureDatas;


@end
