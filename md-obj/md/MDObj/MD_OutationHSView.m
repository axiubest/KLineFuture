//
//  MD_OutationHSView.m
//  MDObj
//
//  Created by Apple on 17/6/20.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_OutationHSView.h"
#import "MD_OptationHSGroupHeaderView.h"
#import "MD_OptationHSRowCell.h"
#import <objc/runtime.h>
#import "MD_QuotationHSMoreVC.h"//hs 更多
#import "MD_TheMarketViewController.h"
#import "MD_SingleStockChartVC.h"

#import "MD_QuotationHSExpandGroupModel.h"
#import "MD_QuotationHSListCellModel.h"
#import "MD_OptationHSHeaderView.h"
char* const buttonKey = "buttonKey";

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
@interface MD_OutationHSView ()<UITableViewDelegate, UITableViewDataSource,MD_OptationHSHeaderViewDelegate>
{
    NSArray *tmpArr;
}
@property (nonatomic, weak)UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) XIU_ViewController *baseVC;


@end

@implementation MD_OutationHSView

-(MD_OptationHSHeaderView *)headerView{
 
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:[MD_OptationHSHeaderView XIU_ClassIdentifier] owner:self options:nil].lastObject;
        _headerView.delegate = self;
        _headerView.frame = CGRectMake(0, 0, KWIDTH, 180 * SCREEN_SCALE);
    }
    return _headerView;

}


