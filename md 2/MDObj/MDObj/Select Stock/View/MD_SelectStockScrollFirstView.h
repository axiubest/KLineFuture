//
//  MD_SelectStockScrollFirstView.h
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_SelectStockFirstHeaderView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface MD_SelectStockScrollFirstView : UIView<UIWebViewDelegate>


@property (nonatomic, strong)MD_SelectStockFirstHeaderView *headerView;

@property (nonatomic, strong) JSContext *jsContext;
@property (weak, nonatomic)  UIWebView *webView;

- (void)setData:(NSDictionary *)dic;

@end
