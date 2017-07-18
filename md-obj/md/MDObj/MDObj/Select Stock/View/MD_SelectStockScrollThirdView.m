//
//  MD_SelectStockScrollThirdView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockScrollThirdView.h"

@implementation MD_SelectStockScrollThirdView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, frame.size.height)];
        _imgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imgView];
    }
   return  self;
}

@end
