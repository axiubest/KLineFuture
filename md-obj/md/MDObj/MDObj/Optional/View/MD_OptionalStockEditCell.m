//
//  MD_OptionalStockEditCell.m
//  MDObj
//
//  Created by A-XIU on 2017/6/17.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptionalStockEditCell.h"
@interface MD_OptionalStockEditCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeftConstraint;

@property (weak, nonatomic) IBOutlet UILabel *nowPriceLab;//现价

@property (weak, nonatomic) IBOutlet UILabel *riseLab;//涨幅

@property (weak, nonatomic) IBOutlet UILabel *risePriceLab;//涨额

@property (weak, nonatomic) IBOutlet UILabel *CodeLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation MD_OptionalStockEditCell
- (void)setData:(MD_OptionalListModel *)model {
//    傻逼一样的后台
    NSString *first = [model.DiffMoney substringToIndex:1];//字符串开始
    
    if ([first isEqualToString:@"-"]) {
        
        [self setLabelColor:[UIColor colorWithHexString:@"1CB64A"]];


        _riseLab.text = model.DiffMoney;
        _risePriceLab.text = model.DiffRate;
        
    }else {
        [self setLabelColor:[UIColor colorWithHexString:@"FF5E45"]];


        _riseLab.text =[NSString stringWithFormat:@"+%@", model.DiffMoney] ;
       _risePriceLab.text =[NSString stringWithFormat:@"+%@", model.DiffRate] ;
        
    }
    _nowPriceLab.text = model.NowPrice;
    _CodeLab.text = model.Code;
    _nameLab.text = model.Name;
    
}

- (void)setLabelColor:(UIColor *)color {
    _risePriceLab.textColor = color;
    _riseLab.textColor = color;
    _nowPriceLab.textColor = color;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    if (self.editing == YES) {
        _nowPriceLab.hidden = YES;
        _riseLab.hidden = YES;
        _risePriceLab.hidden = YES;
    }else {
        _nowPriceLab.hidden = NO;
        _riseLab.hidden = NO;
        _risePriceLab.hidden = NO;
    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
