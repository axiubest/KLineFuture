//
//  MD_DiagnosisDetialVC.h
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_HiddenTabBarController.h"

@interface MD_DiagnosisDetialVC : XIU_HiddenTabBarController
@property (nonatomic, strong) NSString *CodeString;


//弹出诊断结果
- (void)popView;
@end
