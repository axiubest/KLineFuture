//
//  MD_SingleStockChartVC.m
//  MDObj
//
//  Created by Apple on 17/6/27.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SingleStockChartVC.h"
#import "UIColor+YYStockTheme.h"
#import "YYFiveRecordModel.h"
#import "YYLineDataModel.h"
#import "YYTimeLineModel.h"
#import "YYStockVariable.h"
#import "AppServer.h"
#import "YYStock.h"
#import "SRWebSocket.h"
#import "FloatView.h"

#import "XIU_NavView.h"
#import "MD_SingleStockNewSegmentView.h"

#import "MD_SingleStockCompanyInfoCell.h"//公司概况
#import "MD_SingleStockInformationCell.h"//资讯

#import "MD_StockChartCompanyInfoModel.h"
#import "MD_StockChartNewsListModel.h"
#import "MD_LargeStockViewController.h"
#import "MJRefresh.h"
#import "MD_DiagnosisStockBaseVC.h"
static NSInteger xstartIndex = 1;
static NSInteger xendIndex = 15;
@interface MD_SingleStockChartVC ()<YYStockDataSource,SRWebSocketDelegate,MD_SingleStockNewSegmentViewDelegate,UITableViewDelegate, UITableViewDataSource, FloatViewDelegate>
{
    NSInteger SegmentType;//股票图下方四个按钮点击状态，默认选择第一个
}
@property (nonatomic, strong)MBProgressHUD *hud;


@property (weak, nonatomic) IBOutlet UILabel *nowPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *numLab;

@property (weak, nonatomic) IBOutlet UILabel *presentLab;

@property (weak, nonatomic) IBOutlet UILabel *todayStartLab;//
@property (weak, nonatomic) IBOutlet UILabel *tradeNumLab;//成交股票数
@property (weak, nonatomic) IBOutlet UILabel *tradeAmountLab;//成交金额
@property (weak, nonatomic) IBOutlet UILabel *closePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *turnoverLab;//换手率
@property (weak, nonatomic) IBOutlet UILabel *fvaluepLab;//市盈率
@property (nonatomic, weak) NSArray *tmpArr;
/**
 K线数据源
 */
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@property (strong, nonatomic) NSMutableDictionary *stockDatadict;

@property (copy, nonatomic) NSArray *stockDataKeyArray;

@property (copy, nonatomic) NSArray *stockTopBarTitleArray;

@property (strong, nonatomic) YYFiveRecordModel *fiveRecordModel;

@property (nonatomic, strong)SRWebSocket *webSocket;

@property (strong, nonatomic) YYStock *stock;

@property (nonatomic, assign) NSString *stockId;

@property (weak, nonatomic) UIView *fullScreenView;

@property (weak, nonatomic) IBOutlet UIView *stockContainerView;

/**
 是否显示五档图
 */
@property (assign, nonatomic) BOOL isShowFiveRecord;


@property (nonatomic ,weak)NSMutableArray *tmpDayArray;
@property (nonatomic ,weak)NSMutableArray *tmpWeekArray;
@property (nonatomic ,weak)NSMutableArray *tmpMonthArray;


@property (nonatomic, weak) MD_SingleStockNewSegmentView *segmentView;


@property (nonatomic ,weak)MD_StockChartCompanyInfoModel *companyModel;
@property (nonatomic, strong) NSMutableArray *informationArray;
@property (nonatomic, strong) NSMutableArray *researchReportArray;
@property (nonatomic, strong) NSMutableArray *noticeArray;
@property (nonatomic, strong) FloatView *floatView;


@end

