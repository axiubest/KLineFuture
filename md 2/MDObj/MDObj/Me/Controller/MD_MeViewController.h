//
//  MD_MeViewController.h
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MD_MeViewController : XIU_ViewController
typedef NS_ENUM(NSInteger, CellInformationStyle) {
    CellInformationStyle_MyInformation,//我的信息
    CellInformationStyle_Phone,//手机绑定
    CellInformationStyle_Custom,//自定义cell
    CellInformationStyle_Setting//设置
};

@property (nonatomic, assign) CellInformationStyle cellStyle;
@end
