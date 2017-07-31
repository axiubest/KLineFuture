//
//  YYTimeLineModel.m
//  投融宝
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import "YYTimeLineModel.h"
#import <CoreGraphics/CoreGraphics.h>
@implementation YYTimeLineModel
{
    NSDictionary * _dict;
    NSString *nowPrice;
    NSString *volume;
    NSString *DayDatail;
}

- (NSString *)TimeDesc {
    if( [_dict[@"time"] isEqualToString:@"11:30"]) {
        return @"11:30/13:00";
    } else if( [_dict[@"time"] isEqualToString:@"15:00"]) {
        return @"15:00";
    } else {
        return _dict[@"time"];
    }
}

- (NSString *)DayDatail {
    
    return _dict[@"time"];
   
                  
    
}

//前一天的收盘价
- (CGFloat )AvgPrice {
    return [_dict[@"avgPrice"] floatValue];
}

- (NSNumber *)nowPrice {
    return _dict[@"nowPrice"];
}

- (CGFloat)volume {
    return [_dict[@"volume"] floatValue]/100.f;
}

- (BOOL)isShowTimeDesc {
    //9:30-11:30,13:00-15:00
    //11:30和13:00挨在一起，显示一个就够了
    //最后一个服务器返回的minute不是960,故只能特殊处理
    return [_dict[@"minute"] integerValue] == 570 ||  [_dict[@"time"] integerValue] == 780 ||  [_dict[@"index"] integerValue] == 240;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        nowPrice = _dict[@"nowPrice"];
        
        volume = _dict[@"volume"];
    }
    return self;
}

@end
