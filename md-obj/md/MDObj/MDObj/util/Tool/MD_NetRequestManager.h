//
//  MD_NetRequestManager.h
//  MDObj
//
//  Created by Apple on 17/7/5.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD_NetRequestManager : NSObject

//后期网络请求应集中在此

#pragma mark---- request ofZG

+ (instancetype)sharedManager;

- (void)request_ZGBlock:(void (^)(id data, NSError *error))block;
@end
