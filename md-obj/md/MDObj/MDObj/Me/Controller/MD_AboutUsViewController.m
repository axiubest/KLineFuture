//
//  MD_AboutUsViewController.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_AboutUsViewController.h"
#import "MD_SettingEditionCell.h"


@interface MD_AboutUsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@end

@implementation MD_AboutUsViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MD_SettingEditionCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SettingEditionCell XIU_ClassIdentifier]];
        return cell;

    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
        cell.textLabel.text = @"用户协议";
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_XIUTableView registerNib:[MD_SettingEditionCell XIU_ClassNib] forCellReuseIdentifier:[MD_SettingEditionCell XIU_ClassIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
