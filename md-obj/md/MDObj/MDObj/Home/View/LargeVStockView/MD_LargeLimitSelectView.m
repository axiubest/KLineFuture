//
//  MD_LargeLimitSelectView.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_LargeLimitSelectView.h"
#import "MD_LargeLimitSelectCell.h"
@interface MD_LargeLimitSelectView ()<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@end

@implementation MD_LargeLimitSelectView

-(void)awakeFromNib {
    [super awakeFromNib];
    [_XIUTableView registerNib:[MD_LargeLimitSelectCell XIU_ClassNib] forCellReuseIdentifier:[MD_LargeLimitSelectCell XIU_ClassIdentifier]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_LargeLimitSelectCell *cell  =[tableView dequeueReusableCellWithIdentifier:[MD_LargeLimitSelectCell XIU_ClassIdentifier]];
    return cell;
}

@end
