//
//  MD_HomeLiveRadioIfomCell.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_HomeLiveRadioIfomCell.h"

@interface MD_HomeLiveRadioIfomCell ()
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *discribtionLab;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIView *describtionView;

@end

@implementation MD_HomeLiveRadioIfomCell

- (void)setRadioCellData:(NSDictionary *)dic {
    [_likeBtn setTitle:[dic objectForKey:@"Good"] forState:UIControlStateNormal];
    [_userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KBASEURL, [dic objectForKey:@"AdvPortrait"]]]];
    _userImg.layer.masksToBounds = YES;
    _userImg.layer.cornerRadius = _userImg.width/2;
    
    _discribtionLab.text = [dic objectForKey:@"Text"];
    _userName.text = [dic objectForKey:@"AdvName"];
    if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsGood"]] isEqualToString:@"0"]) {//unlike
        [_likeBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"home_live_icon_praise"] forState:UIControlStateNormal];
    }
    if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsGood"]] isEqualToString:@"1"]) {//like
                [_likeBtn setTitleColor:[UIColor colorWithHexString:@"FF4343"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"home_live_icon_praise_red"] forState:UIControlStateNormal];
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _describtionView.layer.masksToBounds = YES;
    _describtionView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
