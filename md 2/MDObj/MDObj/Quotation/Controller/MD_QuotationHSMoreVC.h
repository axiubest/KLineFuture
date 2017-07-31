//
//  MD_QuotationHSMoreVC.h
//  MDObj
//
//  Created by Apple on 17/6/29.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_HiddenTabBarController.h"


typedef NS_ENUM(NSInteger, MD_StockListStyle) {
    MD_StockListStyle_Up = 0,
    MD_StockListStyle_Down = 1,
    MD_StockListStyle_Change = 3,
    MD_StockListStyle_OK = 5,
};
@interface MD_QuotationHSMoreVC : XIU_HiddenTabBarController

@property (nonatomic, assign)NSInteger type;

@end
