//
//  XIU_NSUserDefaut.h
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XIU_NSUserDefaut : NSObject

+ (void)addObject:(NSMutableArray *)dic WithObjName:(NSString *)objName;
+ (NSMutableArray *)getObjectWithObjName:(NSString *)objName;


@end
