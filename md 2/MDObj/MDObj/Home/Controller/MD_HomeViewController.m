//
//  MD_HomeViewController.m
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_HomeViewController.h"
#import "MD_LargeStockViewController.h"

#import "MD_ImageTableViewCell.h"
#import "MD_HomeSubtitleCell.h"
#import "MD_ThreeButtonCell.h"
#import "MD_HomeLiveRadioIfomCell.h"
#import "MD_HomeLiveRadioHeaderView.h"
#import "MD_HomeSearchView.h"
#import "MD_HomeHeaderView.h"
#import "MD_VideoViewController.h"
#import "SRWebSocket.h"

#import "MD_SingleStockChartVC.h"
#import "MD_SearchStockVC.h"
#import "MD_DiagnosisStockSearchVC.h"
#import "MD_LoginViewController.h"
static NSString   *headerSearchImageStrting = @"home_top_bg_copy";
static NSString   *hugeDataStrategyImageString = @"home_btn_choose";
static NSString   *diagnosisStockImageString = @"home_btn_diagnose";
static NSInteger   liveRadioHeaderViewHeight = 50;
static CGFloat     TableViewCellMargin = 10;

#define HEADER_VIEW_HEIGHT   KHEIGHT * 0.1// 顶部商品图片高度


@interface MD_HomeViewController ()<UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource,clickThreeToolBarDelegate,SRWebSocketDelegate>

@property (nonatomic, weak)UITableView *XIUTableView;
@property (nonatomic, weak)UIView *headerView;
@property (nonatomic, strong)SRWebSocket *webSocket;
@property (nonatomic, strong)NSArray *tmpArr;//投顾直播链接指针

@end

@implementation MD_HomeViewController


- (void)setSocket {
    _webSocket.delegate = nil;
    [_webSocket close];
    
    //ws://echo.websocket.org
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://www.shangjin666.cn:7182/"]]];
    _webSocket.delegate = self;
    [_webSocket open];
}


#pragma mark socket
//收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSMutableString *mString = [NSMutableString stringWithString:message];
    
    NSData *resData = [[NSData alloc] initWithData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];  //解析
    _tmpArr = [resultDic objectForKey:@"List"];
    
    [self.XIUTableView reloadData];
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"header":@"01",@"id":@"1",@"type":@"0",@"userId":@"1"} options:5 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSocket];
    });
}



- (void)viewDidLoad {
    [super viewDidLoad];
      [self XIUTableView];
    [self setHeaderView];
        [self setSocket];//webSocket链接
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;


}

- (void)setHeaderView {
    
    MD_HomeHeaderView *v = [[NSBundle mainBundle]loadNibNamed:[MD_HomeHeaderView XIU_ClassIdentifier] owner:self options:nil].lastObject;

    v.frame = CGRectMake(0, 0, KWIDTH, 64);
    [v bk_whenTapped:^{
        [self.navigationController pushViewController:[[MD_SearchStockVC alloc] init] animated:YES];
    }];
    [self.view addSubview:v];
    
    _headerView = v;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.XIUTableView.contentOffset.y >= 0 &&  self.XIUTableView.contentOffset.y <= HEADER_VIEW_HEIGHT) {
        
        self.headerView.alpha = self.XIUTableView.contentOffset.y / HEADER_VIEW_HEIGHT;
    } else if (self.XIUTableView.contentOffset.y < 0) {
        self.headerView.alpha = 0.0f;
    } else {
        self.headerView.alpha = 1.0f;

    }
}


