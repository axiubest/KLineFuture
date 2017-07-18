//
//  MD_HomeSearchView.m
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_HomeSearchView.h"

@interface MD_HomeSearchView ()

@property (weak, nonatomic) IBOutlet UIView *SearchView;

@end

@implementation MD_HomeSearchView

-(void)awakeFromNib {
    [super awakeFromNib];
    _SearchView.layer.masksToBounds = YES;
    _SearchView.layer.cornerRadius = 5.f;
}

@end
