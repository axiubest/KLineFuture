//
//  MD_OptationHSGroupHeaderView.h
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_QuotationHSExpandGroupModel.h"


@protocol MD_OptationHSGroupHeaderViewDelegate <NSObject>

- (void)clickGroupWithButton:(UIButton *)btn;

@end
@interface MD_OptationHSGroupHeaderView : UIView

-(instancetype)initWithFrame:(CGRect)frame Model:(MD_QuotationHSExpandGroupModel *)model Section:(NSInteger)section;
@property (nonatomic, assign)id<MD_OptationHSGroupHeaderViewDelegate> delegate;

@end