#pragma mark----------tableViewDelegate--------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case HomeTableViewCellStyle_Search: {
            [self.navigationController pushViewController:[[MD_SearchStockVC alloc] init] animated:YES];
            
        }
            break;
        case HomeTableViewCellStyle_DiagnosisStock: {
            MD_DiagnosisStockSearchVC *vc = [[MD_DiagnosisStockSearchVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
    
        }
            break;
        case HomeTableViewCellStyle_LiveRadio: {
            MD_VideoViewController *vc = [[MD_VideoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case HomeTableViewCellStyle_SelectStock: {
        [[NSNotificationCenter defaultCenter] postNotificationName:SelectStockNoti object:nil];
            
 ;

        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case HomeTableViewCellStyle_Search:
            return 100;
            break;
        case HomeTableViewCellStyle_DiagnosisStock:
            return 90;
            break;

        case HomeTableViewCellStyle_SelectStock:
            return 90;
            break;
        case HomeTableViewCellStyle_Tool:
            return 80;
            break;
        case HomeTableViewCellStyle_LiveRadio:
            return 130;
            break;
        default:
            break;
    }
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == HomeTableViewCellStyle_LiveRadio ? 2 : 1;//投顾直播显示最新的两条数据
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == HomeTableViewCellStyle_DiagnosisStock ? CGFLOAT_MIN : section == HomeTableViewCellStyle_LiveRadio ? liveRadioHeaderViewHeight : TableViewCellMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == HomeTableViewCellStyle_Tool ? TableViewCellMargin : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        MD_HomeLiveRadioHeaderView *view = [[MD_HomeLiveRadioHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, liveRadioHeaderViewHeight)];
        [view bk_whenTapped:^{//更多
            MD_VideoViewController *vc = [[MD_VideoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return view;
    }
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == HomeTableViewCellStyle_Search) {
        MD_ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_ImageTableViewCell XIU_ClassIdentifier]];
        cell.imgView.image = [UIImage imageNamed:headerSearchImageStrting];
        return cell;
    }
    if (indexPath.section == HomeTableViewCellStyle_SelectStock) {
        MD_HomeSubtitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_HomeSubtitleCell XIU_ClassIdentifier]];
        cell.imgView.image = [UIImage imageNamed:hugeDataStrategyImageString];
        cell.titleLab.text = @"形态选股";
        cell.discribtionLab.text = @"精准 量化 全市场筛选";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
        


    }
    if (indexPath.section == HomeTableViewCellStyle_DiagnosisStock) {
        MD_HomeSubtitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_HomeSubtitleCell XIU_ClassIdentifier]];
        cell.imgView.image = [UIImage imageNamed:diagnosisStockImageString];
        cell.titleLab.text = @"智能诊股";
        cell.discribtionLab.text = @"海量大数据 人工智能预测股票未来";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }if (indexPath.section == HomeTableViewCellStyle_Tool) {
        MD_ThreeButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_ThreeButtonCell XIU_ClassIdentifier]];
        cell.delegate = self;
        return cell;
    }if (indexPath.section == HomeTableViewCellStyle_LiveRadio) {
        MD_HomeLiveRadioIfomCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_HomeLiveRadioIfomCell XIU_ClassIdentifier]];
        if (_tmpArr.count >1) {
            if (indexPath.row == 0) {
                [cell setRadioCellData:_tmpArr[0]];
            }
            if (indexPath.row == 1) {
                [cell setRadioCellData:_tmpArr[1]];
            }

        }
        return cell;
    }
    
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"my_news_icon_dot"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
    return cell;
}


#pragma mark 三个圆按钮点击方法
//K线擂台
- (void)clickKlinePKBtn {
    if (![XIU_Login isLogin]) {
        MD_LoginViewController *vc = [[MD_LoginViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    NSString *tmp = [NSString stringWithFormat:@"http://wx.shangjin666.cn/index.html#/klinearena?userId=%@",[XIU_Login userId]];
    MD_LargeStockViewController *v = [[MD_LargeStockViewController alloc] init];
    v.url = tmp;
    v.navgationItemTitle = @"K线擂台";
    [self.navigationController pushViewController:v animated:YES];

}


//诊股排名
- (void)clickDiagnosisStockBtn {
    [[NSUserDefaults standardUserDefaults] setObject:kHomeDiagnosisStock forKey:kHomeDiagnosisStock];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeDiagnosisStock object:nil];
    
    
}

//大数据分析
- (void)clickBigDataBtn {
    MD_LargeStockViewController *v = [[MD_LargeStockViewController alloc] init];
    v.url = @"http://wx.shangjin666.cn/index.html#/bigdata";
    v.navgationItemTitle = @"大数据策略";
      [self.navigationController pushViewController:v animated:YES];
}


- (void)clickHotMsgBtn {
    MD_LargeStockViewController *v = [[MD_LargeStockViewController alloc] init];
    v.url = @"http://wx.shangjin666.cn/index.html#/message";
    v.navgationItemTitle = @"热门消息";
    [self.navigationController pushViewController:v animated:YES];

}



#pragma mark lazy

-(UITableView *)XIUTableView {
    if (!_XIUTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-30, KWIDTH, self.view.height - 20) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        
        [tableView registerNib:[MD_ImageTableViewCell XIU_ClassNib] forCellReuseIdentifier:[MD_ImageTableViewCell XIU_ClassIdentifier]];
         [tableView registerNib:[MD_HomeSubtitleCell XIU_ClassNib] forCellReuseIdentifier:[MD_HomeSubtitleCell XIU_ClassIdentifier]];
        
         [tableView registerNib:[MD_ThreeButtonCell XIU_ClassNib] forCellReuseIdentifier:[MD_ThreeButtonCell XIU_ClassIdentifier]];
        
         [tableView registerNib:[MD_HomeLiveRadioIfomCell XIU_ClassNib] forCellReuseIdentifier:[MD_HomeLiveRadioIfomCell XIU_ClassIdentifier]];
        
        
        _XIUTableView = tableView;
    }
    return _XIUTableView;
}


-(void)dealloc {
    _webSocket = nil;
}
@end
