//
//  MD_SelectStockListHeaderCell.h
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MD_SelectStockListHeaderCellDelegate <NSObject>

-(void)clickSixBtn:(UIButton *)btn;

@end
@interface MD_SelectStockListHeaderCell : UITableViewCell

@property (nonatomic, assign)id<MD_SelectStockListHeaderCellDelegate> delegate;
- (void)setHeaderData:(NSMutableArray *)data;
@end
