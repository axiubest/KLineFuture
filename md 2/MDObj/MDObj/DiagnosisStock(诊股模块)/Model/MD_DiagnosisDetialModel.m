//
//  MD_DiagnosisDetialModel.m
//  MDObj
//
//  Created by Apple on 17/7/5.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisDetialModel.h"
@implementation MD_DiagnosisDetialModel


-(MD_DiagnosisDetialSelfModel *)detialSelfModel {
    if (!_detialSelfModel) {
        _detialSelfModel  = [[MD_DiagnosisDetialSelfModel alloc] init];
    }
    return _detialSelfModel;
}

-(MD_DiagnosisDetialSelfModel *)detialSectionModel {
    if (!_detialSectionModel) {
        _detialSectionModel  = [[MD_DiagnosisDetialSelfModel alloc] init];
    }
    return _detialSectionModel;
}
@end
