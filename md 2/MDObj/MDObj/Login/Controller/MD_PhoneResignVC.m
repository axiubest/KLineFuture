//
//  MD_PhoneResignVC.m
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_PhoneResignVC.h"
#import "NSDictionary+Common.h"
static id _instance = nil;

@interface MD_PhoneResignVC ()
{
    NSInteger _count;
    NSTimer *_Timer;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;

@property (weak, nonatomic) IBOutlet UITextField *verificationField;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@end

@implementation MD_PhoneResignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 0) {
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 20, 10)];
//        btn setBackgroundImage:[UIImage imageNamed:@""] forState:<#(UIControlState)#>
    }
    NSLog(@"--------------%@",kPathDocument);
    self.navigationItem.title = @"手机绑定";
    _sendCodeBtn.layer.masksToBounds = YES;
    _sendCodeBtn.layer.cornerRadius = 3.f;
    self.view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark click send verification code button


- (IBAction)clickSendVerificationCodeBtn:(UIButton *)sender {
    _count = 60;
    sender.enabled = NO;
    sender.backgroundColor = [UIColor lightGrayColor];
    sender.tintColor = [UIColor darkGrayColor];
    _Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [self request];
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateNormal];
        
    }
    else
    {
        [timer invalidate];
        self.sendCodeBtn.enabled = YES;
        [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.sendCodeBtn.backgroundColor = [UIColor redColor];
        self.sendCodeBtn.tintColor = [UIColor whiteColor];
        
    }
}

- (void)request {

    
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:@"Cloud/GetMessageCode" withParams:@{@"APPID":APPID, @"timestamp":XIU_Timestamp, @"signed":XIU_Signed,@"mobile":_phoneNumField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {//验证码发送成功
            ERROR_HUD(@"验证码发送成功");
            
        }
    }];
}

#pragma mark go
- (IBAction)clickGoButton:(id)sender {
    if ([NSString valiMobile:_phoneNumField.text] && _verificationField.text.length == 4) {//输入正确进入网络请求
        [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:@"Cloud/MobileLogin" withParams:@{@"APPID":APPID, @"timestamp":XIU_Timestamp, @"signed":XIU_Signed,@"mobile":_phoneNumField.text, @"code": _verificationField.text} withMethodType:Post andBlock:^(id data, NSError *error) {
            if (data) {
                
//                if (![[data objectForKey:@"Error_msg"] isEqualToString:@"<null>"]) {
//                    
//                    return ;
//                }
//                数据本地保存
                NSDictionary *dic = [data objectForKey:@"result"];
                
                
                NSDictionary *tmpDic = [dic deleteAllNullValue:dic];
                [[NSUserDefaults standardUserDefaults] setObject:tmpDic forKey:kLoginUserDict];

                [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:kLoginStatus];//设置登录状态
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else {
        
        if (![NSString valiMobile:_phoneNumField.text]) {
            ERROR_HUD(@"请输入正确手机号");
            return;
        }if (_verificationField.text.length != 4) {
             ERROR_HUD(@"请输入正确验证码");
        }
    }
}


@end
