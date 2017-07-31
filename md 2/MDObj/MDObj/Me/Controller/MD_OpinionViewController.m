//
//  MD_OpinionViewController.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OpinionViewController.h"

@interface MD_OpinionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *perInformationLab;
@property (weak, nonatomic) IBOutlet UIButton *senBtn;

@end

@implementation MD_OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
}
- (IBAction)clickSendBtn:(id)sender {
    if (_textView.text.length > 0 && _perInformationLab.text.length > 5) {
        ERROR_HUD(@"感谢您提出宝贵意见，我们已经收到，正在处理");
    }else {
           ERROR_HUD(@"信息填写错误");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.perInformationLab resignFirstResponder];
}


@end
