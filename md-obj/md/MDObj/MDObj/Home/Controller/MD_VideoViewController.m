//
//  MD_VideoViewController.m
//  MDObj
//
//  Created by Apple on 17/6/23.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_VideoViewController.h"
#import "MD_HomeVideoListCell.h"
#import "SRWebSocket.h"


//后期视频直播，先期文字， 这里应该引入缓存策略
@interface MD_VideoViewController ()<UITableViewDelegate, UITableViewDataSource,SRWebSocketDelegate>

@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@property (nonatomic, strong)SRWebSocket *webSocket;
@property (nonatomic, strong)NSArray *tmpArr;//投顾直播链接指针
@end

@implementation MD_VideoViewController

-(instancetype)init {
    if (self = [super init]) {
        self.navigationItem.title = @"投顾直播";
    }
    return self;
}


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

// 发送数据到服务器
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"header":@"01",@"id":@"1",@"type":@"0",@"userId":@"1"} options:nil error:&error];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSocket];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_XIUTableView registerNib:[MD_HomeVideoListCell XIU_ClassNib] forCellReuseIdentifier:[MD_HomeVideoListCell XIU_ClassIdentifier]];
    
    [self setSocket];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tmpArr.count > 0) {
        CGFloat cellHeight = [UILabel labelWithSting:_tmpArr[indexPath.row][@"Text"]andWidth:KWIDTH - 20 - 15 - 15 - 35 andFontSize:15];

        return cellHeight + 60;

    }
    return CGFLOAT_MIN;
   }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tmpArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_HomeVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_HomeVideoListCell XIU_ClassIdentifier]];
    [cell setData:_tmpArr[indexPath.row]];
    return cell;
}



@end
