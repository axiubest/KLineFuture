//
//  XIU_Login.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_Login.h"
#import "MJExtension.h"
#import "NSDictionary+Common.h"




static XIU_User *curLoginUser;
@implementation XIU_Login

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phone = @"";
        self.password = @"";
    }
    return self;
}

+ (NSString *)userId {
  
      NSString *str = [[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict] objectForKey:@"AccountId"];
    return str;
}

+ (BOOL)isMobile {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:kLoginUserDict];//如果plist中，mobile不为空，表示有手机号， 为空没有
    
    
    return [[dic objectForKey:@"Mobile"] length]> 0 ? YES : NO;
}


//截取字符串  177****7777
+ (NSString *)userMobile {
    if ([self isMobile]) {
        NSString *str = [[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict] objectForKey:@"Mobile"];
        NSString *tt = [NSString stringWithFormat:@"%@****%@", [str substringToIndex:3], [str substringFromIndex:7]];
        return tt;
        
    }
    return @"";
}

#pragma mark 相应key-Value在此修改---密码加密调用[self.password sha1Str]
- (NSDictionary *)params {
    NSMutableDictionary *param = @{@"userPhone": self.phone,
                                    @"userPass" : self.password,}.mutableCopy;
    return param;
}

+(BOOL)isLogin {
  NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    return loginStatus.boolValue;
 
}

+ (void)doLogin:(NSDictionary *)loginData {
    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        
     NSDictionary *tmpDic = [loginData deleteAllNullValue:loginData];
        [defaults setObject:tmpDic forKey:kLoginUserDict];

        
        curLoginUser = [XIU_User mj_objectWithKeyValues:loginData];
        
        [defaults synchronize];

#pragma mark 在此还应进行所有登录过的用户信息保存
    }else {
        [XIU_Login doLogOut];
    }
}



+ (XIU_User *)curLoginUser {
    if (!curLoginUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
        [[NSUserDefaults standardUserDefaults] synchronize];
        curLoginUser = loginData? [XIU_User mj_objectWithKeyValues:loginData]: nil;
    }
    return curLoginUser;

}

+(void)doLogOut {
    if ([self isLogin]) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@0 forKey:kLoginStatus];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kLoginUserDict];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
//    推送注销
    //缓存删除
}
@end
