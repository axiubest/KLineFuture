//
//  MD_LargeLimitSelectCell.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_LargeLimitSelectCell.h"

@interface MD_LargeLimitSelectCell ()

@property (weak, nonatomic) IBOutlet UIView *Stock1;
@property (weak, nonatomic) IBOutlet UIView *Stock2;

@end

@implementation MD_LargeLimitSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_Stock1 setCornerRadius:4];
    [_Stock2 setCornerRadius:4];
    _Stock1.layer.borderWidth = 0.5f;
    _Stock1.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _Stock2.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _Stock2.layer.borderWidth = 0.5f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
