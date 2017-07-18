//
//  MD_SingleStockChartVC.h
//  MDObj
//
//  Created by Apple on 17/6/27.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SingleStockSegmentAtyle) {
    SingleStockSegmentAtyle_CompanyInfo,
    SingleStockSegmentAtyle_Information,
    SingleStockSegmentAtyle_ResearchReport,//研报
    SingleStockSegmentAtyle_Notice
};

@interface MD_SingleStockChartVC : XIU_HiddenTabBarController
@property (nonatomic, strong) NSString *CodeString;
@property (nonatomic, strong) NSString *CodeName;

@end
