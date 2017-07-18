//
//  MD_TheMarketViewController.m
//  MDObj
//
//  Created by Apple on 17/7/3.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_TheMarketViewController.h"
#import "MD_SingleStockHeaderView.h"

#import "UIColor+YYStockTheme.h"
#import "YYFiveRecordModel.h"
#import "YYLineDataModel.h"
#import "YYTimeLineModel.h"
#import "YYStockVariable.h"
#import "AppServer.h"
#import "YYStock.h"
#import "XIU_NavView.h"
#import "SRWebSocket.h"

#import "MD_OptationHSHandicapCell.h"
static BOOL segmentType = NO; //no-盘口， yes－新闻


@interface MD_TheMarketViewController ()<UITableViewDelegate, UITableViewDataSource,YYStockDataSource,SRWebSocketDelegate>


@property (weak, nonatomic) IBOutlet UIButton *handicapBtn;
@property (weak, nonatomic) IBOutlet UIView *handicapLine;
@property (weak, nonatomic) IBOutlet UIButton *importantNewBtn;
@property (weak, nonatomic) IBOutlet UIView *importantNewLine;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (weak, nonatomic) IBOutlet MD_SingleStockHeaderView *titleView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *mainStockView;
@property (nonatomic, weak)SRWebSocket *webSocket;
@property (strong, nonatomic) NSMutableDictionary *stockDatadict;
@property (copy, nonatomic) NSArray *stockDataKeyArray;
@property (copy, nonatomic) NSArray *stockTopBarTitleArray;
@property (strong, nonatomic) YYFiveRecordModel *fiveRecordModel;

@property (strong, nonatomic) YYStock *stock;
@property (nonatomic, assign) NSString *stockId;
@property (weak, nonatomic) UIView *fullScreenView;
/**
 是否显示五档图
 */
@property (assign, nonatomic) BOOL isShowFiveRecord;

//记录当前偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;

@end

@implementation MD_TheMarketViewController


- (instancetype)initWithStockId:(NSString *)stockId title:(NSString *)title isShowFiveRecord:(BOOL)isShowFiveRecord {
    self = [super init];
    if(self) {
        _isShowFiveRecord = isShowFiveRecord;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_XIUTableView registerNib:[MD_OptationHSHandicapCell XIU_ClassNib] forCellReuseIdentifier:[MD_OptationHSHandicapCell XIU_ClassIdentifier]];
    XIU_NavView *v = [[XIU_NavView alloc] initWithFrame:CGRectMake(0, 0, 100, 44) Code:_CodeString StockName:_CodeName];
    v.center = self.view.center;
    self.navigationItem.titleView = v;

    [self initStockView];
    [self fetchData];
      [self setSocket];
}

- (void)setSocket {
    _webSocket.delegate = nil;
    [_webSocket close];
    
    SRWebSocket *socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://www.shangjin666.cn:7181/"]]];
    socket.delegate = self;
    _webSocket = socket;
    [_webSocket open];
}


#pragma mark socket
//收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSMutableString *mString = [NSMutableString stringWithString:message];
    
    NSData *resData = [[NSData alloc] initWithData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];  //解析
    
}
// 发送数据到服务器
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    
#warning !
    NSError *error;
    
    
    
    
    
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"APPID": APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"type":_type == 1 ? @"1" : @"0",@"code":_CodeString,@"sub":@"1"} options:nil error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
 
    
    [self.webSocket sendString:jsonString error:nil];
    //    [self.webSocket sendData:jsonData error:nil];
    
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
    if (segmentType == NO) {
        return 1;
    }
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (segmentType == NO) {
        return 150;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (segmentType == NO) {
        MD_OptationHSHandicapCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_OptationHSHandicapCell XIU_ClassIdentifier]];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell XIU_ClassIdentifier]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell XIU_ClassIdentifier]];
        cell.textLabel.text = @"dgsfsf";
    }
    return cell;

}
- (void)initStockView {
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    
    YYStock *stock = [[YYStock alloc]initWithFrame:self.mainStockView.frame dataSource:self];
    _stock = stock;
    self.mainStockView.backgroundColor = [UIColor colorWithHexString:@"999999"];//控制中间分割线
    [self.mainStockView addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainStockView);
    }];
    //添加单击监听
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stock_enterFullScreen:)];
    //    tap.numberOfTapsRequired = 1;
    //    [self.stock.containerView addGestureRecognizer:tap];
    //    [self.stock.containerView.subviews setValue:@0 forKey:@"userInteractionEnabled"];//可编辑状态
    
}
/*******************************************股票数据源获取更新*********************************************/
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
    
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":_CodeString,@"startDate":DateTime,@"num":@"100",@"type":@"day"} withMethodType:Post andBlock:^(id data, NSError *error) {
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
        [[array reverseObjectEnumerator] allObjects];
        NSArray* reversedArray = [[array reverseObjectEnumerator] allObjects];
        [self.stockDatadict setObject:reversedArray forKey:@"dayList"];
        
    }];
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":_CodeString,@"startDate":DateTime,@"num":@"100",@"type":@"month"} withMethodType:Post andBlock:^(id data, NSError *error) {
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
        [[array reverseObjectEnumerator] allObjects];
        NSArray* reversedArray = [[array reverseObjectEnumerator] allObjects];
        [self.stockDatadict setObject:reversedArray forKey:@"monthList"];
        
    }];
    
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_HisQuotation withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"code":_CodeString,@"startDate":DateTime,@"num":@"100",@"type":@"week"} withMethodType:Post andBlock:^(id data, NSError *error) {
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
        [[array reverseObjectEnumerator] allObjects];
        NSArray* reversedArray = [[array reverseObjectEnumerator] allObjects];
        [self.stockDatadict setObject:reversedArray forKey:@"weekList"];
        
    }];
    
    
}


/*******************************************股票数据源代理*********************************************/
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



/**
 更新全屏顶部数据
 */
- (void)updateStockFullScreenData {
    //    self.stockNameLabel.text = @"YY股票";
    //    self.stockIdLabel.text = @"88888888";
    //    self.stockLatestPriceLabel.text = @"1234.88";
    //    self.stockIncreasePercentLabel.text = @"+1.33   +1.54%";
    //    self.stockLatestUpdateTimeLabel.text = [NSString stringWithFormat:@"更新时间：2016-10-17 22:05:05"];
    
}

/*******************************************getter*********************************************/
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




#pragma mark clcik bottomView
- (IBAction)clickBottom:(UIButton *)sender {
    for (id b in _bottomView.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            UIButton *button = b;

            if (button.tag == sender.tag) {
                [button setTitleColor:[UIColor colorWithHexString:@"378AD6"] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:15 weight:2];
            }else {
                [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:15 weight:0];
                
            }
        }

    }
    if (sender.tag == 100) {
        _handicapLine.hidden = NO;
        _importantNewLine.hidden = YES;
        segmentType = NO;
    }else {
        _handicapLine.hidden = YES;
        _importantNewLine.hidden = NO;
        segmentType = YES;
    }
    [self.XIUTableView reloadData];
    
}


-(NSMutableArray *)dataSource {
    if (!_dataSource) {
//        _dataSource = [NSMutableArray array];
        _dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    }
    return _dataSource;
}
@end
