//
//  MD_LargeStockViewController.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_LargeStockViewController.h"
#import <WebKit/WebKit.h>
@interface MD_LargeStockViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation MD_LargeStockViewController

-(instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _navgationItemTitle;

    [NSString showHUD:@"" andView:self.view andHUD:self.hud];

    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    
    wkWebConfig.userContentController = wkUController;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,64,KWIDTH,self.view.height) configuration:wkWebConfig];
    
    
    //2.创建URL
    NSURL *URL = [NSURL URLWithString:_url];
    //3.创建Request
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.hud hide:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];
        
    }
    return _hud;
}
@end
