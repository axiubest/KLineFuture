//
//  XIU_BaseNavgationController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2016/12/28.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_BaseNavgationController.h"

@interface XIU_BaseNavgationController ()
{
    UIImageView *navBarHairlineImageView;

}
@end

@implementation XIU_BaseNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    //更改导航栏图标背景颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];


    // 设置导航栏底部1px线颜色
    [self setUpButtomOnePXLine];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpButtomOnePXLine {
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    
    [navigationBar setShadowImage:[self imageWithColor:[UIColor orangeColor]]];
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
