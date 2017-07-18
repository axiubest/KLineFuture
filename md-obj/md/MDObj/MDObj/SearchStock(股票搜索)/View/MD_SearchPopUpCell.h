//
//  MD_SearchPopUpCell.h
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MD_SearchPopUpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockCodeLab;

@property (weak, nonatomic) IBOutlet UILabel *stockTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (void)setDataValueWithDic:(NSDictionary *)dic Controller:(UIViewController  *)vc;

@end
