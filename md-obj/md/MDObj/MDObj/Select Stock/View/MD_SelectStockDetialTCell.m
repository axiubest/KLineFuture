//
//  MD_SelectStockDetialTCell.m
//  MDObj
//
//  Created by Apple on 17/6/21.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_SelectStockDetialTCell.h"
#import "MD_SingleStockChartVC.h"
#import "MD_LoginViewController.h"




@interface MD_SelectStockDetialTCell ()

@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, strong) NSString *codeName;
@property (nonatomic, strong) NSString *codeString;
@end

@implementation MD_SelectStockDetialTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _klineView.layer.borderWidth = 0.5f;
    _klineView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//+自选
- (IBAction)clickAddBtn:(id)sender {
    if ([XIU_Login isLogin]) {
        
        if (_isAdd == NO) {
            [_addBtn setImage:[UIImage imageNamed:@"imgshoose_btn_added"] forState:UIControlStateNormal];
            
            [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:API_AddStockOption withParams:@{@"APPID":APPID,@"timestamp":XIU_Timestamp,@"signed":XIU_Signed, @"userId":[XIU_Login userId], @"code":_codeString} withMethodType:Post andBlock:^(id data, NSError *error) {
                MBProgressHUD *errorHud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
                errorHud.mode = MBProgressHUDModeText;
                errorHud.labelText= @"添加自选成功";
                errorHud.removeFromSuperViewOnHide = YES;
                [errorHud hide:YES afterDelay:1.5];
            }];
            if ([self.superview isKindOfClass:[UITableView class]]) {
                UITableView *view = (UITableView *)self.superview;
                [view reloadData];
            }
        }
   
    }else {
        [_controller.navigationController pushViewController:[[MD_LoginViewController alloc] init] animated:YES];
    }
}

//查看行情
- (IBAction)clickQuotationBtn:(id)sender {
    MD_SingleStockChartVC *vc = [[MD_SingleStockChartVC alloc] init];
    vc.CodeName = _codeName;
    vc.CodeString = _codeString;
    [_controller.navigationController pushViewController:vc animated:YES];
}

- (void)setValueWithData:(MD_SelectStockDetialModel *)data Controller:(UIViewController *)vc{
    _controller = vc;
    _codeName = data.Name;
    _codeString =[NSString stringWithFormat:@"%@", data.Code] ;
    self.stockNameCode.text = [NSString stringWithFormat:@"  %@ (%@)",data.Name, data.Code];
    
    [self setLineValueWithData:data.Ks];
}
- (void)setLineValueWithData:(NSArray *)data {
    
    [self addBtnStatus];
  
    
    
    
    NSMutableArray * array = [NSMutableArray array];

    for (MD_SelectStockKLineDateModel * dic in data) {
        NSLog(@"%@", dic);
        YKLineEntity * entity = [[YKLineEntity alloc]init];
        entity.high = [dic.MaxPrice doubleValue];
        entity.open = [dic.OpenPrice doubleValue];
        
        entity.low = [dic.MinPrice doubleValue];
        
        entity.close = [dic.ClosePrice doubleValue];
        
        entity.date = @"";
//        entity.ma5 =  [dic[@"avg5"] doubleValue];
//        entity.ma10 = [dic[@"avg10"] doubleValue];
//        entity.ma20 = [dic[@"avg20"] doubleValue];
//        entity.volume = [dic[@"total_volume_trade"] doubleValue];
        [array addObject:entity];
    }
    
    YKLineDataSet * dataset = [[YKLineDataSet alloc]init];
    dataset.data = array;
    dataset.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    dataset.highlightLineWidth = 0.7;
    dataset.candleRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
    dataset.candleFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];
    dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];
    dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];
    dataset.candleTopBottmLineWidth = 1;
    
    [self.klineView setupChartOffsetWithLeft:10 top:40 right:10 bottom:-30];
    self.klineView.gridBackgroundColor = [UIColor whiteColor];
    self.klineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
    self.klineView.borderWidth = .5;
    self.klineView.candleWidth = 8;
    self.klineView.candleMaxWidth = 30;
    self.klineView.candleMinWidth = 1;
    self.klineView.uperChartHeightScale = 0.7;
    self.klineView.xAxisHeitht = 25;
    self.klineView.delegate = self;
    self.klineView.highlightLineShowEnabled = YES;
    self.klineView.zoomEnabled = YES;
    self.klineView.scrollEnabled = YES;
    [self.klineView setupData:dataset];

}

- (void)addBtnStatus {
    if (![XIU_Login isLogin]) {
        [_addBtn setImage:[UIImage imageNamed:@"imgshoose_btn_add"] forState:UIControlStateNormal];
    }else {
        NSMutableArray *arr = [XIU_NSUserDefaut getObjectWithObjName:myOptional_list];
        for (NSDictionary *dic in arr) {
            
            if ([[dic objectForKey:@"Code"]isEqualToString:_codeString]) {
                _isAdd = YES;
                
            }
        }
        
        if (_isAdd == YES) {
            [_addBtn setImage:[UIImage imageNamed:@"imgshoose_btn_added"] forState:UIControlStateNormal];
        }else {
            [_addBtn setImage:[UIImage imageNamed:@"imgshoose_btn_add"] forState:UIControlStateNormal];
        }
        
    }

}

-(void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex
{
    
}

- (void)chartValueNothingSelected:(YKViewBase *)chartView
{
}

- (void)chartKlineScrollLeft:(YKViewBase *)chartView
{
    
}


@end
