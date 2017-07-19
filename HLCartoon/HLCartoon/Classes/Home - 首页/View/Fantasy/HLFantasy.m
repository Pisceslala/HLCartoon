//
//  HLFantasy.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/19.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLFantasy.h"
#import "HLFantasyCell.h"
@interface HLFantasy ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HLFantasy

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    super.suggestionTitle = suggestionTitle;

    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HLFantasyCell" bundle:nil] forCellReuseIdentifier:@"fantasyCell"];
    
    [self loadFantasyDetailData:suggestionTitle];
    
}


- (void)loadFantasyDetailData:(NSString *)title {
    
    NSString *limit = @"2";
    NSString *offset = @"0";
    NSString *tag = title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - dataSource AND deleagte
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLFantasyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fantasyCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return  cell;
}

#pragma mark - GET
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 250) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 125;
        tableView.scrollEnabled = NO;
        _tableView = tableView;
    }
    return _tableView;
}
@end
