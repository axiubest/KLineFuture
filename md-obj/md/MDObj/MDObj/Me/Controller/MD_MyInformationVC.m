//
//  MD_MyInformationVC.m
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_MyInformationVC.h"

@interface MD_MyInformationVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) UITableView *XIUTableView;
@end

@implementation MD_MyInformationVC

-(instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"我的消息";


    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self XIUTableView];
    [self request];
}

- (void)request {
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_MessageList withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"uid":[XIU_Login userId]} withMethodType:Post andBlock:^(id data, NSError *error) {
        NSLog(@"%@", data);
        NSArray *arr = [data objectForKey:@"List"];
        for (NSDictionary *dic in arr) {
            NSDictionary *dict = @{@"Id":[dic objectForKey:@"Id"], @"Title":[dic objectForKey:@"Title"]};
            [self.dataSource addObject:dict];
        }
        [self.XIUTableView reloadData];
    }];
}



#pragma mark----------tableViewDelegate--------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
      if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
          }
    cell.imageView.image = [UIImage imageNamed:@"my_news_icon_dot"];
    cell.textLabel.text = [self.dataSource[indexPath.row] objectForKey:@"Title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark lazy

-(UITableView *)XIUTableView {
    if (!_XIUTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.sectionFooterHeight = 10;
        
        [self.view addSubview:tableView];

        
        _XIUTableView = tableView;
    }
    return _XIUTableView;
}


-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];

    }
    return _dataSource;
}


@end
