//
//  MD_OptationDiagnosisCell.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptationDiagnosisCell.h"


@interface MD_OptationDiagnosisCell ()
//@property (weak, nonatomic) IBOutlet UILabel *nowPriceLab;
//@property (weak, nonatomic) IBOutlet UILabel *presentLab;//涨幅

@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *stockCode;
@property (weak, nonatomic) IBOutlet UILabel *diagnosisCountLab;
@end
@implementation MD_OptationDiagnosisCell

- (void)setData:(MD_QuotationPlateModel *)model {
    
    _stockName.text = model.stockName;
    
    _diagnosisCountLab.text =[NSString stringWithFormat:@"%@", model.Num];
    
    _stockCode.text = model.Code;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
