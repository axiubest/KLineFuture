//
//  MD_SelectStockScrollSecondView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockScrollSecondView.h"

@implementation MD_SelectStockScrollSecondView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {


        
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 30, KWIDTH, 200)];
        
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSURL *baseURL = [NSURL fileURLWithPath:path];
            NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"XIU_MultipleChart"ofType:@"html"];
            
            NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];

            [web loadHTMLString:htmlCont baseURL:baseURL];

                dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
                dispatch_async(mainQueue, ^{
                    [self addSubview:web];
 
                });
            
        });
        
        
        
        NSArray *array = [NSArray arrayWithObjects:@"三个月",@"全部",nil];
        
        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
        segment.frame = CGRectMake(10, 0, 110, 25);
        [self addSubview:segment];
    }
    return self;
}

@end
