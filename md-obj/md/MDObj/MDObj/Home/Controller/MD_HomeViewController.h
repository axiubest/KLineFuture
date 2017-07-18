//
//  MD_HomeViewController.h
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MD_HomeViewController : XIU_ViewController
typedef NS_ENUM(NSInteger, HomeTableViewCellStyle) {
    HomeTableViewCellStyle_Search,
    HomeTableViewCellStyle_DiagnosisStock,
    HomeTableViewCellStyle_SelectStock,
    HomeTableViewCellStyle_Tool,
    HomeTableViewCellStyle_LiveRadio
};
@end

