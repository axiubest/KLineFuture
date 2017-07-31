//
//  MD_RequestManager.m
//  MDObj
//
//  Created by Apple on 17/7/17.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_RequestManager.h"
#import "YYLineDataModel.h"
#import "MD_StockChartCompanyInfoModel.h"
@implementation MD_RequestManager

+ (instancetype)sharedManager {
    static MD_RequestManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

//更多-周
- (void)request_MoreKlineOfWeekWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code,@"startDate":date,@"num":@"100",@"type":@"week"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if (data[@"List"]) {
            NSMutableArray *array = [NSMutableArray array];
            
            __block YYLineDataModel *preModel;
            [data[@"List"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                [model updateMA:data[@"List"]];
                NSString *day = [NSString stringWithFormat:@"%@",obj[@"date"]];
                if ([data[@"List"] count] % 18 == ([data[@"List"] indexOfObject:obj] + 1 )%18 ) {
                    model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
                }
                [array addObject: model];
                preModel = model;
            }];
            
            block(array,nil);
            
        }else {
            block(nil,error);
        }
    }];

}

//更多-yeu
- (void)request_MoreKlineOfMonthWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code,@"startDate":date,@"num":@"100",@"type":@"month"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if (data[@"List"]) {
            NSMutableArray *array = [NSMutableArray array];
            
            __block YYLineDataModel *preModel;
            [data[@"List"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                [model updateMA:data[@"List"]];
                NSString *day = [NSString stringWithFormat:@"%@",obj[@"date"]];
                if ([data[@"List"] count] % 18 == ([data[@"List"] indexOfObject:obj] + 1 )%18 ) {
                    model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
                }
                [array addObject: model];
                preModel = model;
            }];
            
            block(array,nil);
            
        }else {
            block(nil,error);
        }
    }];

}






- (void)request_MoreKlineOfDayWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code,@"startDate":date,@"num":@"100",@"type":@"day"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if (data[@"List"]) {
            NSMutableArray *array = [NSMutableArray array];
            
            __block YYLineDataModel *preModel;
            [data[@"List"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                [model updateMA:data[@"List"]];
                NSString *day = [NSString stringWithFormat:@"%@",obj[@"date"]];
                if ([data[@"List"] count] % 18 == ([data[@"List"] indexOfObject:obj] + 1 )%18 ) {
                    model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
                }
                [array addObject: model];
                preModel = model;
            }];
            
            block(array,nil);
            
        }else {
            block(nil,error);
        }
    }];
}

- (void)request_KlineOfDayWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code,@"startDate":date,@"num":@"100",@"type":@"day"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        if (data[@"List"]) {
            NSMutableArray *array = [NSMutableArray array];
            
            __block YYLineDataModel *preModel;
            [data[@"List"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                [model updateMA:data[@"List"]];
                NSString *day = [NSString stringWithFormat:@"%@",obj[@"date"]];
                if ([data[@"List"] count] % 18 == ([data[@"List"] indexOfObject:obj] + 1 )%18 ) {
                    model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
                }
                [array addObject: model];
                preModel = model;
            }];
            array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
            block(array,nil);
 
        }else {
            block(nil,error);
        }
          }];

}

#pragma mark----月线 数据
- (void)request_KlineOfMonthWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code,@"startDate":date,@"num":@"100",@"type":@"month"} withMethodType:Post andBlock:^(id data, NSError *error) {

        if (data[@"List"]) {
            NSMutableArray *array = [NSMutableArray array];
            __block YYLineDataModel *preModel;
            [data[@"List"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                [model updateMA:data[@"List"]];
                NSString *day = [NSString stringWithFormat:@"%@",obj[@"date"]];
                if ([data[@"List"] count] % 18 == ([data[@"List"] indexOfObject:obj] + 1 )%18 ) {
                    model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
                }
                [array addObject: model];
                preModel = model;
            }];
             array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
            block(array,nil);

        }else {
            block(nil,error);

        }

        
    }];

}

#pragma mark----周线 数据
- (void)request_KlineOfWeekWithDate:(NSString *)date CodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code,@"startDate":date,@"num":@"100",@"type":@"week"} withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data[@"List"]) {
            NSMutableArray *array = [NSMutableArray array];
            __block YYLineDataModel *preModel;
            [data[@"List"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
                model.preDataModel = preModel;
                [model updateMA:data[@"List"]];
                NSString *day = [NSString stringWithFormat:@"%@",obj[@"date"]];
                if ([data[@"List"] count] % 18 == ([data[@"List"] indexOfObject:obj] + 1 )%18 ) {
                    model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
                }
                [array addObject: model];
                preModel = model;
            }];
             array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
            block(array,nil);

        }else {
            block(nil,error);
        }

    }];

}

#pragma mark ---- 公司概况
- (void)request_KlineCompanyInfoCodeString:(NSString *)code Block:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_Overview withParams:@{@"code":code} withMethodType:Post andBlock:^(id data, NSError *error) {
        if (![data[@"Data"]isKindOfClass:[NSNull class]]) {
            NSDictionary *dic = data[@"Data"];
            MD_StockChartCompanyInfoModel *model = [[MD_StockChartCompanyInfoModel alloc] init];
            model.CirculatingCapital = dic[@"CirculatingCapital"];
            model.Concept = dic[@"Concept"];
            model.FirstShareholder = dic[@"FirstShareholder"];
            model.Fvaluep = dic[@"Fvaluep"];
            model.Income = dic[@"Income"];
            model.IncomeGrowth = dic[@"IncomeGrowth"];
            model.Investor = dic[@"Investor"];
            model.LeadingStock = dic[@"LeadingStock"];
            model.NetAssets = dic[@"NetAssets"];
            model.NetProfit = dic[@"NetProfit"];
            model.NetProfitGrowth = dic[@"NetProfitGrowth"];
            model.PerShare = dic[@"PerShare"];
            model.Previous = dic[@"Previous"];
            model.RelevantConcept = dic[@"RelevantConcept"];
            model.Shareholder = dic[@"Shareholder"];
            model.TenShareholder = dic[@"TenShareholder"];
            model.ThemePoints = dic[@"ThemePoints"];
            model.TotalShareCapital = dic[@"TotalShareCapital"];
            model.Tvaluep = dic[@"Tvaluep"];
            block(model,nil);
        }else {
            block(nil,error);
        }
    }];
}



@end
