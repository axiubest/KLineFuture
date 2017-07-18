//
//  MD_ThreeButtonCell.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_ThreeButtonCell.h"

@interface MD_ThreeButtonCell ()

@property (weak, nonatomic) IBOutlet UIView *HotMsgView;

@property (weak, nonatomic) IBOutlet UIView *diagnosisView;

@property (weak, nonatomic) IBOutlet UIView *KlinePKView;
@property (weak, nonatomic) IBOutlet UIView *bigDataView;
@end

@implementation MD_ThreeButtonCell



- (void)awakeFromNib {
    [super awakeFromNib];
    [_HotMsgView bk_whenTapped:^{
        [_delegate clickHotMsgBtn];
    }];
    
    [_diagnosisView bk_whenTapped:^{
        [_delegate clickDiagnosisStockBtn];

    }];
    
    [_KlinePKView bk_whenTapped:^{
        [_delegate clickKlinePKBtn];
    }];
    
    [_bigDataView bk_whenTapped:^{
        [_delegate clickBigDataBtn];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