@implementation MD_SingleStockChartVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //        [NSString showHUD:@"" andView:self.view andHUD:self.hud];
    {
        XIU_NavView *v = [[XIU_NavView alloc] initWithFrame:CGRectMake(0, 0, 100, 44) Code:_CodeString StockName:_CodeName];
        v.center = self.view.center;
        
        self.navigationItem.titleView = v;
        
        
    }
    SegmentType = 0;//默认选择第一个
    _isShowFiveRecord = YES;
    [self initStockView];
    [self.stockDatadict removeAllObjects];
    [self fetchData];
    [self setSocket];//webSocket链接
    [self loadTableViewCell];
    [self requestCompanyInformation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestMore:) name:ScrollEnd object:nil];
    [self addRefresh];
    
    
    if (!_isFloatView == YES) {
        self.floatView = [FloatView floatViewWithRadius:30 point:CGPointMake(0 , self.view.bounds.size.height) color:[UIColor colorWithHexString:@"FF6868"] inView:self.view];
        //设置代理（代理方法调用在最下方）
        self.floatView.delegate = self;
        self.floatView.label.text = @"诊它一下";
        self.floatView.label.font = [UIFont systemFontOfSize:15];
        self.floatView.label.textColor = [UIColor whiteColor];
        //    [self.floatView startProgressAnimation];
        [self.floatView startBitAnimation];
    }


}

- (void)floatViewClicked {
    MD_DiagnosisStockBaseVC *vc = [[MD_DiagnosisStockBaseVC alloc] init];
    vc.CodeString = _CodeString;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addRefresh {
    self.XIUTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        xstartIndex+=15;
        xendIndex +=15;
        if (SegmentType == SingleStockSegmentAtyle_Notice) {
            [self requestNotice];
        }
      
    }];
    
}
//刷新第一个section 既刷新所有数据
- (void)reload {
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.XIUTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}

- (instancetype)initWithStockId:(NSString *)stockId title:(NSString *)title isShowFiveRecord:(BOOL)isShowFiveRecord {
    self = [super init];
    
    if(self) {
        _isShowFiveRecord = isShowFiveRecord;
        
         }
    return self;
}

-(void)setSocket {
    _webSocket.delegate = nil;
    [_webSocket close];
    
    //ws://echo.websocket.org
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://www.shangjin666.cn:7181/"]]];
    _webSocket.delegate = self;
    [_webSocket open];
}


#pragma mark socket
//收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
 

    NSMutableString *mString = [NSMutableString stringWithString:message];
    
    NSData *resData = [[NSData alloc] initWithData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];  //解析
    
    if ([[resultDic allKeys] containsObject:@"showapi_res_body"]) {//分时图
        _tmpArr = resultDic[@"showapi_res_body"][@"dataList"][0][@"minuteList"];

        NSMutableArray *array = [NSMutableArray array];
        [_tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YYTimeLineModel *model = [[YYTimeLineModel alloc]initWithDict:obj];
            [array addObject: model];
            
        }];
        
        [self.stockDatadict setObject:array forKey:@"minutes"];
     
        
    }else if ([resultDic objectForKey:@"all_value"]) {
        if (self.isShowFiveRecord) {
            self.fiveRecordModel = [[YYFiveRecordModel alloc]initWithDict:resultDic];
        }

        
        _nowPriceLab.text =[NSString MD_StringToFloatWithString:[NSString stringWithFormat:@"%@", resultDic[@"nowPrice"]]];
        _numLab.text =[NSString stringWithFormat:@"%@%%", resultDic[@"diff_rate"]] ;
        _presentLab.text = [NSString stringWithFormat:@"%@", resultDic[@"diff_money"]];
        _todayStartLab.text =[NSString stringWithFormat:@"%.2f", [resultDic[@"openPrice"] floatValue]] ;
        
        _tradeNumLab.text =[NSString numberChangeWord:[NSString stringWithFormat:@"%@", resultDic[@"tradeNum"]]] ;
        
        NSString *amount = [NSString stringWithFormat:@"%@", resultDic[@"tradeAmount"]];
        
        _tradeAmountLab.text = [NSString numberChangeWord:amount];
        _closePriceLab.text =[NSString stringWithFormat:@"%.2f", [resultDic[@"yestodayClosePrice"] floatValue]];
        _turnoverLab.text = resultDic[@"turnover"];
        _fvaluepLab.text = @"--";//后台没接口
        

        if ([_presentLab.text hasPrefix:@"-"]) {
            _presentLab.textColor = [UIColor colorWithHexString:@"1CB54A"];
            _nowPriceLab.textColor = _presentLab.textColor;
            _numLab.textColor = _presentLab.textColor;
            _todayStartLab.textColor = _presentLab.textColor;


        }else {
            _presentLab.textColor = [UIColor colorWithHexString:@"FF5E45"];
            _nowPriceLab.textColor = _presentLab.textColor;
            _numLab.textColor = _presentLab.textColor;
            _todayStartLab.textColor = _presentLab.textColor;
        }
        
    }

    
    //draw为全部绘制，不加此句当点击日周月k线时，也会刷新
    if (_stock.currentIndex == 0) {
        [self.stock draw];
    }
    //if two socket is update
