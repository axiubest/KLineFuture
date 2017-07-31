//
//  MD_SingleStockCompanyInfoCell.m
//  MDObj
//
//  Created by Apple on 17/7/14.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SingleStockCompanyInfoCell.h"
@interface MD_SingleStockCompanyInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *Fvalupe;
@property (weak, nonatomic) IBOutlet UILabel *PerShare;
@property (weak, nonatomic) IBOutlet UILabel *Income;
@property (weak, nonatomic) IBOutlet UILabel *NetProfit;
@property (weak, nonatomic) IBOutlet UILabel *Tvaluep;
@property (weak, nonatomic) IBOutlet UILabel *NetAssets;
@property (weak, nonatomic) IBOutlet UILabel *IncomeGtowth;
@property (weak, nonatomic) IBOutlet UILabel *NetProfitGrowth;

@property (weak, nonatomic) IBOutlet UILabel *TotalShareCapital;
@property (weak, nonatomic) IBOutlet UILabel *CirculatingCapital;
@property (weak, nonatomic) IBOutlet UILabel *Shareholder;
@property (weak, nonatomic) IBOutlet UILabel *FirstShareholder;
@property (weak, nonatomic) IBOutlet UILabel *TenShareholder;
@property (weak, nonatomic) IBOutlet UILabel *Investor;


@end

@implementation MD_SingleStockCompanyInfoCell

-(void)setModel:(MD_StockChartCompanyInfoModel *)model {
    _model = model;
    _Fvalupe.text = _model.Fvaluep;
    _PerShare.text = _model.PerShare;
    _Income.text = _model.Income;
    _NetProfit.text = _model.NetProfit;
    _Tvaluep.text = _model.Tvaluep;
    _NetAssets.text = _model.NetAssets;
    _IncomeGtowth.text = _model.IncomeGrowth;
    _NetProfitGrowth.text = _model.NetProfitGrowth;
    _TotalShareCapital.text = _model.TotalShareCapital;
    _CirculatingCapital.text = _model.CirculatingCapital;
    _Shareholder.text = _model.Shareholder;
    _FirstShareholder.text = _model.FirstShareholder;
    _TenShareholder.text = _model.TenShareholder;
    _IncomeGtowth.text = _model.Investor;
    
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
