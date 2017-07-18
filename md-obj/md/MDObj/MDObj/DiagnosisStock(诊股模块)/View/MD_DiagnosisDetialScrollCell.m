//
//  MD_DiagnosisDetialScrollCell.m
//  MDObj
//
//  Created by Apple on 17/7/3.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisDetialScrollCell.h"
#import "MD_DiagnonsisDetialStockView.h"
@interface MD_DiagnosisDetialScrollCell ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *KLineBgView;
@property (weak, nonatomic) IBOutlet UILabel *likePresent;//相似程度

@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *analysisLab;//分析周期
@property (weak, nonatomic) IBOutlet UILabel *numCountLab;//数据量

@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *allCountLab;
@property (nonatomic, strong)MD_DiagnosisDetialModel *tmpModel;
@end
@implementation MD_DiagnosisDetialScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _KLineBgView.layer.borderWidth = .5f;
    _KLineBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mainScrollView.delegate = self;

}
- (void)setDataWithModel:(MD_DiagnosisDetialModel *)model {
//    初始状态取第一个值
    _tmpModel = model;
    
    if (model.detialSectionModel.sectionsArr.count > 0) {
        MD_DiagnosisDetialSelfModel *models = model.detialSectionModel.sectionsArr[0];
        _stockName.text = [NSString stringWithFormat:@"%@(%@)", [models StockName], [models Code]];
        
        NSInteger i = [models.Score integerValue];
            _likePresent.text = [NSString stringWithFormat:@"相似度：%ld%%", i];
        _analysisLab.text = [NSString stringWithFormat:@"分析周期:%@至%@",  [self insertString:models.DateStart],  [self insertString:models.DateEnd]];
        _startTimeLab.text = [self insertString:models.DateStart];
        _endTimeLab.text =  [self insertString:models.DateEnd];
        _numCountLab.text = @"1";
        
        
        NSInteger scrollNum =  model.detialSectionModel.sectionsArr.count;
        _allCountLab.text = [NSString stringWithFormat:@"/%ld", scrollNum];
        _mainScrollView.contentSize = CGSizeMake(scrollNum * _mainScrollView.width, 30);
        _mainScrollView.pagingEnabled = YES;
        
        
        for (int i = 0; i < scrollNum; i++) {
            MD_DiagnonsisDetialStockView *view = [[NSBundle mainBundle] loadNibNamed:[MD_DiagnonsisDetialStockView XIU_ClassIdentifier] owner:self options:nil].lastObject;
            view.frame = CGRectMake(i * _mainScrollView.width, 0, _mainScrollView.width, _mainScrollView.height);
            MD_DiagnosisDetialSelfModel *models = model.detialSectionModel.sectionsArr[i];
            [view setData:[models.Ks copy]];
            [_mainScrollView addSubview:view];
        }
    }
  }


- (NSString *)insertString:(NSString *)str {
    if (!str) {
        return @"----";
    }
    NSMutableString *startDateStr =[[NSMutableString alloc ] initWithString:str];
    [startDateStr insertString:@"-" atIndex:startDateStr.length - 2];
    [startDateStr insertString:@"-" atIndex:4];
    return [startDateStr copy];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger x = scrollView.contentOffset.x / _mainScrollView.width;
    _numCountLab.text = [NSString stringWithFormat:@"%ld", x+1];
    
    MD_DiagnosisDetialSelfModel *models = _tmpModel.detialSectionModel.sectionsArr[x];
    _stockName.text = [NSString stringWithFormat:@"%@(%@)", [models StockName], [models Code]];
    
    NSInteger i = [models.Score integerValue];
    _likePresent.text = [NSString stringWithFormat:@"相似度：%ld%%", i];
    _analysisLab.text = [NSString stringWithFormat:@"分析周期:%@至%@",  [self insertString:models.DateStart],  [self insertString:models.DateEnd]];
    _startTimeLab.text = [self insertString:models.DateStart];
    _endTimeLab.text =  [self insertString:models.DateEnd];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
