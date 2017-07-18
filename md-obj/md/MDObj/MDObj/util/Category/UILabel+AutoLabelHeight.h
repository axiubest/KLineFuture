//
//  UILabel+AutoLabelHeight.h
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoLabelHeight)


+(float)labelWithSting:(NSString *)theContent andWidth:(float)theWidth andFontSize:(float)theSize;

+(UILabel *)quickCreateLabelWithLeft:(CGFloat)left width:(CGFloat)width title:(NSString *)title;
@end
