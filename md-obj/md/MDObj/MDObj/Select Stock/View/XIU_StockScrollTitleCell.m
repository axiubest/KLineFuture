//
//  InfoCell.m
//  ListTableView
//
//  Created by 劉光軍 on 2017/2/20.
//  Copyright © 2017年 劉光軍. All rights reserved.
//

#import "XIU_StockScrollTitleCell.h"

@interface XIU_StockScrollTitleCell()

@property (weak, nonatomic) IBOutlet UILabel *Lab1;
@property (weak, nonatomic) IBOutlet UILabel *Lab2;
@property (weak, nonatomic) IBOutlet UILabel *Lab3;
@property (weak, nonatomic) IBOutlet UILabel *Lab4;
@property (weak, nonatomic) IBOutlet UILabel *Lab5;
@property (weak, nonatomic) IBOutlet UILabel *Lab6;
@property (weak, nonatomic) IBOutlet UILabel *Lab7;
@property (weak, nonatomic) IBOutlet UILabel *Lab8;
@property (weak, nonatomic) IBOutlet UILabel *Lab9;
@property (weak, nonatomic) IBOutlet UILabel *Lab10;
@property (weak, nonatomic) IBOutlet UILabel *Lab11;
@property (weak, nonatomic) IBOutlet UILabel *Lab12;

@end

@implementation XIU_StockScrollTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setDataWithStr:(MD_QuotationHSListCellModel *)dic {
    _Lab1.text = [NSString XIU_IsEmpty:[dic nowPrice]];
    _Lab2.text =[NSString stringWithFormat:@"%@%%", [NSString XIU_IsEmpty:[dic diff_money]]] ;
    if ([_Lab2.text hasPrefix:@"-"]) {
        _Lab2.textColor = [UIColor colorWithHexString:@"1CB54A"];
        _Lab1.textColor = [UIColor colorWithHexString:@"1CB54A"];
        _Lab3.textColor = [UIColor colorWithHexString:@"1CB54A"];


    }else {
        _Lab1.textColor = [UIColor colorWithHexString:@"FF5E45"];
        _Lab2.textColor = [UIColor colorWithHexString:@"FF5E45"];
        _Lab3.textColor = [UIColor colorWithHexString:@"FF5E45"];

    }
    _Lab3.text = [NSString XIU_IsEmpty:[dic diff_rate]];
    _Lab4.text =[NSString stringWithFormat:@"%@%%", [NSString MD_StringToFloatWithString:[dic turnover]]];
    _Lab5.text = [NSString XIU_IsEmpty:[dic swing]];
    _Lab6.text =[NSString MD_AllStockStringToFloatWithString:[dic totalcapital]];
    _Lab7.text = [NSString XIU_IsEmpty:[dic pe]];
    _Lab8.text = [NSString XIU_IsEmpty:[dic pb]];
    _Lab9.text = [NSString stringWithFormat:@"%@亿",[NSString XIU_IsEmpty:[dic circulation_value]] ];
    _Lab10.text = [NSString stringWithFormat:@"%@亿", [NSString XIU_IsEmpty:[dic all_value]]];
    _Lab11.text = [NSString XIU_IsEmpty:[dic nowPrice]];
    _Lab12.text = [NSString XIU_IsEmpty:[dic tradeNum]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
