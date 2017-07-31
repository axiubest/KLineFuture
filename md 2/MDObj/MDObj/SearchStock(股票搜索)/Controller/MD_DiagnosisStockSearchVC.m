//
//  MD_SearchStockVC.m
//  MDObj
//
//  Created by Apple on 17/6/16.
//  Copyright © 2017年 A_XIU. All rights reserved.
//

#import "MD_DiagnosisStockSearchVC.h"
#import "MD_SearchPopUpCell.h"
#import "XIU_SearchBarSimulationView.h"

#import "NSDictionary+Common.h"
#import "MD_DiagnosisStockBaseVC.h"
@interface MD_DiagnosisStockSearchVC ()<UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak)UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *historyListData;

@end

@implementation MD_DiagnosisStockSearchVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.historyTableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self historyListData];
    [_XIUTableView registerNib:[MD_SearchPopUpCell XIU_ClassNib] forCellReuseIdentifier:[MD_SearchPopUpCell XIU_ClassIdentifier]];
    [_historyTableView registerNib:[MD_SearchPopUpCell XIU_ClassNib] forCellReuseIdentifier:[MD_SearchPopUpCell XIU_ClassIdentifier]];
    self.XIUTableView.hidden = YES;
    self.historyTableView.hidden = NO;
    self.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]init];
    barBtn.title=@"";
    self.navigationItem.leftBarButtonItem = barBtn;
    [self createNavgationSearchBar];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.historyTableView) {
        return 40;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView == self.historyTableView) {
        
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 30)];
        [b setTitle:@"清空诊股纪录" forState:UIControlStateNormal];
        [b setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [b setBackgroundColor:[UIColor whiteColor]];
        b.titleLabel.font = [UIFont systemFontOfSize:15];
        [b addTarget:self action:@selector(clickDleteHistory) forControlEvents:UIControlEventTouchUpInside];
        return b;
        
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.historyTableView) {
        return self.historyListData.count;
    }
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MD_SearchPopUpCell *cell = [tableView dequeueReusableCellWithIdentifier:[MD_SearchPopUpCell XIU_ClassIdentifier]];
    if (tableView == self.XIUTableView) {
        [cell setDataValueWithDic:self.dataSource[indexPath.row] Controller:self];
    }else {
        [cell setDataValueWithDic:self.historyListData[indexPath.row]Controller:self];
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.XIUTableView) {
        
        if (self.historyListData.count == 0) {
            NSDictionary *dic = self.dataSource[indexPath.row];
            [self.historyListData addObject:dic];
            
            
            [XIU_NSUserDefaut addObject:self.historyListData WithObjName:diagnosisHistory_search];
            
        }
        BOOL isEqual = NO;
        for (NSDictionary *dic in self.historyListData) {
            if ([[self.dataSource[indexPath.row] objectForKey:@"Code"] isEqualToString:[dic objectForKey:@"Code"]]) {
                isEqual = YES;
            }
        }
        if (isEqual == NO) {
            [self.historyListData addObject:self.dataSource[indexPath.row]];
                        //fromArr 更改数组属性变为不可变数组， 之后不可操作
                        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
                        for (NSDictionary *obj in self.historyListData) {
                            [mutaArray addObject: obj];
                        }
            
            [XIU_NSUserDefaut addObject:self.historyListData WithObjName:diagnosisHistory_search];
        }
        MD_DiagnosisStockBaseVC *vc = [[MD_DiagnosisStockBaseVC alloc] init];
        vc.CodeString = [self.dataSource[indexPath.row] objectForKey:@"Code"];
        [self.navigationController pushViewController:vc animated:YES];
    }if (tableView == self.historyTableView) {
        MD_DiagnosisStockBaseVC *vc = [[MD_DiagnosisStockBaseVC alloc] init];
        vc.CodeString = [self.historyListData[indexPath.row] objectForKey:@"Code"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickDleteHistory {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:diagnosisHistory_search];
    [self.historyListData removeAllObjects];
    [self.historyTableView reloadData];
}

- (void)createNavgationSearchBar {
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 30)];
    
    searchBarView.backgroundColor  =[UIColor clearColor];
    
    UISearchBar *search = [[UISearchBar alloc] init];
    search.delegate = self;
    [searchBarView addSubview:search];
    search.placeholder = @"请输入股票代码/简拼";
    self.navigationItem.titleView = searchBarView;
    search.translatesAutoresizingMaskIntoConstraints = NO;
    search.backgroundImage = [UIImage imageNamed:@"clearImage"];
    
    search.returnKeyType = UIReturnKeySearch;
    [search becomeFirstResponder];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(searchBarView).with.insets(UIEdgeInsetsMake(0, -30,0,0));
    }];
    _searchBar = search;
    
    [self createNavgationButtonWithImageNmae:nil title:@"取消" target:self action:@selector(cancelDidClick) type:UINavigationItem_Type_RightItem];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

//当搜索框中的内容发生改变时会自动进行搜索

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.historyTableView.hidden = YES;
    
    self.XIUTableView.hidden = searchText.length == 0 ? YES : NO;
    
    [[XIU_NetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"%@%@", XIU_SearchStock, searchText] withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        [self.dataSource removeAllObjects];
        for (NSDictionary *dic in [data objectForKey:@"Result"]) {
            [self.dataSource addObject:dic];
        }
        self.XIUTableView.hidden = self.dataSource.count >0 ? NO : YES;
        [self.XIUTableView reloadData];
        
    }];
}



- (void)cancelDidClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSMutableArray *)historyListData
{
    if (!_historyListData) {
        _historyListData = [NSMutableArray array];
        NSMutableArray *arr = (NSMutableArray*)[XIU_NSUserDefaut getObjectWithObjName:diagnosisHistory_search];
        NSLog(@"%@", kPathDocument);
        for (NSDictionary *obj in arr) {
            [_historyListData addObject:obj];
        }
    }
    return _historyListData;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
