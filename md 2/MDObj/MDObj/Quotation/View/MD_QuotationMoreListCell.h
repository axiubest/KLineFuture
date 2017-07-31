//
//  MD_QuotationMoreListCell.h
//  MDObj
//
//  Created by Apple on 17/6/28.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_QuotationPlateModel.h"

@interface MD_QuotationMoreListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *codeLab;


//from left to right
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (nonatomic, strong)MD_QuotationPlateModel *model;
@end
