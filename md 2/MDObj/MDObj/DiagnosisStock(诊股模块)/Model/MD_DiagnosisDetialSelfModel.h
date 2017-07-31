//
//  MD_DiagnosisDetialSelfModel.h
//  MDObj
//
//  Created by Apple on 17/7/5.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisDetialSelfModel.h"

@interface MD_DiagnosisDetialSelfModel : NSObject


@property (nonatomic, strong) NSString *Code, *StockName, *Score, *DateStart, *DateEnd;
@property (nonatomic, strong)NSMutableArray *Ks;


@property (nonatomic, strong) NSMutableArray *sectionsArr;
@end
