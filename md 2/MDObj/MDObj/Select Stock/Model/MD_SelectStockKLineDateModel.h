//
//  MD_SelectStockKLineDateModel.h
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD_SelectStockKLineDateModel : NSObject

@property (nonatomic, strong)NSString *ClosePrice, *Date,*MaxPrice, *MinPrice, *OpenPrice, *TradeNum;



//顶部6个图片模型
@property (nonatomic, strong)NSString *Imgs;
@property (nonatomic, strong)NSNumber *Id;
@end
