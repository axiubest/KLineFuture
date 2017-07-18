//
//  XIU_NavView.m
//  MDObj
//
//  Created by Apple on 17/7/4.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "XIU_NavView.h"

@implementation XIU_NavView

-(instancetype)initWithFrame:(CGRect)frame Code:(NSString *)code StockName:(NSString *)stockName {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.width, 20)];
        lab.textAlignment = 1;
        lab.textColor = [UIColor whiteColor];
        lab.text = stockName;
        [self addSubview:lab];
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, lab.y + lab.height, self.width, 20)];
        lab1.textAlignment = 1;
        
        lab1.textColor = [UIColor whiteColor];
        lab1.font = [UIFont systemFontOfSize:12];
        lab1.text = code;
        [self addSubview:lab1];
 
    }
    return self;
}

@end
