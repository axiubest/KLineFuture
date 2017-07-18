//
//  MD_MeViewController.m
//  MDObj
//
//  Created by Apple on 17/6/15.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_MeViewController.h"
#import "UINavigationBar+Awesome.h"

#import "MD_MyInformationVC.h"//我的信息
#import "MD_PhoneResignVC.h"//绑定手机
#import "XIU_SettingMineInfoVC.h"

#import "XIU_MyCenterUserHeaderView.h"//cell header information view
#import "MD_ImgTitleTableViewCell.h"
#import "MD_KLinePKTableViewCell.h"

@interface MD_MeViewController ()<UITableViewDelegate, UITableViewDataSource, XIU_MyCenterUserHeaderViewDelegate>
{
    UIImageView *navBarHairlineImageView;

}
@property (nonatomic, weak)UITableView *XIUTableViw;

@end



@implementation MD_MeViewController
@synthesize cellStyle;


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   self.navigationController.navigationBarHidden = YES;


}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self XIUTableViw];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark----------tableViewDelegate--------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 160 : CGFLOAT_MIN;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 2 ? 89 : 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == CellInformationStyle_Custom) {
           MD_KLinePKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_KLinePKTableViewCell XIU_ClassIdentifier]];
        return cell;
    }
    MD_ImgTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_ImgTitleTableViewCell XIU_ClassIdentifier]];
    if (indexPath.section == CellInformationStyle_MyInformation) {
        cell.imgView.image = [UIImage imageNamed:@"my_icon_mynews"];
        cell.title.text = @"我的消息";
    }if (indexPath.section == CellInformationStyle_Phone) {
       cell.imgView.image = [UIImage imageNamed:@"my_icon_binding"];
        cell.title.text = @"手机绑定";

        if ([XIU_Login isMobile]) {//如果plist中，mobile不为空，表示有手机号， 为空没有
            cell.rightLab.text = @"已绑定";
        }else {
            cell.rightLab.text = @"未绑定";

        }
    }if (indexPath.section == CellInformationStyle_Setting) {
        cell.imgView.image = [UIImage imageNamed:@"my_icon_setting"];
        cell.title.text = @"设置";
    }
    return cell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        XIU_MyCenterUserHeaderView *userHeaderView = [[XIU_MyCenterUserHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 160)];
        userHeaderView.XIUDelegate = self;
        return userHeaderView;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case CellInformationStyle_MyInformation: {
            
        [self.navigationController pushViewController:[[MD_MyInformationVC alloc] init] animated:YES];
        }
            break;
        case CellInformationStyle_Phone: {
           
            if ([XIU_Login userMobile]) {
                ERROR_HUD(@"您已绑定手机号");
                return;
            }
            [self.navigationController pushViewController:[[MD_PhoneResignVC alloc] init] animated:YES];
        }
            
            break;
        case CellInformationStyle_Custom:
            
            break;
        case CellInformationStyle_Setting: {
                [self.navigationController pushViewController:[[XIU_SettingMineInfoVC alloc] init] animated:YES];
            
        }
            

        default:
            break;
    }
}

#pragma mark lazy

-(UITableView *)XIUTableViw {
    if (!_XIUTableViw) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, KWIDTH, KHEIGHT + 20) style:UITableViewStyleGrouped];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.sectionFooterHeight = 10;

        [self.view addSubview:tableView];
       
       [tableView registerNib:[MD_ImgTitleTableViewCell XIU_ClassNib] forCellReuseIdentifier:[MD_ImgTitleTableViewCell XIU_ClassIdentifier]];
        
        [tableView registerNib:[MD_KLinePKTableViewCell XIU_ClassNib] forCellReuseIdentifier:[MD_KLinePKTableViewCell XIU_ClassIdentifier]];
        
        
         _XIUTableViw = tableView;
    }
    return _XIUTableViw;
}

@end
