//
//  SWLAFN.h
//  washChuangLian
//
//  Created by 单维龙 on 16/3/7.
//  Copyright © 2016年 離去之原. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class NBViewController;

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailedBlock)(NSString *error);

@interface AFN : NSObject

+ (void)postWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters onView:(UIViewController *)view getData:(SuccessBlock)getData failure:(FailedBlock)failure;

+ (void)cancelRequest;

@end
