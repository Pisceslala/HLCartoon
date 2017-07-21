//
//  HLRainbowCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLRainbowCell.h"
#import "HLFantasyCell.h"
@interface HLRainbowCell ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HLRainbowCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    super.suggestionTitle = suggestionTitle;
    
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HLFantasyCell class]) bundle:nil] forCellReuseIdentifier:@"RainbowCell"];
    
    [self loadRainbowDetailData:suggestionTitle];
    
    
}

- (void)loadRainbowDetailData:(NSString *)title {
    
    NSString *limit = @"3";
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
    HLFantasyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RainbowCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HLDetailModel *model = self.dataArray[indexPath.row];
    
    NSDictionary *dict = @{@"ID": model.ID, @"imageURL": model.cover_image_url};
    //发送通知跳转
    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeCellDidClickNotification object:dict];

}

#pragma mark - GET
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 3 * 125) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.rowHeight = 125;
        _tableView = tableView;
    }
    return _tableView;
}

@end
