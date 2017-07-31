//
//  MD_HomeHeaderView.m
//  MDObj
//
//  Created by Apple on 2017/7/31.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_HomeHeaderView.h"

@interface MD_HomeHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation MD_HomeHeaderView

-(void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.cornerRadius = 5.f;
    _bgView.layer.masksToBounds = YES;
    _bgImageView.userInteractionEnabled = YES;
    
}

@end