//    if ([[resultDic allKeys] containsObject:@"showapi_res_body"] && [resultDic objectForKey:@"all_value"]) {
//        [self.hud hide:YES];
//        [self.XIUTableView reloadData];
//    }

    
}

// 发送数据到服务器
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    /*

     this is two socket request in this page, type-0 is now information, type-1 is time line. the two request array is data souce of this .
     */
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"code":_CodeString,@"type":@"0",@"sub":@"1"} options:1 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:@{@"code":_CodeString,@"type":@"1",@"sub":@"1"} options:1 error:&error];
    NSString *jsonString2 = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    [self.webSocket sendString:jsonString2 error:nil];
    
    [self.webSocket sendString:jsonString error:nil];
    
}

//连接关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed");
    self.webSocket = nil;
}

//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket Failed With Error %@", error);
    webSocket = nil;
    // 断开连接后每过1s重新建立一次连接
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSocket];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (SegmentType == SingleStockSegmentAtyle_CompanyInfo) {
        return 1;
    }
    if (SegmentType == SingleStockSegmentAtyle_Information) {

        return self.informationArray.count;
    }
    if (SegmentType == SingleStockSegmentAtyle_ResearchReport) {
        return 1;
    }
    return self.noticeArray.count;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SegmentType == SingleStockSegmentAtyle_CompanyInfo) {
        return 850 *SCREEN_SCALE;
    }
    if (SegmentType == SingleStockSegmentAtyle_Information) {
        return 70 *SCREEN_SCALE;
    }
    if (SegmentType == SingleStockSegmentAtyle_ResearchReport) {
        return 100 *SCREEN_SCALE;
    }
    if (SegmentType == SingleStockSegmentAtyle_Notice) {
        return  70 *SCREEN_SCALE;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? self.segmentView : nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (SegmentType == SingleStockSegmentAtyle_Notice) {
            MD_LargeStockViewController *vc = [[MD_LargeStockViewController alloc] init];
            vc.url =[NSString stringWithFormat:@"http://wx.shangjin666.cn/index.html#/rescontent?type=notice&id=%@", [self.noticeArray[indexPath.row] Id]];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (SegmentType == SingleStockSegmentAtyle_Information) {
            MD_LargeStockViewController *vc = [[MD_LargeStockViewController alloc] init];
            vc.url =[NSString stringWithFormat:@"http://wx.shangjin666.cn/index.html#/rescontent?type=info&id=%@", [self.informationArray[indexPath.row] Id]];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SegmentType == SingleStockSegmentAtyle_CompanyInfo) {
        MD_SingleStockCompanyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SingleStockCompanyInfoCell XIU_ClassIdentifier]];
        cell.model = self.companyModel; 
        return cell;
    }
    if (SegmentType == SingleStockSegmentAtyle_Information ||SegmentType == SingleStockSegmentAtyle_Notice) {
        MD_SingleStockInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SingleStockInformationCell XIU_ClassIdentifier]];
        cell.titile.text = SegmentType == SingleStockSegmentAtyle_Information ? [self.informationArray[indexPath.row] Title] :  [self.noticeArray[indexPath.row] Title];
        cell.time.text = SegmentType == SingleStockSegmentAtyle_Information ? [self.informationArray[indexPath.row] TimeBefore] :  [self.noticeArray[indexPath.row] TimeBefore];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"1"];
    }
    return cell;
}


