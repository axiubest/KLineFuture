//
//  MD_SingleStockNewSegmentView.m
//  MDObj
//
//  Created by Apple on 17/7/14.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SingleStockNewSegmentView.h"

@interface MD_SingleStockNewSegmentView ()

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fouthBtn;

@property (weak, nonatomic) IBOutlet UIView *firstLine;
@property (weak, nonatomic) IBOutlet UIView *secondLine;
@property (weak, nonatomic) IBOutlet UIView *thirdLine;
@property (weak, nonatomic) IBOutlet UIView *forthLine;



@end

@implementation MD_SingleStockNewSegmentView

+ (MD_SingleStockNewSegmentView *)loadSegmentView {
    return [[NSBundle mainBundle]loadNibNamed:[self XIU_ClassIdentifier] owner:self options:nil].lastObject;
}

- (IBAction)clickButton:(UIButton *)sender {
    //先刷新再走代理
    [_delegate clickNewsSegmentViewButton:sender];


    
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        }
    }
    switch (sender.tag) {
        case 0:
          
            _firstLine.hidden = NO;
            _secondLine.hidden = YES;
            _thirdLine.hidden = YES;
            _forthLine.hidden = YES;

            break;
        case 1:
            _firstLine.hidden = YES;
            _secondLine.hidden = NO;
            _thirdLine.hidden = YES;
            _forthLine.hidden = YES;
            break;
        case 2:

            _firstLine.hidden = YES;
            _secondLine.hidden = YES;
            _thirdLine.hidden = NO;
            _forthLine.hidden = YES;
            break;
        case 3:

            _firstLine.hidden = YES;
            _secondLine.hidden = YES;
            _thirdLine.hidden = YES;
            _forthLine.hidden = NO;
            break;
        default:
            break;
    }
    
//      [sender setTitleColor:[UIColor colorWithHexString:@"378AD6"] forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
