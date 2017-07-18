//
//  MD_OptationPlateCell.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OptationPlateCell.h"
#import "MD_QuotationPlateModel.h"
@interface MD_OptationPlateCell ()





//for subViews 写， 后期修改, 写的辣眼睛

@property (weak, nonatomic) IBOutlet UIView *stock1;
@property (weak, nonatomic) IBOutlet UIView *stock2;
@property (weak, nonatomic) IBOutlet UIView *stock3;
@property (weak, nonatomic) IBOutlet UIView *stock4;
@property (weak, nonatomic) IBOutlet UIView *stock5;
@property (weak, nonatomic) IBOutlet UIView *stock6;

@property (weak, nonatomic) IBOutlet UILabel *stock1Title;
@property (weak, nonatomic) IBOutlet UILabel *stock2Title;
@property (weak, nonatomic) IBOutlet UILabel *stock3Title;
@property (weak, nonatomic) IBOutlet UILabel *stock4Title;
@property (weak, nonatomic) IBOutlet UILabel *stock5Title;
@property (weak, nonatomic) IBOutlet UILabel *stock6Title;

@property (weak, nonatomic) IBOutlet UILabel *stock1Code;
@property (weak, nonatomic) IBOutlet UILabel *stock2Code;
@property (weak, nonatomic) IBOutlet UILabel *stock3Code;
@property (weak, nonatomic) IBOutlet UILabel *stock4Code;
@property (weak, nonatomic) IBOutlet UILabel *stock5Code;
@property (weak, nonatomic) IBOutlet UILabel *stock6Code;

@property (weak, nonatomic) IBOutlet UILabel *stock1Name;
@property (weak, nonatomic) IBOutlet UILabel *stock2Name;
@property (weak, nonatomic) IBOutlet UILabel *stock3Name;
@property (weak, nonatomic) IBOutlet UILabel *stock4Name;
@property (weak, nonatomic) IBOutlet UILabel *stock5Name;
@property (weak, nonatomic) IBOutlet UILabel *stock6Name;

@end

@implementation MD_OptationPlateCell




- (void)setData:(NSMutableArray *)data {
    if (data.count < 6) {
        return;
    }
    _stock1Title.text = [data[0] Name];
    _stock2Title.text = [data[1] Name];
    _stock3Title.text = [data[2] Name];
    _stock4Title.text = [data[3] Name];
    _stock5Title.text = [data[4] Name];
    _stock6Title.text = [data[5] Name];
    
    _stock1Title.font = [UIFont systemFontOfSize:_stock1Title.text.length > 6 ? 13 : 15];
    _stock2Title.font = [UIFont systemFontOfSize:_stock2Title.text.length > 6 ? 13 : 15];
    _stock3Title.font = [UIFont systemFontOfSize:_stock3Title.text.length > 6 ? 13 : 15];
    _stock4Title.font = [UIFont systemFontOfSize:_stock4Title.text.length > 6 ? 13 : 15];
    _stock5Title.font = [UIFont systemFontOfSize:_stock5Title.text.length > 6 ? 13 : 15];
    _stock6Title.font = [UIFont systemFontOfSize:_stock6Title.text.length > 6 ? 13 : 15];
    
    
    [_stock1 bk_whenTapped:^{
        [_delegate clickViewWithTag:_stock1.tag];
        
    }];
    [_stock2 bk_whenTapped:^{
        [_delegate clickViewWithTag:_stock2.tag];
        
    }];
    [_stock3 bk_whenTapped:^{
        [_delegate clickViewWithTag:_stock3.tag];
        
    }];
    [_stock4 bk_whenTapped:^{
        [_delegate clickViewWithTag:_stock4.tag];
        
    }];
    [_stock5 bk_whenTapped:^{
        [_delegate clickViewWithTag:_stock5.tag];
        
    }];
    [_stock6 bk_whenTapped:^{
        [_delegate clickViewWithTag:_stock6.tag];
        
    }];
    
    
    
    
    _stock1Code.text = [data[0] diff_rate];
    _stock1Code.textColor = [_stock1Code.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    _stock2Code.text = [data[1] diff_rate];
    _stock2Code.textColor = [_stock2Code.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    _stock3Code.text = [data[2] diff_rate];
    _stock3Code.textColor = [_stock3Code.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    _stock4Code.text = [data[3] diff_rate];
    _stock4Code.textColor = [_stock4Code.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    _stock5Code.text = [data[4] diff_rate];
    _stock5Code.textColor = [_stock5Code.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    _stock6Code.text = [data[5] diff_rate];
    _stock6Code.textColor = [_stock6Code.text hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5F45"];
    
    
    _stock1Name.text = [data[0] stockName];
    _stock2Name.text = [data[1] stockName];
    _stock3Name.text = [data[2] stockName];
    _stock4Name.text = [data[3] stockName];
    _stock5Name.text = [data[4] stockName];
    _stock6Name.text = [data[5] stockName];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIView *view in self.subviews) {
        if (view.tag >= 200 && view.tag <= 205) {
            
            [view bk_whenTapped:^{
                [_delegate clickViewWithTag:view.tag];
            }];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