#pragma mark click segment bar delegate
- (void)clickNewsSegmentViewButton:(UIButton *)btn {
    SegmentType = btn.tag;
    [self reload];
    if (SegmentType == SingleStockSegmentAtyle_CompanyInfo) {
        [self requestCompanyInformation];
    }if (SegmentType == SingleStockSegmentAtyle_Information) {//资讯
        [self requestInformation];
    }if (SegmentType == SingleStockSegmentAtyle_Notice) {
        [self.noticeArray removeAllObjects];
        [self requestNotice];
    }
    
}



- (void)loadTableViewCell {
    [_XIUTableView registerNib:[MD_SingleStockCompanyInfoCell XIU_ClassNib] forCellReuseIdentifier:[MD_SingleStockCompanyInfoCell XIU_ClassIdentifier]];
    [_XIUTableView registerNib:[MD_SingleStockInformationCell XIU_ClassNib] forCellReuseIdentifier:[MD_SingleStockInformationCell XIU_ClassIdentifier]];
}
- (void)initStockView {
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    
    YYStock *stock = [[YYStock alloc]initWithFrame:self.stockContainerView.frame dataSource:self];
    _stock = stock;
    self.stockContainerView.backgroundColor = [UIColor colorWithHexString:@"999999"];//控制中间分割线
    [self.stockContainerView addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stockContainerView);
    }];
    //添加单击监听
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stock_enterFullScreen:)];
//    tap.numberOfTapsRequired = 1;
//    [self.stock.containerView addGestureRecognizer:tap];
//    [self.stock.containerView.subviews setValue:@0 forKey:@"userInteractionEnabled"];//可编辑状态
    
}


//#pragma mark 单击事件
//- (void)stock_enterFullScreen:(UITapGestureRecognizer *)tap {
//    
//}

- (void)requestInformation {//加载更多后续做d
    [self.informationArray removeAllObjects];
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_GetNewsList withParams:@{@"code" : _CodeString,@"startIndex" : @"1", @"endIndex" : @"30"} withMethodType:Post andBlock:^(id data, NSError *error) {
            for (NSDictionary *obj in data[@"Newses"]) {
                MD_StockChartNewsListModel *model = [[MD_StockChartNewsListModel alloc] init];
                model.Id = obj[@"Id"];
                model.TimeBefore = obj[@"TimeBefore"];
                model.Title = obj[@"Title"];
                [self.informationArray addObject:model];
            }
     
            [self reload];

    }];

}


//公告网络请求
- (void)requestNotice {
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_GetNoticeList withParams:@{@"code" : _CodeString,@"startIndex" :[NSString stringWithFormat:@"%ld", xstartIndex], @"endIndex" :[NSString stringWithFormat:@"%ld", xendIndex]} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        for (NSDictionary *obj in data[@"List"]) {
            MD_StockChartNewsListModel *model = [[MD_StockChartNewsListModel alloc] init];
            model.Id = obj[@"Id"];
            model.TimeBefore = obj[@"TimeBefore"];
            model.Title = obj[@"Title"];
            [self.noticeArray addObject:model];
        }

        [self reload];
    }];
}

- (void)requestCompanyInformation {
    
    //公司信息
   [[MD_RequestManager sharedManager]request_KlineCompanyInfoCodeString:_CodeString Block:^(id data, NSError *error) {
       self.companyModel = data;
       [self reload];
   }];
}

/*********************股票数据源获取更新***********************/
/**
 网络获取K线数据
 */

