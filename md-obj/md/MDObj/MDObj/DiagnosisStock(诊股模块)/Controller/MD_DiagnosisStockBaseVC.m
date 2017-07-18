//
//  MD_DiagnosisStockBaseVC.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisStockBaseVC.h"
#import "MD_DiagnosisDetialVC.h"
#import "MD_SingleStockChartVC.h"
@interface MD_DiagnosisStockBaseVC ()


@property (nonatomic, weak)MD_DiagnosisDetialVC *diagnosisVc;
@property (nonatomic, weak)MD_SingleStockChartVC *singleStockVc;
@property (weak, nonatomic) IBOutlet UIView *segmentView;


@property (weak, nonatomic) IBOutlet UIButton *diagnosisBtn;//诊断
@property (weak, nonatomic) IBOutlet UIButton *marketBtn;//大盘
@property (weak, nonatomic) IBOutlet UIView *diagnosisLine;
@property (weak, nonatomic) IBOutlet UIView *marketLine;
@end

@implementation MD_DiagnosisStockBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"智能诊股";
    
    //实施详情
    MD_SingleStockChartVC *vc2 = [[MD_SingleStockChartVC alloc] init];
    vc2.CodeString = _CodeString;
    
    vc2.view.frame = CGRectMake(0, 64 + 40, self.view.width, self.view.height - 49 - 64 - 40);
    _singleStockVc = vc2;
    [self addChildViewController:vc2];
    [self.view addSubview:vc2.view];
    
       //诊断详情
    MD_DiagnosisDetialVC *vc = [[MD_DiagnosisDetialVC alloc] init];
    vc.CodeString = _CodeString;

    vc.view.frame = CGRectMake(0, 64 + 40, self.view.width, self.view.height - 49 - 64 - 40);
    _diagnosisVc = vc;
    [self addChildViewController:self.diagnosisVc];
    [self.view addSubview:self.diagnosisVc.view];
    
    

}


- (IBAction)clickGoOnDiagnosisiStock:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addMyChooseStock:(id)sender {
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_AddStockOption withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed, @"userId":[XIU_Login userId], @"code":_CodeString} withMethodType:Post andBlock:^(id data, NSError *error) {
        MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        errorHud.mode = MBProgressHUDModeText;
        errorHud.labelText= @"添加自选成功";
        errorHud.removeFromSuperViewOnHide = YES;
        [errorHud hide:YES afterDelay:1.5];
    }];
}

//诊断结果
- (IBAction)resultOfDiagnosis:(id)sender {
    [self.diagnosisVc popView];
}

- (IBAction)clickSegment:(UIButton *)sender {
    [self changeSegmentWithTag:sender.tag];
}


- (void)changeSegmentWithTag:(NSInteger)tag {
    
    for (id obj in self.segmentView.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            if (theButton.tag == tag) {//the btn is select
                [theButton setTitleColor:[UIColor colorWithHexString:@"378AD6"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
                
            }else {
                [theButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
            }
        }
    }
    if (tag == 0) {
        self.diagnosisVc.view.hidden = NO;
        self.singleStockVc.view.hidden = YES;
        _diagnosisLine.hidden = NO;
        _marketLine.hidden = YES;
      
    }else {//1
        self.diagnosisVc.view.hidden = YES;
        self.singleStockVc.view.hidden = NO;

        _diagnosisLine.hidden = YES;
        _marketLine.hidden = NO;
     
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(MD_DiagnosisDetialVC *)diagnosisVc {
    if (!_diagnosisVc) {
        MD_DiagnosisDetialVC *vc = [[MD_DiagnosisDetialVC alloc] init];
        vc.CodeString = _CodeString;
        _diagnosisVc = vc;
    }
    return _diagnosisVc;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
