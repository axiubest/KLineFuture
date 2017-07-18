//
//  MD_QuotationPlateDetialVC.m
//  MDObj
//
//  Created by Apple on 17/6/29.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_QuotationPlateDetialVC.h"
#import "UILabel+AutoLabelHeight.h"
#import "MJRefresh.h"
#import "MD_QuotationHSListCellModel.h"
#import "XIU_StockScrollTitleCell.h"
#define kOriginX 120
static NSInteger xstartIndex;
static NSInteger xendIndex;

@interface MD_QuotationPlateDetialVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat _kScreenWidth;
    CGFloat _kScreenHeight;
}

@property (nonatomic, strong) UITableView *titleTableView;//标题TableView
@property (nonatomic, strong) UITableView *infoTableView;//内容TableView
@property (nonatomic, strong) UIScrollView *contentView;//内容容器
@property (nonatomic, strong) NSArray *infoArr;//数组
@property (nonatomic, strong) NSArray *titleData;//数组

@property (nonatomic, strong)MBProgressHUD *hud;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIView *segmentView;

//行业概念， 原谅我不愿意查单词
@property (weak, nonatomic) IBOutlet UIButton *segmentUp;
@property (weak, nonatomic) IBOutlet UIButton *segmentDown;
@property (weak, nonatomic) IBOutlet UIView *UpLine;
@property (weak, nonatomic) IBOutlet UIView *DownLine;
@end

@implementation MD_QuotationPlateDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    xstartIndex = 1;
    xendIndex = 20; // 服务器不会做分页.....
    _kScreenWidth = self.view.frame.size.width;
    _kScreenHeight = self.view.frame.size.height;
    [self configTableHeader];
    [self configInfoView];
    [self.dataSource removeAllObjects];
      [self addRefresh];

}

- (void)addRefresh {
    self.infoTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        xstartIndex+=10;
        xendIndex +=10;
        [self requestWithType:_type];
        [self reloadAllData];
    }];
    
}
- (void)reloadAllData {
    [self.titleTableView reloadData];
    [self.infoTableView reloadData];
}


- (void)requestWithType:(NSInteger)type{
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_GetRanking withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"type":[NSNumber numberWithInteger:type],@"startIndex":[NSNumber numberWithInteger:xstartIndex], @"endIndex":[NSNumber numberWithInteger:xendIndex],@"field":@"diff_money",@"order":@"ASC"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
        NSArray *arr = [data objectForKey:@"List"];
        
        for (NSDictionary *dic in arr) {
            MD_QuotationHSListCellModel *model = [[MD_QuotationHSListCellModel alloc] init];
            model.turnover = [dic objectForKey:@"turnover"];
            model.name =[NSString XIU_IsEmpty:[dic objectForKey:@"name"]];
            model.Code = [NSString XIU_IsEmpty:[dic objectForKey:@"Code"]];;
            model.nowPrice = [dic objectForKey:@"nowPrice"];
            model.diff_money = [dic objectForKey:@"diff_money"];
            model.tradeAmount = [dic objectForKey:@"tradeAmount"];
            model.all_value = [dic objectForKey:@"all_value"];
            model.pe = [dic objectForKey:@"pe"];
            model.nowPrice = [dic objectForKey:@"nowPrice"];
            model.circulation_value = [dic objectForKey:@"circulation_value"];
            model.swing = [dic objectForKey:@"swing"];
            model.totalcapital = [dic objectForKey:@"totalcapital"];
            model.diff_rate = [dic objectForKey:@"diff_rate"];
            model.pb = [dic objectForKey:@"pb"];
            model.tradeNum = [dic objectForKey:@"tradeNum"];
            model.turnover = [dic objectForKey:@"turnover"];
            
            [self.dataSource addObject:model];
            
        }
        [self reloadAllData];
        
    }];
}

//MARK:- 头部视图
//MARK:- 头部视图
- (void)configTableHeader {
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(kOriginX, 0, _kScreenWidth - kOriginX, _kScreenHeight)];
    _contentView.delegate = self;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.contentSize = CGSizeMake(80 * 12, _kScreenHeight - 64);
    _contentView.bounces = NO;
    [self.view addSubview:_contentView];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, _contentView.contentSize.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_contentView addSubview:line];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 40 - 0.5, kOriginX, 0.5)];
    line1.backgroundColor =line.backgroundColor;
    [self.view addSubview:line1];
    
    for (int i = 0; i < self.titleData.count; i++) {
        CGFloat x = i * 80;
        
        
            UILabel *label = [UILabel quickCreateLabelWithLeft:x width:80 title:self.titleData[i]];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            [_contentView addSubview:label];
            
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x + 80, 10, 0.5,20)];
        v.backgroundColor  =[UIColor lightGrayColor];
        [_contentView addSubview:v];
    }
}


#pragma mark  detial info

- (void)configInfoView {
    _titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kOriginX, KHEIGHT) style:UITableViewStylePlain];
    _titleTableView.dataSource = self;
    _titleTableView.delegate = self;
    _titleTableView.showsVerticalScrollIndicator = NO;
    _titleTableView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_titleTableView];
    
    _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 80 * 15, KHEIGHT) style:UITableViewStylePlain];
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.showsVerticalScrollIndicator = NO;
    _infoTableView.showsHorizontalScrollIndicator = NO;
    
    [_contentView addSubview:_infoTableView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)clickSegment:(UIButton *)sender {

    [self changeSegmentWithTag:sender.tag];
    [self.dataSource removeAllObjects];
    
    
}
//MARK:- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _titleTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleTable"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"titleTable"];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] name];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = [[self.dataSource objectAtIndex:indexPath.row] Code];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        return cell;
    } else {
        
        XIU_StockScrollTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[XIU_StockScrollTitleCell XIU_ClassIdentifier]];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:[XIU_StockScrollTitleCell XIU_ClassIdentifier] owner:nil options:nil] lastObject];
        }
        
        [cell setDataWithStr:[self.dataSource objectAtIndex:indexPath.row]];
        return cell;
    }
}

//MARK:- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}



//MARK:- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _titleTableView) {
        [_infoTableView setContentOffset:CGPointMake(_infoTableView.contentOffset.x, _titleTableView.contentOffset.y)];
    }
    if (scrollView == _infoTableView) {
        [_titleTableView setContentOffset:CGPointMake(0, _infoTableView.contentOffset.y)];
    }
}



- (void)changeSegmentWithTag:(NSInteger)tag {
    
    for (id obj in self.segmentView.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            if (theButton.tag == tag) {//the btn is select
                [theButton setTitleColor:[UIColor colorWithHexString:@"378AD6"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
                
            }else {
                [theButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                theButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
                
            }
        }
    }
    if (tag == 0) {
        //hy
        _DownLine.hidden = YES;
        _UpLine.hidden = NO;
    }else {//1
        //gn
        _DownLine.hidden = NO;
        _UpLine.hidden = YES;
    }
    
}

-(NSMutableArray <MD_QuotationHSListCellModel *>*)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];
        
    }
    return _hud;
}
-(NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"最新", @"涨幅", @"涨跌", @"星级", @"换手", @"量比", @"振幅", @"涨速", @"市盈（动）", @"市净率", @"流通市值", @"总市值", @"金额", @"总手", @"现手"];
    }
    return _titleData;
}
@end
