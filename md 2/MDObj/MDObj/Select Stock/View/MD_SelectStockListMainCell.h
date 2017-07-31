//
//  MD_SelectStockListMainCell.h
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MD_SelectStockListMainCellDelegate <NSObject>

- (void)clickChooseStock;

@end

@interface MD_SelectStockListMainCell : UITableViewCell

@property (nonatomic, assign) id<MD_SelectStockListMainCellDelegate> delegate;

- (void)setHeaderDic:(NSMutableDictionary *)dic;

@end
