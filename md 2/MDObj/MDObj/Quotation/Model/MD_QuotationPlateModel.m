//
//  MD_QuotationPlateModel.m
//  MDObj
//
//  Created by Apple on 17/6/23.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_QuotationPlateModel.h"

@implementation MD_QuotationPlateModel


-(void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
     [super setValue:value forKey:key];
}
@end
