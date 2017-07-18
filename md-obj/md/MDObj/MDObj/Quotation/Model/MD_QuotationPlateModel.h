//
//  MD_QuotationPlateModel.h
//  MDObj
//
//  Created by Apple on 17/6/23.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD_QuotationPlateModel : NSObject

@property (nonatomic, strong) NSString *Code, *Name, *diff10, *diff20, *diff5, *diff_money, *diff_rate, *fallNum, *riseNum, *stockName, *tradeAmount, *tradeNum, *turnover;

@property (nonatomic, assign) NSInteger type;


@property (nonatomic,strong) NSNumber *Num;//诊股排名数据量key

@end
