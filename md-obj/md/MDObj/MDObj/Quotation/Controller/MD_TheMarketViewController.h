//
//  MD_TheMarketViewController.h
//  MDObj
//
//  Created by Apple on 17/7/3.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_HiddenTabBarController.h"

@interface MD_TheMarketViewController : XIU_HiddenTabBarController
@property (nonatomic, strong) NSString *CodeString;
@property (nonatomic, strong) NSString *CodeName;

@property (nonatomic, assign) NSInteger type;
@end
