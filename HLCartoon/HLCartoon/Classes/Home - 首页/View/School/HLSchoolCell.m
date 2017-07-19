//
//  HLSchoolCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/19.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLSchoolCell.h"
#import "HLHorribleDetailCell.h"
@interface HLSchoolCell ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HLSchoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    super.suggestionTitle = suggestionTitle;
    
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HLHorribleDetailCell" bundle:nil] forCellReuseIdentifier:@"schoolCell"];
    
 
    [self loadSchoolDetailData:suggestionTitle];
    
    
}

- (void)loadSchoolDetailData:(NSString *)title {
    
    NSString *limit = @"4";
    NSString *offset = @"0";
    NSString *tag = title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLHorribleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"schoolCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


#pragma mark - GET
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 4 * 110) style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.scrollEnabled = NO;
        table.rowHeight = 110;
        _tableView = table;
    }
    return _tableView;
}

@end
