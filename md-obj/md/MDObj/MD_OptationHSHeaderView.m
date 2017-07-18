//
//  MD_OptationHSHeaderView.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptationHSHeaderView.h"
@interface MD_OptationHSHeaderView ()


@end
@implementation MD_OptationHSHeaderView



-(void)awakeFromNib {
    [super awakeFromNib];
    
    
    [_view1 bk_whenTapped:^{
        [_delegate clickHSHeaderViewWithTag:0];
    }];
    [_view2 bk_whenTapped:^{
        [_delegate clickHSHeaderViewWithTag:1];

    }];
    [_view3 bk_whenTapped:^{
        [_delegate clickHSHeaderViewWithTag:2];

    }];
    [_view4 bk_whenTapped:^{
        [_delegate clickHSHeaderViewWithTag:3];

    }];
    [_view5 bk_whenTapped:^{
        [_delegate clickHSHeaderViewWithTag:4];

    }];
    [_view6 bk_whenTapped:^{
        [_delegate clickHSHeaderViewWithTag:5];

    }];
}

@end
