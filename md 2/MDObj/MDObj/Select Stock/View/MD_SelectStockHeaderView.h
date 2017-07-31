//
//  MD_SelectStockHeaderView.h
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MD_SelectStockDetialModel.h"
#import "MD_SelectStockKLineDateModel.h"
@interface MD_SelectStockHeaderView : UIView



- (void)setDataSourceWithData:(NSMutableArray *)data Controller:(UITableView *)tableView;

@end
