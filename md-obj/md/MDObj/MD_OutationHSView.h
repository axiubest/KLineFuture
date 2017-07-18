//
//  MD_OutationHSView.h
//  MDObj
//
//  Created by Apple on 17/6/20.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_OptationHSHeaderView.h"
@interface MD_OutationHSView : UIView

@property (nonatomic, strong) MD_OptationHSHeaderView *headerView;
-(instancetype)initWithFrame:(CGRect)frame Controller:(XIU_ViewController *)vc;

- (void)setIndexSocket:(NSArray *)arr;
@end
