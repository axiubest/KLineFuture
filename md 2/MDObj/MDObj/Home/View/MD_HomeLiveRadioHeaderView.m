//
//  MD_HomeLiveRadioHeaderView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_HomeLiveRadioHeaderView.h"

@implementation MD_HomeLiveRadioHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 28, 28)];
        img.image = [UIImage imageNamed:@"home_icon_live"];
        [self addSubview:img];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(img.x + img.width + 5, img.y, 150, img.height)];
        lab.text = @"投顾直播";
        lab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [self addSubview:lab];
        
        UILabel *moreLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 15 - 80, lab.y, 80, lab.height)];
        moreLab.textAlignment  = NSTextAlignmentRight;
        moreLab.text = @"更多 >";
        moreLab.font = [UIFont systemFontOfSize:13];
        moreLab.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:moreLab];
        
    }
    return self;
}

@end
