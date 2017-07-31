//
//  YYLineDataModel.m
//  投融宝
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import "YYLineDataModel.h"
@interface YYLineDataModel()

/**
 持有字典数组，用来计算ma值
 */
@property (nonatomic, strong) NSArray *parentDictArray;
@end
@implementation YYLineDataModel
{
    NSDictionary * _dict;
    NSString *Close;
    NSString *Open;
    NSString *Low;
    NSString *High;
    NSString *Volume;
    NSNumber *MA5;
    NSNumber *MA10;
    NSNumber *MA20;
    NSString *Day;
    NSString *volume;
    NSString *DayDatail;
}



- (NSString *)Day {
    return [NSString stringWithFormat:@"%@", _dict[@"date"]];
    
    //    NSString *day = [_dict[@"day"] stringValue];
    //    return [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
    //
    //    if (self.parentDictArray.count % 5 == ([self.parentDictArray indexOfObject:_dict] + 1 )%5 ) {
    //        return [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
    //    }
    //    return @"";
}

- (NSString *)DayDatail {
    
    //后台接口改
//    NSString *day = [_dict[@"date"] stringValue];
//    return [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
    return _dict[@"date"];
}

- (id<YYLineDataModelProtocol>)preDataModel {
    if (_preDataModel != nil) {
        return _preDataModel;
    } else {
        return [[YYLineDataModel alloc]init];
    }
}

- (NSNumber *)Open {
    //    NSLog(@"%i",[[_dict[@"day"] stringValue] hasSuffix:@"01"]);
    return _dict[@"openPrice"];
}

- (NSNumber *)Close {
    return _dict[@"closePrice"];
}

- (NSNumber *)High {
    return _dict[@"todayMax"];
}

- (NSNumber *)Low {
    return _dict[@"todayMin"];
}

- (CGFloat)Volume {
    return [_dict[@"tradeNum"] floatValue]/100.f;
}

- (CGFloat)volume {
    return [_dict[@"tradeNum"] floatValue]/100.f;

}

- (BOOL)isShowDay {
    return self.showDay.length > 0;
    //    return [[_dict[@"day"] stringValue] hasSuffix:@"01"];
}

- (NSNumber *)MA5 {
    return MA5;
}

- (NSNumber *)MA10 {
    return MA10;
}

- (NSNumber *)MA20 {
    return MA20;
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        Close = _dict[@"closePrice"];
        Open = _dict[@"openPrice"];
        High = _dict[@"todayMax"];
        Low = _dict[@"todayMin"];
        Volume = _dict[@"tradeNum"];
        volume = _dict[@"tradeNum"];
        Day = [NSString stringWithFormat:@"%@", _dict[@"date"]];
        
//        NSString *day = [_dict[@"day"] stringValue];
//        DayDatail =  [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
        DayDatail = _dict[@"date"];
        
    }
    return self;
}

- (void)updateMA:(NSArray *)parentDictArray {
    _parentDictArray = parentDictArray;
    NSInteger index = [_parentDictArray indexOfObject:_dict];
    if (index >= 4) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-4, 5)];
        CGFloat average = [[[array valueForKeyPath:@"closePrice"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA5 = @(average);
    } else {
        MA5 = @0;
    }
    
    if (index >= 9) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-9, 10)];
        CGFloat average = [[[array valueForKeyPath:@"closePrice"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA10 = @(average);
    } else {
        MA10 = @0;
    }
    
    if (index >= 19) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-19, 20)];
        CGFloat average = [[[array valueForKeyPath:@"closePrice"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA20 = @(average);
    } else {
        MA20 = @0;
    }
    
}

@end
