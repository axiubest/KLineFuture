//
//  XIU_XIU_BaseRootTool.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2016/12/28.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_BaseRootTool.h"
//控制器选择工具

#import "XIU_HiddenTabBarController.h"
#import "XIU_BaseNavgationController.h"

#import "MD_MeViewController.h"
#import "MD_OptionalViewController.h"
#import "MD_QuotationViewController.h"
#import "MD_SelectStockViewController.h"
#import "MD_HomeViewController.h"
#import "MD_LoginViewController.h"


#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
static XIU_BaseRootTool *sharedObj = nil;


@interface XIU_BaseRootTool ()<RDVTabBarControllerDelegate>
{
    
}
@property (nonatomic, weak) UIButton *UnLoginButton;
@property (nonatomic, assign)NSInteger oldSelectIndex;
@property (nonatomic, weak)RDVTabBarController *tabBarController;

@end
@implementation XIU_BaseRootTool

+(XIU_BaseRootTool *)TabBarRootTool {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedObj = [[self.class alloc]init];
    });
    return sharedObj;
}

- (void)chooseRootViewController:(UIWindow *)window {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(receiveNotificiation) name:kHomeDiagnosisStock object:nil];
    [center addObserver:self selector:@selector(SelectStockNotification) name:SelectStockNoti object:nil];
    [center addObserver:self selector:@selector(receiveNotificiationOutlogin) name:SettingLoginOut object:nil];
    MD_HomeViewController *firstViewController = [[MD_HomeViewController alloc] init];
    XIU_BaseNavgationController *firstNavigationController = [[XIU_BaseNavgationController alloc]initWithRootViewController:firstViewController];
    
    
    
    MD_QuotationViewController *secondViewController = [[MD_QuotationViewController alloc] init];
    XIU_BaseNavgationController *secondNavigationController = [[XIU_BaseNavgationController alloc] initWithRootViewController:secondViewController];
    
    
    
    
    MD_SelectStockViewController *thirdViewController = [[MD_SelectStockViewController alloc] init];
    XIU_BaseNavgationController *thirdNavigationController = [[XIU_BaseNavgationController alloc] initWithRootViewController:thirdViewController];
    
    MD_OptionalViewController *forthViewController = [[MD_OptionalViewController alloc] init];
    XIU_BaseNavgationController *forthNavigationController = [[XIU_BaseNavgationController alloc] initWithRootViewController:forthViewController];
    forthNavigationController.tabBarItem.tag = 4;
    
    MD_MeViewController *fifthViewController = [[MD_MeViewController alloc] init];
    XIU_BaseNavgationController *fifthNavigationController = [[XIU_BaseNavgationController alloc] initWithRootViewController:fifthViewController];
    fifthNavigationController.tabBarItem.tag = 5;
    
    
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController,forthNavigationController,fifthNavigationController]];
    [self customizeTabBarForController:tabBarController];
    tabBarController.delegate = self;
    window.rootViewController = tabBarController;
    _tabBarController = tabBarController;
}


- (void)receiveNotificiation {
    _tabBarController.selectedIndex = 1;
}

- (void)receiveNotificiationOutlogin {
    _tabBarController.selectedIndex = 0;
    
}

- (void)SelectStockNotification {
    _tabBarController.selectedIndex = 2;

}

-(BOOL)tabBarController:(RDVTabBarController*)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    self.oldSelectIndex = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (viewController.tabBarItem.tag == 5 || viewController.tabBarItem.tag == 4){
        
        if (![XIU_Login isLogin]) {
            
            tabBarController.selectedIndex = self.oldSelectIndex;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[MD_LoginViewController alloc] init] animated:YES completion:nil];
            
        }
    }
}



#pragma mark - Methods

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"tab_btn_home", @"tab_btn_price", @"tab_btn_choose",@"tab_btn_optional",@"tab_btn_my"];
    NSArray *titleArray = @[@"首页",@"行情",@"形态选股",@"自选",@"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",
                                                      [tabBarItemImages objectAtIndex:index]]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setTitle:titleArray[index]];
        
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                           };
        
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor colorWithHexString:@"378AD6 "],
                                         };
        
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        //        if (![XIU_Login isLogin]) {
        //            if ([item.title isEqualToString:@"购物车"]) {
        ////                _tabBarItemCount = [[tabBarController tabBar] items].count;
        //                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        //                [button addTarget:self action:@selector(UnLoginMethod) forControlEvents:UIControlEventTouchUpInside];
        //                button.backgroundColor = [UIColor blueColor];
        //                [item addSubview:button];
        //                _UnLoginButton = button;
        ////                [item addSubview:self.UnLoginButton];
        //
        //            }
        //        }else{
        //            _UnLoginButton = nil;
        //        }
        
        
        index++;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
