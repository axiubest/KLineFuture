//
//  MD_QuotationViewController.h
//  MDObj
//
//  Created by Apple on 17/6/20.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_ViewController.h"


typedef NS_ENUM(NSUInteger, QuotationStyle) {
    QuotationStyle_Up,//涨幅
    QuotationStyle_Down,//跌幅
    QuotationStyle_FiveMinute,//五分钟快速涨幅
    QuotationStyle_Change,//换手率
    QuotationStyle_NumPresent,//量比
    QuotationStyle_OK//成交额
};

@interface MD_QuotationViewController : XIU_ViewController

@end
