//
//  MD_SelectStockListHeaderCell.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockListHeaderCell.h"
#import "MD_SelectStockKLineDateModel.h"
@interface MD_SelectStockListHeaderCell ()



@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;

@end

@implementation MD_SelectStockListHeaderCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHeaderData:(NSMutableArray *)data {
    if (data.count == 6) {
        
        for (NSInteger i = 0; i < _mainView.subviews.count; i++) {
            //后台传回 字符串 @2@3图片都传回， 需要分割，sb
             NSString *b = [[data[i] Imgs] componentsSeparatedByString:@","][2];
            NSString *str = [NSString stringWithFormat:@"%@%@", KBASEURL,b];
            switch (i) {
                case 0:
            [_btn1 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];

                    break;
                case 1:
                    [_btn2  sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
                    
                    break;
                case 2:
                    [_btn3 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
                    
                    break;
                case 3:
                    [_btn4 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
                    
                    break;
                case 4:
                    [_btn5 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
                    
                    break;
                case 5:
                    [_btn6 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
                    
                    break;
                    
                default:
                    break;
            }
            
            
            UIButton *btn = _mainView.subviews[i];

            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 4;
        }
        
    }else {
        return;
    }
  
}

- (IBAction)clikBtn:(UIButton *)sender {
    //点击按钮图片变为灰色 代码在此键入
    
    [_delegate clickSixBtn:sender];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
