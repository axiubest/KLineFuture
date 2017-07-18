//
//  NSString+XIU_Extras.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/26.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)


+ (NSString *)appendingPresentWithString:(NSString *)str {
    if (!str) {
        return @"-.--%";
    }
    return [NSString stringWithFormat:@"%@%%", str];
}

+ (NSString *)numberChangeWord:(NSString *)number {
    number = [NSString stringWithFormat:@"%ld", [number integerValue]];
    if (number.length > 8) {
        return [NSString stringWithFormat:@"%@亿",[number substringToIndex:number.length-8]];
    }
    if (number.length > 7 || number.length > 6 || number.length > 5) {
        return [NSString stringWithFormat:@"%@万",[number substringToIndex:number.length-5]];
    }
    return number;
}

//总股本取整转万亿
+(NSString *)MD_AllStockStringToFloatWithString:(NSString *)str {
    NSString *str1 = [str isKindOfClass:[NSNull class]] ? @"0" : str;
    if ([str1 rangeOfString:@"."].location != NSNotFound) {
        //字符串包涵. 1为空判断， 健壮性判断 截取小数点后两位
        NSInteger f = [str1 floatValue];
        str1 = [NSString stringWithFormat:@"%ld", f];
    }
    if (str1.length >= 4) {
        return [NSString stringWithFormat:@"%@亿", [str1 substringToIndex:[str1 length] - 3]];
    }
    return str1;

}


+(NSString *)DeletePointString:(NSString *)str {
    NSString *str1 = [str isKindOfClass:[NSNull class]] ? @"0" : str;
    if ([str1 rangeOfString:@"."].location != NSNotFound) {
        //字符串包涵. 1为空判断， 健壮性判断 截取小数点后两位
        
        NSInteger f = [str1 floatValue];
        return [NSString stringWithFormat:@"%ld", f];
    }
    return str1;
}

+(NSString *)MD_StringToFloatWithString:(NSString *)str {
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    NSString *str1 = [str isKindOfClass:[NSNull class]] ? @"" : str;
    
    if ([str1 containsString:@"."]) {
        //字符串包涵. 为空判断， 健壮性判断 截取小数点后两位
        CGFloat f = [str1 floatValue];
        return  [NSString stringWithFormat:@"%.2f", f];
    }
    
    return str1;
}

+(NSString *)XIU_IsEmpty:(NSString *)str {
    return  [str isKindOfClass:[NSNull class]] ? @"" : str;

}

- (NSString *)xiu_substringAfterString:(NSString *)string {
    NSArray *components = [self componentsSeparatedByString:string];
    if ([components count] > 2) {
        return components[1];
    } else {
        return [components lastObject];
    }
}


+ (NSMutableAttributedString*)SetStringOfShoppingCartPriceString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *String = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [String addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [String addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return String;
}

- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}








//1. 整形判断
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//2.浮点形判断：
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 不能全部为数字
 不能全部为字母
 必须包含字母和数字
 6-20位
 
 @return 密码输入
 */
+(BOOL)checkPassWord:(NSString *)password
{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *  pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return YES ;
    }else
        return NO;
}



+(BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€ "]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

@end