#pragma mark socket
- (void)setIndexSocket:(NSArray *)arr {
    if (arr) {
        tmpArr = arr;
        _headerView.code1.text = arr[0][@"nowPoints"];
        _headerView.code2.text = arr[1][@"nowPoints"];
        _headerView.code3.text = arr[2][@"nowPoints"];
        _headerView.code4.text = arr[3][@"nowPoints"];
        _headerView.code5.text = arr[4][@"nowPoints"];
        _headerView.code6.text = arr[5][@"nowPoints"];

        
        _headerView.detail1.text =[NSString stringWithFormat:@"%@  %@%%", arr[0][@"nowPrice"], arr[0][@"diff_rate"]];

        
        _headerView.detail2.text =[NSString stringWithFormat:@"%@  %@%%", arr[1][@"nowPrice"], arr[1][@"diff_rate"]];

        
        _headerView.detail3.text =[NSString stringWithFormat:@"%@  %@%%", arr[2][@"nowPrice"], arr[2][@"diff_rate"]];

        
        _headerView.detail4.text =[NSString stringWithFormat:@"%@  %@%%", arr[3][@"nowPrice"], arr[3][@"diff_rate"]];

        
        _headerView.detail5.text =[NSString stringWithFormat:@"%@  %@%%", arr[4][@"nowPrice"], arr[4][@"diff_rate"]];

        
        _headerView.detail6.text =[NSString stringWithFormat:@"%@  %@%%", arr[5][@"nowPrice"], arr[5][@"diff_rate"]];

        
        _headerView.detail1.textColor = [arr[0][@"diff_rate"] hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5E45"];
        
        _headerView.detail2.textColor = [arr[1][@"diff_rate"] hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5E45"];
        _headerView.detail3.textColor = [arr[2][@"diff_rate"] hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5E45"];
        _headerView.detail4.textColor = [arr[3][@"diff_rate"] hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5E45"];
        _headerView.detail5.textColor = [arr[4][@"diff_rate"] hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5E45"];
        _headerView.detail6.textColor = [arr[5][@"diff_rate"] hasPrefix:@"-"] ? [UIColor colorWithHexString:@"1CB54A"] : [UIColor colorWithHexString:@"FF5E45"];
        
        
        _headerView.code6.textColor = _headerView.detail6.textColor;
        _headerView.code5.textColor = _headerView.detail5.textColor;
        _headerView.code4.textColor = _headerView.detail4.textColor;
        _headerView.code3.textColor = _headerView.detail3.textColor;
        _headerView.code2.textColor = _headerView.detail2.textColor;
        _headerView.code1.textColor = _headerView.detail1.textColor;
        [self.XIUTableView reloadData];

    }
}

-(instancetype)initWithFrame:(CGRect)frame Controller:(XIU_ViewController *)vc{
    self = [super initWithFrame:frame];
    if (self) {
        _baseVC = vc;
  
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        table.delegate = self;
        table.dataSource = self;
        [self addSubview:table];
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self).with.insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        [table registerNib:[MD_OptationHSRowCell XIU_ClassNib] forCellReuseIdentifier:[MD_OptationHSRowCell XIU_ClassIdentifier]];
        _XIUTableView = table;


        [self GCD_Request];//并行请求5个网络请求

        
    }
    return self;
}

#pragma mark socket





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        
    return self.dataSource.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MD_QuotationHSExpandGroupModel *groupModel = self.dataSource[section];
    if (self.dataSource[section] == 0) {
        return 0;
    }else {
        NSInteger count = groupModel.isOpened?groupModel.groupFriends.count:0;
        return count;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//如果有幸代码优化， 可放进cell里面
    
    MD_OptationHSRowCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_OptationHSRowCell XIU_ClassIdentifier]];
    MD_QuotationHSListCellModel *model =  [self.dataSource[indexPath.section] groupFriends][indexPath.row];
    cell.stockName.text = model.name;
    cell.stockCode.text = model.Code;
    cell.centerLab.text = model.nowPrice;
    
    
    
    
    //成交额榜显示成交数量需要单独抽出
    if ([[self.dataSource[indexPath.section] groupName] isEqualToString:@"成交额榜"]) {
        cell.rightLab.textColor = [UIColor blackColor];
        cell.rightLab.text = [NSString stringWithFormat:@"%@", model.tradeAmount];
        if ([model.diff_money hasPrefix:@"-"]) {
            cell.centerLab.textColor =  [UIColor colorWithHexString:@"1CB54A"];
        }else {
            cell.centerLab.textColor =  [UIColor colorWithHexString:@"FF5E45"];
        }
        return cell;
    }
    
    
    
    cell.rightLab.text =[[self.dataSource[indexPath.section] groupName] isEqualToString:@"换手率榜"] ?[NSString stringWithFormat:@"%@%%",[NSString MD_StringToFloatWithString:model.turnover]]  : [NSString stringWithFormat:@"%@%%", model.diff_rate];
    if ([model.diff_money hasPrefix:@"-"]) {
        cell.centerLab.textColor =  [UIColor colorWithHexString:@"1CB54A"];
        cell.rightLab.textColor =   [UIColor colorWithHexString:@"1CB54A"];;
 
    }else {
        cell.centerLab.textColor =  [UIColor colorWithHexString:@"FF5E45"];
        cell.rightLab.textColor =   [UIColor colorWithHexString:@"FF5E45"];;
    }
    return cell;
    
    //换手率榜显示成交数量需要单独抽出
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        if (section == 0) {
            return 170*SCREEN_SCALE;
        }
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 10;
    }else {
        return 44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {

        return self.headerView;
    }
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 44)];
    sectionView.backgroundColor = [UIColor whiteColor];
    MD_QuotationHSExpandGroupModel *groupModel = self.dataSource[section];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:sectionView.bounds];
    [button setTag:section];
    button.titleLabel.textAlignment = 0;
    [button setTitleColor:[UIColor colorWithHexString:@"FF5E45"] forState:UIControlStateNormal];
    [button setTitle:groupModel.groupName forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:button];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-0.5, button.frame.size.width, 0.5)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [sectionView addSubview:line];
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH - 30, (44-14)/2, 16, 14)];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"price_btn_more"] forState:UIControlStateNormal];
    [moreBtn setTitle:groupModel.groupName forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:0];

    [moreBtn addTarget:self action:@selector(clcikMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:moreBtn];

    [line setImage:[UIImage imageNamed:@"line_real"]];
    [sectionView addSubview:line];
    if (groupModel.isOpened) {
        UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44-16)/2, 14, 16)];
        [_imgView setImage:[UIImage imageNamed:@"price_btn_right"]];
        [sectionView addSubview:_imgView];
        CGAffineTransform currentTransform = _imgView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
        _imgView.transform = newTransform;
        objc_setAssociatedObject(button, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }else{
        UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44-16)/2, 14, 16)];
        [_imgView setImage:[UIImage imageNamed:@"price_btn_right"]];
        [sectionView addSubview:_imgView];
        objc_setAssociatedObject(button, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
  
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MD_QuotationHSExpandGroupModel *groupModel = self.dataSource[indexPath.section];
    MD_QuotationHSListCellModel *Dic = groupModel.groupFriends[indexPath.row];
    MD_SingleStockChartVC *vc = [[MD_SingleStockChartVC alloc] init];
    vc.CodeName = Dic.name;
    vc.CodeString = Dic.Code;
    [_baseVC.navigationController pushViewController:vc animated:YES];
    
}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    MD_QuotationHSExpandGroupModel *groupModel = self.dataSource[sender.tag];
    UIImageView *imageView =  objc_getAssociatedObject(sender,buttonKey);
    
    
    if (groupModel.isOpened) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGAffineTransform currentTransform = imageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2); // 在现在的基础上旋转指定角度
            imageView.transform = newTransform;
            
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        
    }else{
        
        [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{
            
            CGAffineTransform currentTransform = imageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
            imageView.transform = newTransform;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    groupModel.isOpened = !groupModel.isOpened;
    
    [self.XIUTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}



#pragma mark MD_OptationHSHeaderViewDelegate
- (void)clickHSHeaderViewWithTag:(NSInteger)tag {
    
    //上证指数  000001//深证成指  399001//创业板指  399006//沪深300   000300//上证50   	000016//中证500   000905
    MD_TheMarketViewController *vc = [[MD_TheMarketViewController alloc] init];
    switch (tag) {
        case 0:
           vc.CodeString = @"000001";
            vc.CodeName = @"上证指数";
            vc.type = 1;
            break;
        case 1:
            vc.CodeString = @"399001";
            vc.CodeName = @"深圳成指";
            break;
        case 2:
            vc.CodeString = @"399006";
            vc.CodeName = @"创业板指";
            break;
        case 3:
            vc.CodeString = @"000300";
            vc.CodeName = @"沪深300";
            break;
        case 4:
            vc.CodeString = @"000016";
            vc.CodeName = @"上证50";
            break;
        case 5:
            vc.CodeString = @"000905";
            vc.CodeName = @"中证500";
            break;
   
        default:
            break;
    }
    [_baseVC.navigationController pushViewController:vc animated:YES];
}

- (void)clcikMoreButton:(UIButton *)sender {
    MD_QuotationHSMoreVC *vc = [[MD_QuotationHSMoreVC alloc] init];
//    根据名字判断跳转
    if ([sender.titleLabel.text isEqualToString:@"换手率榜"]) {
        vc.type = 3;
    }
    if ([sender.titleLabel.text isEqualToString:@"涨幅榜"]) {
        vc.type = 0;
    }
    if ([sender.titleLabel.text isEqualToString:@"跌幅榜"]) {
        vc.type = 1;
    }
    if ([sender.titleLabel.text isEqualToString:@"成交额榜"]) {
        vc.type = 5;
    }
    [_baseVC.navigationController pushViewController:vc animated:YES];
}


-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        MD_QuotationHSExpandGroupModel *tmpmodel = [[MD_QuotationHSExpandGroupModel alloc]init];
        tmpmodel.isOpened = YES;
        [self.dataSource addObject:tmpmodel];//为让6个方块显示独立设置一个cell
    }
    return _dataSource;
}


- (void)GCD_Request {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        
        [self requestWithStyle:0 Field:@"diff_rate" Order:@"DESC"];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        
        [self requestWithStyle:1 Field:@"diff_rate" Order:@"ASC"];
        
        dispatch_semaphore_signal(semaphore);
    });