- (void)fetchData {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *DateTime = [formatter stringFromDate:date];


    [[MD_RequestManager sharedManager]request_KlineOfDayWithDate:DateTime CodeString:_CodeString Block:^(id data, NSError *error) {
            _tmpDayArray = data;
            [self.stockDatadict setObject:data forKey:@"dayList"];
    }];
    
  [[MD_RequestManager sharedManager]request_KlineOfMonthWithDate:DateTime CodeString:_CodeString Block:^(id data, NSError *error) {
      _tmpMonthArray = data;
      [self.stockDatadict setObject:data forKey:@"monthList"];

  }];
    
  [[MD_RequestManager sharedManager] request_KlineOfWeekWithDate:DateTime CodeString:_CodeString Block:^(id data, NSError *error) {
      _tmpWeekArray = data;
      [self.stockDatadict setObject:data forKey:@"weekList"];

  }];

}

#pragma mark 加载更多数据
- (void)requestMore:(NSNotification *)sender {
//    获取数组第一个元素日期
    if (self.stock.currentIndex == 1) {//日
              NSString *DateTime = [[_tmpDayArray[0] Day] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [[MD_RequestManager sharedManager]request_KlineOfDayWithDate:DateTime CodeString:_CodeString Block:^(id data, NSError *error) {
            for (YYLineDataModel *obj in data) {
                [_tmpDayArray insertObject:obj atIndex:0];
            }
            [self.stockDatadict setObject:_tmpDayArray forKey:@"dayList"];

        }];
        [self.stock draw];

    }
}


/***********************股票数据源代理*************************/
-(NSArray <NSString *> *) titleItemsOfStock:(YYStock *)stock {
    return self.stockTopBarTitleArray;
}

-(NSArray *) YYStock:(YYStock *)stock stockDatasOfIndex:(NSInteger)index {
    return index < self.stockDataKeyArray.count ? self.stockDatadict[self.stockDataKeyArray[index]] : nil;
}

-(YYStockType)stockTypeOfIndex:(NSInteger)index {
    
    return index == 0 ? YYStockTypeTimeLine : YYStockTypeLine;
}

- (id<YYStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index {
    return self.fiveRecordModel;
}

- (BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index {
    return self.isShowFiveRecord;
}


- (NSString *)getToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)dealloc {
    NSLog(@"DEALLOC");
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
/**********************getter****************************/
- (NSMutableDictionary *)stockDatadict {
    if (!_stockDatadict) {
        _stockDatadict = [NSMutableDictionary dictionary];
    }
    return _stockDatadict;
}

- (NSArray *)stockDataKeyArray {
    if (!_stockDataKeyArray) {
        _stockDataKeyArray = @[@"minutes",@"dayList",@"weekList",@"monthList"];
    }
    return _stockDataKeyArray;
}

- (NSArray *)stockTopBarTitleArray {
    if (!_stockTopBarTitleArray) {
        
        _stockTopBarTitleArray = @[@"分时",@"日K",@"周K",@"月K"];
    }
    return _stockTopBarTitleArray;
}


-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];
        
    }
    return _hud;
}


-(NSMutableArray *)informationArray {
    if (!_informationArray) {
        _informationArray = [NSMutableArray array];
    }
    return _informationArray;
}



- (NSMutableArray *)noticeArray {
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray array];

    }
    
    return _noticeArray;
}

-(NSMutableArray *)researchReportArray {
    if (!_researchReportArray) {
        NSMutableArray *arr = [NSMutableArray array];
        _researchReportArray= arr;
    }
    return _researchReportArray;
}

-(MD_SingleStockNewSegmentView *)segmentView {
    if (!_segmentView) {
        MD_SingleStockNewSegmentView *v = [MD_SingleStockNewSegmentView loadSegmentView];
        v.frame = CGRectMake(0, 0, KWIDTH, 50);
        v.delegate = self;
        _segmentView = v;
    }
    return _segmentView;
}
@end
