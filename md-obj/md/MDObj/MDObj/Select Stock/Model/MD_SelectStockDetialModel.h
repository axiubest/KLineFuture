//
//  MD_SelectStockDetialModel.h
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD_SelectStockDetialModel : NSObject

@property (nonatomic, strong)NSNumber *Code, *IsAdded;
@property (nonatomic, strong)NSArray *Ks;
@property (nonatomic, strong)NSString *Name, *SuggestHoldDay, *UpRate, *Up;
@end
