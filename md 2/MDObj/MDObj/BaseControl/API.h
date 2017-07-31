//
//  API.h
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#ifndef API_h
#define API_h
//static NSString *const patchUpdateURL = @"http://121.40.77.128:9988/";
//static NSString *const KBASEURL = @"http://121.40.77.128:9988";

static NSString *const patchUpdateURL = @"http://www.shangjin666.cn:9988/";
static NSString *const KBASEURL = @"http://www.shangjin666.cn:9988";


static NSString *const APPID = @"wlkx1s5foth387gg6ad780";
static NSString *const XIU_Timestamp = @"1494308898563";
static NSString *const XIU_Signed = @"q5xckoLt1aaolM6+Rb30Lmyy01SMQtzaHJ71arVBiXo6A5PDHsvReNRG/wXOkYPRezutm0c3DhIGff2XPonWneDp4JuBgDTUMhsn6QXtBQmre5icqlgvGv27loA500MSG/anGZzW+AdAkX/CxitAjYK7iQMsHnd6UyE39aOo6Ik=";



static NSString *const XIU_ChooseStockForId = @"Cloud/ChooseStockForId";//获得图形选股详细
static NSString *const XIU_SearchStock = @"Cloud/SearchStock/";//搜索股票提示接口
static NSString *const API_AddStockOption = @"Cloud/AddStockOption";//添加自选
static NSString *const API_XG = @"Cloud/XG";//添加自选
static NSString *const API_GetRanking = @"Cloud/GetRanking";//排行榜
static NSString *const API_GetStockBlockList = @"Cloud/GetStockBlockList";//行情板块
static NSString *const API_MessageList = @"Cloud/MessageList";//行情板块

static NSString *const API_GetStockOptions = @"Cloud/GetStockOptions";//获得自选列表
static NSString *const API_RemoveStockOption = @"Cloud/RemoveStockOption";//获得自选列表
static NSString *const API_ChooseStock = @"Cloud/ChooseStock";//获取图形选股形态
static NSString *const API_ChooseStockForId = @"Cloud/ChooseStockForId";//图形选股详细
static NSString *const API_ZG = @"Cloud/ZG";//诊股
static NSString *const API_HisQuotation = @"Cloud/GetHisQuotation";//历史
static NSString *const API_ChooseStockLike = @"Cloud/GetChooseStockLike";//诊股
static NSString *const API_ZGRanking = @"Cloud/GetZGRanking";//诊股排行榜
static NSString *const API_StockLike = @"Cloud/SetChooseStockLike";//点赞
static NSString *const API_Overview = @"Cloud/GetOverview";//公司概况
static NSString *const API_GetNewsList = @"Cloud/GetNewsList";//资讯列表
static NSString *const API_GetNoticeList = @"Cloud/GetAnnouncementList";//公告列表
static NSString *const API_GetReport = @"Cloud/GetReportSum";//研报统计

static NSString *const API_GetReportList = @"Cloud/GetReportList";//研报统计

static NSString *const API_GetArena = @"Cloud/GetArena";//k线擂台
#endif /* API_h */
