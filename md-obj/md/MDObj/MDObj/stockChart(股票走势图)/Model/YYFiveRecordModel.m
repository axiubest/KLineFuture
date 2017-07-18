//
//  YYFiveRecordModel.m
//  投融宝
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import "YYFiveRecordModel.h"

@implementation YYFiveRecordModel
{
    NSDictionary * _dict;
    NSArray *buyPriceArray;
    NSArray *sellPriceArray;
    NSArray *buyVolumeArray;
    NSArray *sellVolumeArray;
    
}
- (NSArray *)BuyPriceArray {
    return buyPriceArray;
}

- (NSArray *)SellPriceArray {
    return sellPriceArray;
}

- (NSArray *)BuyVolumeArray {
    return buyVolumeArray;
}

- (NSArray *)SellVolumeArray {
    return sellVolumeArray;
}

- (NSArray *)BuyDescArray {
    return @[@"买1",@"买2",@"买3",@"买4",@"买5"];
}

- (NSArray *)SellDescArray {
    return @[@"卖5",@"卖4",@"卖3",@"卖2",@"卖1"];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        
        sellPriceArray = @[
                           [self formatFiveRecordTo2Decimal:dict[@"sell5_m"]],
                           [self formatFiveRecordTo2Decimal:dict[@"sell4_m"]],
                           [self formatFiveRecordTo2Decimal:dict[@"sell3_m"]],
                           [self formatFiveRecordTo2Decimal:dict[@"sell2_m"]],
                           [self formatFiveRecordTo2Decimal:dict[@"sell1_m"]],
                           ];
        
        buyPriceArray = @[
                          [self formatFiveRecordTo2Decimal:dict[@"buy1_m"]],
                          [self formatFiveRecordTo2Decimal:dict[@"buy2_m"]],
                          [self formatFiveRecordTo2Decimal:dict[@"buy3_m"]],
                          [self formatFiveRecordTo2Decimal:dict[@"buy4_m"]],
                          [self formatFiveRecordTo2Decimal:dict[@"buy5_m"]],
                          ];
        
        sellVolumeArray = @[
                            [self formatFiveRecordTo0Decimal:dict[@"sell5_n"]],
                            [self formatFiveRecordTo0Decimal:dict[@"sell4_n"]],
                            [self formatFiveRecordTo0Decimal:dict[@"sell3_n"]],
                            [self formatFiveRecordTo0Decimal:dict[@"sell2_n"]],
                            [self formatFiveRecordTo0Decimal:dict[@"sell1_n"]],
                            ];
        
        buyVolumeArray = @[
                           [self formatFiveRecordTo0Decimal:dict[@"buy1_n"]],
                           [self formatFiveRecordTo0Decimal:dict[@"buy2_n"]],
                           [self formatFiveRecordTo0Decimal:dict[@"buy3_n"]],
                           [self formatFiveRecordTo0Decimal:dict[@"buy4_n"]],
                           [self formatFiveRecordTo0Decimal:dict[@"buy5_n"]],
                           ];
    }
    return self;
}


- (NSString *)formatFiveRecordTo2Decimal:(NSString *)data {
    return [data floatValue] > 0 ? [NSString stringWithFormat:@"%.2f", [data floatValue]] : @"--";
}

- (NSString *)formatFiveRecordTo0Decimal:(NSString *)data {
    return [data floatValue] > 0 ? [NSString stringWithFormat:@"%.0f", [data floatValue]/100.f] : @"--";
}
@end
