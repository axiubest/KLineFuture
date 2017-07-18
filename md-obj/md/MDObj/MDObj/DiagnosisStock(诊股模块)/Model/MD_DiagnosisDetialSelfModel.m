//
//  MD_DiagnosisDetialSelfModel.m
//  MDObj
//
//  Created by Apple on 17/7/5.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisDetialSelfModel.h"

@implementation MD_DiagnosisDetialSelfModel


-(NSMutableArray *)Ks {
    if (!_Ks) {
        _Ks = [NSMutableArray array];
    }
    return _Ks;
}



-(NSMutableArray *)sectionsArr {
    if (!_sectionsArr) {
        _sectionsArr = [NSMutableArray array];
    }
    return _sectionsArr;
}
@end
