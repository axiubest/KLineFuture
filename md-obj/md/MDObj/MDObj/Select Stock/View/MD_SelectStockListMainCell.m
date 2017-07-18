//
//  MD_SelectStockListMainCell.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockListMainCell.h"
#import "MD_SelectStockDetialVC.h"

#import "MD_SelectStockScrollFirstView.h"
#import "MD_SelectStockScrollSecondView.h"
#import "MD_SelectStockScrollThirdView.h"
@interface MD_SelectStockListMainCell ()<UIScrollViewDelegate>
{
    NSString *csId;
}
@property (nonatomic, weak)MD_SelectStockScrollFirstView *firstView;

@property (nonatomic, weak)MD_SelectStockScrollSecondView *secondView;

@property (nonatomic, weak)MD_SelectStockScrollThirdView *thirdView;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLab;

@property (weak, nonatomic) IBOutlet UIPageControl *XIUPageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *XIUScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectStockBtn;

@property (weak, nonatomic) IBOutlet UILabel *detialLab;
@property (weak, nonatomic) IBOutlet UILabel *stockStyleTitle;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStockCount;
@property (weak, nonatomic) IBOutlet UILabel *presentLab;
@end


@implementation MD_SelectStockListMainCell




//赋值
- (void)setHeaderDic:(NSMutableDictionary *)dic {
    
    if ([dic objectForKey:@"Id"]) {
        csId = [dic objectForKey:@"Id"];
        [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_ChooseStockLike withParams:@{@"userId":[XIU_Login userId],@"csId":[dic objectForKey:@"Id"]} withMethodType:Post andBlock:^(id data, NSError *error) {
            if ([[NSString stringWithFormat:@"%@", data[@"Data"][@"IsLike"]] isEqualToString:@"0"]) {//未点赞
//                后台参数为空
                _likeBtn.image = [UIImage imageNamed:@"imgchoose_btn_moods_pre"];
            }else {
                 _likeBtn.image = [UIImage imageNamed:@"imgchoose_btn_moods_nor"];
            }
            _likeCountLab.text =[NSString stringWithFormat:@"%@",  data[@"Data"][@"LikeCount"]];
            
        }];
    }

    
    
    
    if (![[dic objectForKey:@"Example"]isKindOfClass:[NSNull class]]) {
        //        NSString *arr = [[dic objectForKey:@"Example"] componentsSeparatedByString:@","][1];
        NSString *q = [NSString stringWithFormat:@"%@%@", KBASEURL, [dic objectForKey:@"Example"]];
        [_thirdView.imgView sd_setImageWithURL:[NSURL URLWithString:q]];
        
    }
    
    _presentLab.text = [dic objectForKey:@"Overall"];
    _stockStyleTitle.text = [dic objectForKey:@"RefText"];
    
    _firstView.headerView.successrateLab.text = [dic objectForKey:@"SuccessRate"];
    _firstView.headerView.netProfitLab.text = [dic objectForKey:@"NetProfit"];
    _firstView.headerView.dayLab.text = [dic objectForKey:@"Day"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
//    按钮点击方法
    _likeBtn.userInteractionEnabled = YES;
    [_likeBtn bk_whenTapped:^{
        if ([XIU_Login isLogin] && csId) {
            
            [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_StockLike withParams:@{@"userId":[XIU_Login userId],@"csId":csId} withMethodType:Post andBlock:^(id data, NSError *error) {
                _likeBtn.image = [UIImage imageNamed:@"imgchoose_btn_moods_nor"];
            }];
        }else {
        MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
        errorHud.mode = MBProgressHUDModeText;
        errorHud.labelText= @"暂未登录请先登录";
        errorHud.removeFromSuperViewOnHide = YES;
        [errorHud hide:YES afterDelay:1.5];;
        }
 
    }];
    
    
    [_selectStockBtn setCornerRadius:17];
    _selectStockBtn.layer.borderWidth = 1;
    _selectStockBtn.layer.borderColor = [UIColor colorWithHexString:@"4B98DF"].CGColor;
    _XIUScrollView.delegate = self;
    //图一图二命名写反
    _XIUScrollView.contentSize = CGSizeMake(KWIDTH * 3, 100);
    MD_SelectStockScrollFirstView *view = [[MD_SelectStockScrollFirstView alloc] initWithFrame:CGRectMake(KWIDTH, 0, KWIDTH, 300)];
    
    _firstView = view;
    
    MD_SelectStockScrollSecondView *view2 = [[MD_SelectStockScrollSecondView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 300)];
    
    _secondView = view2;
    
    MD_SelectStockScrollThirdView *view3 = [[MD_SelectStockScrollThirdView alloc] initWithFrame:CGRectMake(2 * KWIDTH, 0, KWIDTH, 200)];
    
    _thirdView = view3;
    [_XIUScrollView addSubview:self.firstView];
    [_XIUScrollView addSubview:self.secondView];
    [_XIUScrollView addSubview:self.thirdView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = _XIUScrollView.contentOffset.x / KWIDTH ;
    
    _XIUPageControl.currentPage = currentPage;
}

- (IBAction)clickSelectStock:(id)sender {
    [_delegate clickChooseStock];
}


@end
