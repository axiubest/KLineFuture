//
//  XIU_MyCenterUserHeaderView.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/9.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_MyCenterUserHeaderView.h"

@interface XIU_MyCenterUserHeaderView ()


@end

@implementation XIU_MyCenterUserHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if ([XIU_Login isLogin]) {
            [self setUpUIWithUserInfoFrame:frame];
        }else {
            [self setUpUIWithLogin:frame];
        }
    }
    return self;
}


- (void)setUpUIWithLogin:(CGRect)frame {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:backView];
    [backView bk_whenTapped:^{
        [_XIUDelegate pushToLogin];
    }];
    
    
    UIImageView *headerImage = [[UIImageView alloc] init];

    [headerImage setImage:[UIImage imageNamed:@"my_avatar_nor"]];
    headerImage.backgroundColor = [UIColor grayColor];
    [backView addSubview:headerImage];
    
    UILabel *nameLab = [[UILabel alloc] init];
   

    
    nameLab.font = NB_FONT(18);
    nameLab.textColor = [UIColor colorWithHexString:@"#999999"];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nameLab];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"EBEBF2"];
    [backView addSubview:view];
    
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).with.offset(50);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImage.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(backView).with.offset(0);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).with.offset(0);
        make.left.and.right.equalTo(backView).with.offset(0);
        make.height.equalTo(@10);
    }];

}

- (void)setUpUIWithUserInfoFrame:(CGRect)frame {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:backView];

    
    
    UIImageView *headerImage = [[UIImageView alloc] init];
    [headerImage setImage:[UIImage imageNamed:@"my_avatar_nor"]];
    [backView addSubview:headerImage];
    
    UILabel *nameLab = [[UILabel alloc] init];
    if ([XIU_Login isMobile]) {
        nameLab.text =  [XIU_Login userMobile];
        nameLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }else {
        nameLab.text = @"dsfdghjhfds";
    }
    nameLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nameLab];
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"EBEBF2"];
    [backView addSubview:view];

    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).with.offset(50);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_offset(CGSizeMake(50, 50));
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImage.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(backView).with.offset(0);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).with.offset(0);
        make.left.and.right.equalTo(backView).with.offset(0);
        make.height.equalTo(@10);
    }];
}

@end
