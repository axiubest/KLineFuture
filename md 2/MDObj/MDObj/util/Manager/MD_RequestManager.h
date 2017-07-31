//
//  MD_RequestManager.h
//  MDObj
//
//  Created by Apple on 17/7/17.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD_RequestManager : NSObject

+ (instancetype)sharedManager;
#pragma mark----日线 数据
- (void)request_KlineOfDayWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

#pragma mark----月线 数据
- (void)request_KlineOfMonthWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

#pragma mark----周线 数据
- (void)request_KlineOfWeekWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

#pragma mark ---- 公司概况
- (void)request_KlineCompanyInfoCodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

//更多-日
- (void)request_MoreKlineOfDayWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

//更多-周
- (void)request_MoreKlineOfWeekWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

//更多-yeu
- (void)request_MoreKlineOfMonthWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block;

@end
