//
//  UILabel+AutoLabelHeight.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "UILabel+AutoLabelHeight.h"

@implementation UILabel (AutoLabelHeight)


+(float)labelWithSting:(NSString *)theContent andWidth:(float)theWidth andFontSize:(float)theSize{
    float returnF = 0;
    UILabel *tempLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, theWidth, CGFLOAT_MAX)];
    [tempLab setText:nil];
    [tempLab setText:theContent];
    [tempLab setNumberOfLines:0];
    [tempLab setFont:[UIFont systemFontOfSize:theSize]];
    [tempLab sizeToFit];
    CGRect starRect = tempLab.frame;
    starRect.size.width = theWidth;
    returnF = starRect.size.height;
    if(returnF < 21){
        returnF = 21;
    }
    
    return returnF;
}

//MARK:- 快速创建label
+ (UILabel *)quickCreateLabelWithLeft:(CGFloat)left width:(CGFloat)width title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, width, 40)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
@end
