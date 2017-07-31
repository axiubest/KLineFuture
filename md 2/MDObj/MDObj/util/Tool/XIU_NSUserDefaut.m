//
//  XIU_NSUserDefaut.m
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_NSUserDefaut.h"
#import "MD_OptionalListModel.h"

@implementation XIU_NSUserDefaut


+ (void)addObject:(NSMutableArray *)dic WithObjName:(NSString *)objName {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:objName]) {
    }else {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:objName];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:objName];
    

}

+ (NSMutableArray *)getObjectWithObjName:(NSString *)objName {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:objName]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:objName];
    }
    
    return [NSMutableArray array];
}
@end
