//
//  MD_QuotationViewController.m
//  MDObj
//
//  Created by Apple on 17/6/20.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_QuotationViewController.h"

#import "MD_OptationDiagnosisView.h"//zg
#import "MD_OutationHSView.h" //hs
#import "MD_OptationPlateView.h"
#import "SRWebSocket.h"
#import "MD_SearchStockVC.h"
@interface MD_QuotationViewController ()<UIScrollViewDelegate,SRWebSocketDelegate>

@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIButton *segmentHS;//沪深
@property (weak, nonatomic) IBOutlet UIButton *segmentPlate;//板块
@property (weak, nonatomic) IBOutlet UIButton *segmentDiagnosis;//诊股排名

@property (weak, nonatomic) IBOutlet UIView *HSLine;
@property (weak, nonatomic) IBOutlet UIView *plateLine;
@property (weak, nonatomic) IBOutlet UIView *diagnosisLine;

@property (weak, nonatomic) IBOutlet UIScrollView *XIUScrollView;


@property (weak, nonatomic)MD_OptationDiagnosisView *diagnosisView;
@property (weak, nonatomic)MD_OutationHSView *hsView;
@property (weak, nonatomic)MD_OptationPlateView *plateView;

@property (nonatomic, strong)SRWebSocket *webSocket;
@end

@implementation MD_QuotationViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"行情";
        
        [self createNavgationButtonWithImageNmae:@"price_btn_search" title:nil target:self action:@selector(clickSearch) type:UINavigationItem_Type_RightItem];
    }
    return self;
}



- (void)setSocket {
    _webSocket.delegate = nil;
    [_webSocket close];
    
    //ws://echo.websocket.org
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://www.shangjin666.cn:7181/"]]];
    _webSocket.delegate = self;
    [_webSocket open];
//    [self webSocketDidOpen:self.webSocket];
}

#pragma mark search
- (void)clickSearch {
    MD_SearchStockVC *vc = [[MD_SearchStockVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _XIUScrollView.contentSize = CGSizeMake(KWIDTH * 3,0);

    [self diagnosisView];
    [self hsView];
    [self plateView];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kHomeDiagnosisStock]) {
        [self clickSegment:_segmentDiagnosis];
    }
    
    [self setSocket];//webSocket链接

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSegment:(UIButton *)sender {
    if (sender != _segmentDiagnosis) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHomeDiagnosisStock];
    }
    for (id obj in self.segmentView.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            if (theButton.tag == sender.tag) {//the btn is select
                [theButton setTitleColor:[UIColor colorWithHexString:@"378AD6"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
                
            }else {
                [theButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];

            }
        }
    }
    
    if (sender.tag == 10) {//HS
        _HSLine.hidden = NO;
        _plateLine.hidden = YES;
        _diagnosisLine.hidden = YES;
        self.XIUScrollView.contentOffset = CGPointMake(0, 0);
        
    }if (sender.tag == 11) {//plate
        _HSLine.hidden = YES;
        _plateLine.hidden = NO;
        _diagnosisLine.hidden = YES;
        self.XIUScrollView.contentOffset = CGPointMake(KWIDTH, 0);
        
    }if (sender.tag ==
         
         12) {//diagnosis
        
        _HSLine.hidden = YES;
        _plateLine.hidden = YES;
        _diagnosisLine.hidden = NO;
        self.XIUScrollView.contentOffset = CGPointMake(KWIDTH * 2, 0);
    }
}


- (void)changeSegmentStyle:(UIButton *)button {
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x / KWIDTH == 0) {
        [self clickSegment:_segmentHS];
    }if (scrollView.contentOffset.x / KWIDTH == 1) {
        [self clickSegment:_segmentPlate];
    }if (scrollView.contentOffset.x / KWIDTH == 2) {
        [self clickSegment:_segmentDiagnosis];
    }
}


#pragma mark socket
//收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSMutableString *mString = [NSMutableString stringWithString:message];
    
    NSData *resData = [[NSData alloc] initWithData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];  //解析
    
    [self.hsView setIndexSocket:resultDic];
    
}

// 发送数据到服务器
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");


     NSError *error;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"APPID": APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"type":@"2",@"code":@"1A0001",@"sub":@"1"} options:1 error:&error];
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




#pragma mark lazy
-(MD_OptationDiagnosisView *)diagnosisView {
    if (!_diagnosisView) {
        MD_OptationDiagnosisView *view = [[MD_OptationDiagnosisView alloc] initWithFrame:CGRectMake(KWIDTH * 2, 0, KWIDTH, KHEIGHT - 49 - 40 - 64) Controller:self];
        
        [self.XIUScrollView addSubview:view];
        _diagnosisView = view;
    }
    return _diagnosisView;
}

-(MD_OutationHSView *)hsView {
    if (!_hsView) {
        MD_OutationHSView *view = [[MD_OutationHSView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - 49 - 40 - 64) Controller:self];
        
        [self.XIUScrollView addSubview:view];
        _hsView = view;
    }
    return _hsView;
}

-(MD_OptationPlateView *)plateView {
    if (!_plateView) {
        MD_OptationPlateView *view = [[MD_OptationPlateView alloc] initWithFrame:CGRectMake(KWIDTH, 0, KWIDTH, KHEIGHT - 49 - 40 - 64) Controller:self];
        [self.XIUScrollView addSubview:view];
        _plateView = view;
 
    }
    return _plateView;
}
@end
