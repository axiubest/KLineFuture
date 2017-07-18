//
//  MD_HomeVideoListCell.m
//  MDObj
//
//  Created by Apple on 17/6/23.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_HomeVideoListCell.h"


@interface MD_HomeVideoListCell ()

@property (weak, nonatomic) IBOutlet UILabel *describtionLab;
@property (weak, nonatomic) IBOutlet UIImageView *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineNum;
@property (weak, nonatomic) IBOutlet UILabel *tiemLab;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
@implementation MD_HomeVideoListCell

- (void)setData:(NSDictionary *)dic {
    _lineNum.text = [dic objectForKey:@"Good"];

    [_userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KBASEURL, [dic objectForKey:@"AdvPortrait"]]]];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = _userImage.width/2;
    
    
    _describtionLab.text = [dic objectForKey:@"Text"];
    _userName.text = [dic objectForKey:@"AdvName"];
    if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsGood"]] isEqualToString:@"0"]) {//unlike
        
        _lineNum.textColor = [UIColor colorWithHexString:@"999999"];
        [_likeBtn setImage:[UIImage imageNamed:@"home_live_icon_praise"]];

    }
    if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsGood"]] isEqualToString:@"1"]) {//like
        _lineNum.textColor = [UIColor colorWithHexString:@"FF4343"];
        [_likeBtn setImage:[UIImage imageNamed:@"home_live_icon_praise_red"]];

        
    }
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_describtionLab setCornerRadius:5.f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
