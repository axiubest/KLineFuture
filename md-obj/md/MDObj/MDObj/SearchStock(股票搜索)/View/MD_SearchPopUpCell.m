//
//  MD_SearchPopUpCell.m
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SearchPopUpCell.h"
#import "MD_LoginViewController.h"
@interface MD_SearchPopUpCell ()

@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, weak) UIViewController *controller;
@end

@implementation MD_SearchPopUpCell


- (void)setDataValueWithDic:(NSDictionary *)dic Controller:(UIViewController  *)vc{
    _controller = vc;
    self.stockTitleLab.text = [dic objectForKey:@"Name"];
    self.stockCodeLab.text = [dic objectForKey:@"Code"];
    NSMutableArray *arr = [XIU_NSUserDefaut getObjectWithObjName:myOptional_list];
    for (NSDictionary *dic in arr) {

        if ([[dic objectForKey:@"Code"]isEqualToString:_stockCodeLab.text]) {
            _isAdd = YES;
        
        }
    }
    
    if (_isAdd) {
      [_addBtn setImage:[UIImage imageNamed:@"search_btn_add_pre"] forState:UIControlStateNormal];
    }else {
             [_addBtn setImage:[UIImage imageNamed:@"search_btn_add_nor"] forState:UIControlStateNormal];
    }
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
  }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)clickAddBtn:(UIButton *)sender {
    if (![XIU_Login isLogin]) {
        MD_LoginViewController *login = [[MD_LoginViewController alloc] init];
        [_controller.navigationController pushViewController:login animated:YES];
        return;
    }
    if (_isAdd) {
        return;
    }
    
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_AddStockOption withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed, @"userId":[XIU_Login userId], @"code":self.stockCodeLab.text} withMethodType:Post andBlock:^(id data, NSError *error) {
    MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    errorHud.mode = MBProgressHUDModeText;
    errorHud.labelText= @"添加自选成功";
    errorHud.removeFromSuperViewOnHide = YES;
    [errorHud hide:YES afterDelay:1.5];
    }];
    if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *view = (UITableView *)self.superview;
        [view reloadData];
    }
}

@end
