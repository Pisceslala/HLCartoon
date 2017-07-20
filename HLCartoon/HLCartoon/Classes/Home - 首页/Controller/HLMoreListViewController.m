//
//  HLMoreListViewController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLMoreListViewController.h"
#import "HLDetailModel.h"
#import "HLMoreListCell.h"
#import "HLDetailsViewController.h"
@interface HLMoreListViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (assign, nonatomic) NSInteger page;

@end

@implementation HLMoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews];
}

- (void)configViews {
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HLMoreListCell class]) bundle:nil] forCellReuseIdentifier:@"MoreListCell"];
    MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewMoreListData)];
    self.tableView.mj_footer = footerView;
    self.tableView.rowHeight = 100;
    
    self.page = 0;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLMoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreListCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HLDetailModel *model = self.dataArray[indexPath.row];
    HLDetailsViewController *vc = [[HLDetailsViewController alloc] init];
    vc.ID = model.ID;
    vc.imageURL = model.cover_image_url;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - get
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - set
- (void)setSuggestion:(NSString *)suggestion {
    _suggestion = suggestion;
    
    [self loadMoreListDataWithSuggestion:suggestion];
}

#pragma mark - 请求列表数据
- (void)loadMoreListDataWithSuggestion:(NSString *)suggestion {
    NSString *limit = @"20";
    NSString *offset = @"0";
    NSString *tag = suggestion;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadNewMoreListData {
    NSString *limit = @"20";
    NSString *offset = [NSString stringWithFormat:@"%zd",self.page += 20];
    NSString *tag = self.title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [self.tableView.mj_footer beginRefreshing];
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *newData = [NSMutableArray array];
        
        newData = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        for (HLDetailModel *model in newData) {
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
