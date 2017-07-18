//
//  MD_SingleStockNewSegmentView.h
//  MDObj
//
//  Created by Apple on 17/7/14.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MD_SingleStockNewSegmentViewDelegate <NSObject>

- (void)clickNewsSegmentViewButton:(UIButton *)btn;

@end

@interface MD_SingleStockNewSegmentView : UIView

@property (nonatomic, assign) id<MD_SingleStockNewSegmentViewDelegate>delegate;

+ (MD_SingleStockNewSegmentView *)loadSegmentView;
@end
