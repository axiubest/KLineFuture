//
//  MD_SelectStockHeaderView.m
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockHeaderView.h"



@interface MD_SelectStockHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

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
@property (nonatomic, weak) UITableView *tb;
@end

@implementation MD_SelectStockHeaderView


- (void)setDataSourceWithData:(NSMutableArray *)data Controller:(UITableView *)tableView{
    if (data.count == 6) {
  
        //点第一第二按钮屏幕可以显示
//        [_stock1 bk_whenTapped:^{
//            [tableView setContentOffset:CGPointMake(0, 100) animated:YES];
//
//        }];
//        [_stock2 bk_whenTapped:^{
//            [tableView setContentOffset:CGPointMake(0, 100) animated:YES];
//            
//        }];
        [_stock3 bk_whenTapped:^{
            [tableView setContentOffset:CGPointMake(0, 250 *SCREEN_SCALE * 2) animated:YES];
            
        }];
        [_stock4 bk_whenTapped:^{
            [tableView setContentOffset:CGPointMake(0, 250 *SCREEN_SCALE * 3) animated:YES];
            
        }];
        [_stock5 bk_whenTapped:^{
            [tableView setContentOffset:CGPointMake(0, 250 *SCREEN_SCALE * 4) animated:YES];
            
        }];
        [_stock6 bk_whenTapped:^{
            [tableView setContentOffset:CGPointMake(0, 250 *SCREEN_SCALE * 5) animated:YES];
            
        }];
        
        
        
        MD_SelectStockDetialModel *model0 = data[0];
        _stock1Title.text = model0.Name;
        _stock1Code.text =[NSString stringWithFormat:@"%@", model0.Code];

        MD_SelectStockDetialModel *model1 = data[1];
        _stock2Title.text = model1.Name;
        _stock2Code.text =[NSString stringWithFormat:@"%@", model1.Code];

        MD_SelectStockDetialModel *model2 = data[2];
        _stock3Title.text = model2.Name;
        _stock3Code.text =[NSString stringWithFormat:@"%@", model2.Code];

        MD_SelectStockDetialModel *model3 = data[3];
        _stock4Title.text = model3.Name;
        _stock4Code.text =[NSString stringWithFormat:@"%@", model3.Code];

        MD_SelectStockDetialModel *model4 = data[4];
        _stock5Title.text = model4.Name;
        _stock5Code.text =[NSString stringWithFormat:@"%@", model4.Code];

        MD_SelectStockDetialModel *model5 = data[5];
        _stock6Title.text = model5.Name;
        _stock6Code.text =[NSString stringWithFormat:@"%@", model5.Code];

    }else {
        return;
    }

}
@end
