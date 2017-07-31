//
//  MD_OptationHSHeaderView.h
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MD_OptationHSHeaderViewDelegate <NSObject>

- (void)clickHSHeaderViewWithTag:(NSInteger)tag;

@end
@interface MD_OptationHSHeaderView : UIView


@property (nonatomic, assign) id<MD_OptationHSHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet UILabel *code1;
@property (weak, nonatomic) IBOutlet UILabel *code2;
@property (weak, nonatomic) IBOutlet UILabel *code3;
@property (weak, nonatomic) IBOutlet UILabel *code4;
@property (weak, nonatomic) IBOutlet UILabel *code5;
@property (weak, nonatomic) IBOutlet UILabel *code6;

@property (weak, nonatomic) IBOutlet UILabel *detail1;
@property (weak, nonatomic) IBOutlet UILabel *detail2;
@property (weak, nonatomic) IBOutlet UILabel *detail3;
@property (weak, nonatomic) IBOutlet UILabel *detail4;
@property (weak, nonatomic) IBOutlet UILabel *detail5;
@property (weak, nonatomic) IBOutlet UILabel *detail6;
@end
