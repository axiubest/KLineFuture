//
//  MD_OptationPlateCell.h
//  MDObj
//
//  Created by Apple on 17/6/22.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MD_OptationPlateCellDelegate <NSObject>

- (void)clickViewWithTag:(NSInteger)tag;

@end

@interface MD_OptationPlateCell : UITableViewCell

- (void)setData:(NSMutableArray *)data;
@property (nonatomic, assign)id<MD_OptationPlateCellDelegate>delegate;


@end