//    dispatch_group_async(group, queue, ^{
//        
//        [self requestWithStyle:2];
//        
//        dispatch_semaphore_signal(semaphore);
//    });
    dispatch_group_async(group, queue, ^{
        
        [self requestWithStyle:3 Field:@"turnover" Order:@"DESC"] ;
        
        dispatch_semaphore_signal(semaphore);
    });
//    dispatch_group_async(group, queue, ^{
//        
//        [self requestWithStyle:4];
//        
//        dispatch_semaphore_signal(semaphore);
//    });
    dispatch_group_async(group, queue, ^{
        
        [self requestWithStyle:5 Field:@"tradeAmount" Order:@"DESC"];
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        [self exchangeDataSource];
    });
}

- (void)requestWithStyle:(NSInteger)style Field:(NSString *)fie Order:(NSString *)order{
    
    [[XIU_NetAPIClient sharedJsonClient]requestJsonDataWithPath:API_GetRanking withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed,@"type":[NSNumber numberWithInteger:style],@"startIndex":@"1", @"endIndex":@"10",@"field":fie,@"order":order} withMethodType:Post andBlock:^(id data, NSError *error) {
        NSMutableArray *ar = [NSMutableArray array];
        NSArray *arr = [data objectForKey:@"List"];
        
        for (NSDictionary *dic in arr) {
            MD_QuotationHSListCellModel *model = [[MD_QuotationHSListCellModel alloc] init];
            model.turnover = [dic objectForKey:@"turnover"];
            model.name = [dic objectForKey:@"name"];
            model.Code = [dic objectForKey:@"Code"];
            model.nowPrice = [dic objectForKey:@"nowPrice"];
            model.diff_rate = [dic objectForKey:@"diff_rate"];
            model.tradeAmount =[NSString numberChangeWord:[dic objectForKey:@"tradeAmount"]];
            model.diff_money = [dic objectForKey:@"diff_money"];
            [ar addObject:model];
            
        }
        [self initDataSourceWithType:style Arr:ar];
        
    }];
}

- (void)initDataSourceWithType:(NSInteger)num Arr:(NSMutableArray *)dataArr {
    NSNumber *tmpNum = [NSNumber numberWithInteger:num];

    
        MD_QuotationHSExpandGroupModel *model = [[MD_QuotationHSExpandGroupModel alloc]init];
    model.isOpened = YES;
    if ([tmpNum isEqual:@0]) {
        model.groupName = @"涨幅榜";
    }
    if ([tmpNum isEqual:@1]) {
        model.groupName = @"跌幅榜";
    }
    if ([tmpNum isEqual:@2]) {
        model.groupName = @"五分钟快速涨幅榜";
    }
    if ([tmpNum isEqual:@3]) {
        model.groupName = @"换手率榜";
    }
    if ([tmpNum isEqual:@4]) {
        model.groupName = @"量比榜";
    }
    if ([tmpNum isEqual:@5]) {
        model.groupName = @"成交额榜";
    }
        model.types = num;
        model.isOpened = NO;
        model.groupFriends = dataArr;
        [self.dataSource addObject:model];
    
    [self exchangeDataSource];
}

- (void)exchangeDataSource {

    [self.XIUTableView reloadData];
}


@end
