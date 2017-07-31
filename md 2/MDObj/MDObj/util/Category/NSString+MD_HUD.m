//
//  NSString+MD_HUD.m
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "NSString+MD_HUD.h"

@implementation NSString (MD_HUD)

+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud {
    [view addSubview:hud];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeIndeterminate;

    hud.color = [UIColor grayColor];
    hud.color = [hud.color colorWithAlphaComponent:1];
    hud.square = YES;
    [hud show:YES];
}
@end
