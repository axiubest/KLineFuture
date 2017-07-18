//
//  MD_QuotationMoreListCell.m
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_QuotationMoreListCell.h"

@implementation MD_QuotationMoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MD_QuotationPlateModel *)model {
    _model = model;
    _titleLab.text = model.Name;
    _codeLab.text = model.Code;
    _lab3.text = model.stockName;
    
    _lab1.text =[NSString stringWithFormat:@"%@%%", [NSString MD_StringToFloatWithString:[NSString stringWithFormat:@"%@", model.diff_money]]];
        _lab1.textColor = [_lab1.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    _lab2.text = [NSString MD_StringToFloatWithString:model.diff_rate];
    _lab2.textColor = [_lab2.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    if ([_lab2.text hasPrefix:@"-"]) {
        _lab2.textColor = [UIColor colorWithHexString:@"1CB64A"];
    }else {
        _lab2.textColor = [UIColor colorWithHexString:@"FF5E45"];
 
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
