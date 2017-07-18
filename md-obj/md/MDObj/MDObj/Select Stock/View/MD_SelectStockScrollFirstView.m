//
//  MD_SelectStockScrollFirstView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockScrollFirstView.h"



@implementation MD_SelectStockScrollFirstView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        MD_SelectStockFirstHeaderView *view = [[NSBundle mainBundle]loadNibNamed:[MD_SelectStockFirstHeaderView XIU_ClassIdentifier] owner:self options:nil].firstObject;
        view.frame = CGRectMake(0, 0, KWIDTH, 60);
        _headerView = view;
        [self addSubview:view];
        
        UIButton *weekBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, view.height, 80, 20)];
         [weekBtn setTitleColor:[UIColor colorWithHexString:@"FF5E45"] forState:UIControlStateNormal];
        weekBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [weekBtn setTitle:@"周收益率" forState:UIControlStateNormal];
        [self addSubview:weekBtn];
        
        CALayer *lay = [CALayer layer];
        lay.frame = CGRectMake(weekBtn.x + weekBtn.width + 2 , weekBtn.y + 4, 0.5, weekBtn.height - 8);
        lay.backgroundColor = [UIColor colorWithHexString:@"999999"].CGColor;
        [self.layer addSublayer:lay];
        
        UIButton *monthBtn = [[UIButton alloc] initWithFrame:CGRectMake(weekBtn.width + weekBtn.x, weekBtn.y, 80, 20)];
        [monthBtn setTitleColor:[UIColor colorWithHexString:@"FF5E45"] forState:UIControlStateNormal];
        monthBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        monthBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [monthBtn setTitle:@"月收益率" forState:UIControlStateNormal];
        [self addSubview:monthBtn];
        
//        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, weekBtn.height + view.height, frame.size.width, frame.size.height - view.height)];
//        NSString *path = [[NSBundle mainBundle] bundlePath];
//        NSURL *baseURL = [NSURL fileURLWithPath:path];
//        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"XIU_ChartHistogram"ofType:@"html"];
//        
//        NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//        
//        [web loadHTMLString:htmlCont baseURL:baseURL];
//        [self addSubview:web];
// 
//        
//        
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, weekBtn.height + view.height, frame.size.width, frame.size.height - view.height)];

        
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSURL *baseURL = [NSURL fileURLWithPath:path];
            NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"XIU_ChartHistogram"ofType:@"html"];

            NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
            [web loadHTMLString:htmlCont baseURL:baseURL];
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
            dispatch_async(mainQueue, ^{
                [self addSubview:web];

                
            });
            
        });
    }
    return self;
}

@end
