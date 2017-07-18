//
//  NSString+MD_HUD.h
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD_HUD)
+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud;
@end
