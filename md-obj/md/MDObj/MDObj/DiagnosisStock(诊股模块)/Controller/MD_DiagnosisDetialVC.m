//
//  MD_DiagnosisDetialVC.m
//  MDObj
//
//  Created by Apple on 17/6/26.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisDetialVC.h"
#import "MD_DiagnosisDetialAnimalStockCell.h"
#import "MD_DiagnosisDetialScrollCell.h"
#import "HWPopTool.h"
#import "XIU_DiagnosisPopView.h"
#import "MD_DiagnosisDetialModel.h"
@interface MD_DiagnosisDetialVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@property (weak, nonatomic) IBOutlet UIButton *goOnDiagnosisStockBtn;
@property (weak, nonatomic) IBOutlet UIButton *addMychooseBtn;
@property (nonatomic, weak)XIU_DiagnosisPopView *alertView;
@property (weak, nonatomic) UIView *firstAnimationView;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic, strong) MD_DiagnosisDetialModel *model;//this is dataSource

@end

@implementation MD_DiagnosisDetialVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _XIUTableView.sectionFooterHeight = CGFLOAT_MIN;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KHEIGHT)];
    v.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake( 100, 100, KWIDTH - 200, 200)];
    [v addSubview:img];
    _firstAnimationView = v;
    
    
    //创建一个可变数组
    NSMutableArray *ary=[NSMutableArray new];
    for(int i=1;i<36;i++){
        
        NSString *imageName=[NSString stringWithFormat:@"%d",i];
        UIImage *image=[UIImage imageNamed:imageName];
        [ary addObject:image];
    }
    
    // 设置图片的序列帧 图片数组
    img.animationImages=ary;
    img.animationRepeatCount=0;//循环播放
    img.animationDuration=3.0;
    [img startAnimating];
    [self.view addSubview:v];
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100,300)];
    _contentView.backgroundColor = [UIColor clearColor];
    
    
    [_XIUTableView registerNib:[MD_DiagnosisDetialAnimalStockCell XIU_ClassNib] forCellReuseIdentifier:[MD_DiagnosisDetialAnimalStockCell XIU_ClassIdentifier]];
    [_XIUTableView registerNib:[MD_DiagnosisDetialScrollCell XIU_ClassNib] forCellReuseIdentifier:[MD_DiagnosisDetialScrollCell XIU_ClassIdentifier]];
    [self request];
}

- (void)request {
    
    
    [[MD_NetRequestManager sharedManager] request_ZGBlock:^(id data, NSError *error) {
        self.model = data;
        _firstAnimationView.hidden = YES;
        [self.XIUTableView reloadData];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0* NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self showAlertView];
        });
    }];
    
    
}

- (void)showAlertView {
    
    [_contentView addSubview:self.alertView];
    [self.alertView setDataWithModel:self.model];
    [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
    [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
    [[HWPopTool sharedInstance] showWithPresentView:_contentView animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? KHEIGHT/3 : KHEIGHT/3 + 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MD_DiagnosisDetialAnimalStockCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_DiagnosisDetialAnimalStockCell XIU_ClassIdentifier]];
        [cell setDataWithModel:self.model];
        
        return cell;
        
    }
    MD_DiagnosisDetialScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_DiagnosisDetialScrollCell XIU_ClassIdentifier]];
    [cell setDataWithModel:self.model];
    
    return cell;
}

- (void)popView {
    [self showAlertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(XIU_DiagnosisPopView *)alertView {
    if (!_alertView) {
        XIU_DiagnosisPopView *view = [[NSBundle mainBundle]loadNibNamed:[XIU_DiagnosisPopView XIU_ClassIdentifier] owner:self options:nil].lastObject;
        view.frame = CGRectMake(-90, 0, self.view.width- 100, 300 *SCREEN_SCALE);
        
        _alertView = view;
        
    }
    return _alertView;
}


-(MD_DiagnosisDetialModel *)model {
    if (!_model) {
        _model = [[MD_DiagnosisDetialModel alloc] init];
    }
    return _model;
}

@end
