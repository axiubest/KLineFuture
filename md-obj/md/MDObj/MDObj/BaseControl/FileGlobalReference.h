//
//  FileGlobalReference.h
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#ifndef FileGlobalReference_h
#define FileGlobalReference_h

#import "XIU_ViewController.h"
#import "XIU_HiddenTabBarController.h"
#import "Masonry.h"
#import "XIU_User.h"
#import "XIU_Login.h"
#import "XIU_NetAPIClient.h"
#import "MBProgressHUD.h"
#import "API.h"
#import "XIU_NSUserDefaut.h"
#import "MD_NetRequestManager.h"

#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "UIView+BlocksKit.h"
#import "UIView+Common.h"
#import "NSString+Common.h"
#import "UILabel+AutoLabelHeight.h"
#import "NSString+MD_HUD.h"
#import "MD_RequestManager.h"

#endif /* FileGlobalReference_h */

#define ERROR_HUD(MSG) MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
errorHud.mode = MBProgressHUDModeText; \
errorHud.labelText= MSG; \
errorHud.removeFromSuperViewOnHide = YES; \
 [errorHud hide:YES afterDelay:1.5];;



