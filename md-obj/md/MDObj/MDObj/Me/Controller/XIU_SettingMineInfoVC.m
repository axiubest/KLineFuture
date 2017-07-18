//
//  XIU_SettingMineInfoVC.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_SettingMineInfoVC.h"

#import "MD_SettingSiginOutCell.h"
#import "MD_OpinionViewController.h"
#import "MD_AboutUsViewController.h"
#import "RDVTabBar.h"
#import "RDVTabBarController.h"
static CGFloat const Row_Height = 50.f;
static CGFloat const Section_HeaderHeight = 20.f;
//设置界面
@interface XIU_SettingMineInfoVC ()
@property (strong, nonatomic) XIU_User *curUser;
@property (nonatomic, strong) UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end


@implementation XIU_SettingMineInfoVC

-(NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"意见反馈", @"好评鼓励", @"关于我们", nil];
        //        [self isLogin] ? [_titleArray addObject:@"退出"]: _titleArray;
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"设置";
    self.curUser =[XIU_Login curLoginUser];
    
    
    //    添加myTableView
    _XIUTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        tableView.sectionFooterHeight = CGFLOAT_MIN;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [tableView registerNib:[MD_SettingSiginOutCell XIU_ClassNib] forCellReuseIdentifier:[MD_SettingSiginOutCell XIU_ClassIdentifier]];
        tableView.estimatedRowHeight = Row_Height;
        tableView.sectionHeaderHeight = Section_HeaderHeight;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        MD_SettingSiginOutCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SettingSiginOutCell XIU_ClassIdentifier]];
        return cell;
        
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.titleArray.count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                [self.navigationController pushViewController:[[MD_OpinionViewController alloc] init] animated:YES];
                
            }
                break;
            case 1:
                
                break;
            case 2:
                [self.navigationController pushViewController:[[MD_AboutUsViewController alloc] init] animated:YES];
                break;

            default:
                break;
        }
        
    }
    if (indexPath.section == 1 ) {
        [XIU_Login doLogOut];
        //退出登录条跳转到首页
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingLoginOut object:nil];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    _XIUTableView.delegate = nil;
    _XIUTableView.dataSource = nil;
}


@end
