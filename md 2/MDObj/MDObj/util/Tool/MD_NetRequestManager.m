//
//  MD_NetRequestManager.m
//  MDObj
//
//  Created by Apple on 17/7/5.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_NetRequestManager.h"
#import "MD_DiagnosisDetialModel.h"
#import "MD_DiagnosisDetialSelfModel.h"
#import "MD_SelectStockKLineDateModel.h"
@implementation MD_NetRequestManager

+ (instancetype)sharedManager {
    static MD_NetRequestManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

//这个接口写的好
- (void)request_WithCodeString:(NSString *)code ZGBlock:(void (^)(id data, NSError *error))block {
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_ZG withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":code} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        
#pragma mark 接口未写好， 缺少一层判断
        if (![[data objectForKey:@"Success"] isEqualToString:@"true"]) {
            block(@"没有匹配到相似的历史走势",error);
            return ;
        }
        NSMutableDictionary *dic = [data objectForKey:@"Result"];
        if (dic) {
            
        MD_DiagnosisDetialModel *model = [[MD_DiagnosisDetialModel alloc] init];
        model.StockName = [dic objectForKey:@"StockName"];
        model.Code = [dic objectForKey:@"Code"];
        model.Num = [dic objectForKey:@"Num"];
        model.DayRise = [dic objectForKey:@"DayRise"];
        model.DayRiseRate = [dic objectForKey:@"DayRiseRate"];
        model.WeekRise = [dic objectForKey:@"WeekRise"];
        model.WeekRiseRate = [dic objectForKey:@"WeekRiseRate"];
        model.MonthRise = [dic objectForKey:@"MonthRise"];
        model.MonthRiseRate = [dic objectForKey:@"MonthRiseRate"];
        model.QuarterRise = [dic objectForKey:@"QuarterRise"];
        model.QuarterRiseRate = [dic objectForKey:@"QuarterRiseRate"];
            
        model.detialSelfModel.Code = [[dic objectForKey:@"Self"] objectForKey:@"Code"];
        model.detialSelfModel.StockName = [[dic objectForKey:@"Self"] objectForKey:@"StockName"];
        model.detialSelfModel.Score = [[dic objectForKey:@"Self"] objectForKey:@"Score"];
        model.detialSelfModel.DateStart = [[dic objectForKey:@"Self"] objectForKey:@"DateStart"];
        model.detialSelfModel.DateEnd = [[dic objectForKey:@"Self"] objectForKey:@"DateEnd"];
            
            
            NSMutableArray *ksArr = [NSMutableArray array];
            for (NSDictionary *obj in [[dic objectForKey:@"Self"] objectForKey:@"Ks"]) {
                MD_SelectStockKLineDateModel *model = [[MD_SelectStockKLineDateModel alloc] init];
                model.OpenPrice = [obj objectForKey:@"OpenPrice"];
                model.ClosePrice = [obj objectForKey:@"ClosePrice"];
                model.MaxPrice = [obj objectForKey:@"MaxPrice"];
                model.MinPrice = [obj objectForKey:@"MinPrice"];
                model.Date = [obj objectForKey:@"Date"];
                model.TradeNum = [obj objectForKey:@"TradeNum"];
                [ksArr addObject:model];
            }
            model.detialSelfModel.Ks = ksArr;

            
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[[dic objectForKey:@"Self"] objectForKey:@"FutureDatas"]];
        model.FutureDatas = arr;
            
            //---------sections----------
            NSMutableArray *SectionsArr = [NSMutableArray array];
            
            for (NSDictionary *obj in [dic objectForKey:@"Sections"]) {
                MD_DiagnosisDetialSelfModel *model = [[MD_DiagnosisDetialSelfModel alloc] init];
                
                model.Code = [obj objectForKey:@"Code"];
                NSLog(@"%@", model.Code);
                model.StockName = [obj objectForKey:@"StockName"];
                model.Score = [obj objectForKey:@"Score"];
                model.DateStart = [obj objectForKey:@"DateStart"];
                model.DateEnd = [obj objectForKey:@"DateEnd"];
                
                
                NSMutableArray *SectionsKsArr2 = [NSMutableArray array];
                model.Ks = SectionsKsArr2;
                for (NSDictionary *ob in [obj objectForKey:@"Ks"]) {
                    MD_SelectStockKLineDateModel *model = [[MD_SelectStockKLineDateModel alloc] init];
                    model.OpenPrice = [ob objectForKey:@"OpenPrice"];
                    model.ClosePrice = [ob objectForKey:@"ClosePrice"];
                    model.MaxPrice =[ob objectForKey:@"MaxPrice"];
                    model.MinPrice = [ob objectForKey:@"MinPrice"];
                    model.Date = [ob objectForKey:@"Date"];
                    model.TradeNum = [ob objectForKey:@"TradeNum"];
                    [SectionsKsArr2 addObject:model];
                }
                
                [SectionsArr addObject:model];
            }
            model.detialSectionModel.sectionsArr = SectionsArr;
            
            
            block(model, nil);
            
        }else {
            block(nil,error);
        }
        
    }];
}
@end
