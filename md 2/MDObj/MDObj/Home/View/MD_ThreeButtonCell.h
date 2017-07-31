//
//  MD_ThreeButtonCell.h
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickThreeToolBarDelegate <NSObject>

- (void)clickHotMsgBtn;
- (void)clickDiagnosisStockBtn;
- (void)clickKlinePKBtn;
- (void)clickBigDataBtn;

@end

@interface MD_ThreeButtonCell : UITableViewCell

@property (nonatomic, assign) id<clickThreeToolBarDelegate> delegate;

@end
