//
//  HLHorribleCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/15.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLHorribleCell.h"
#import "HLHorribleDetailCell.h"

@interface HLHorribleCell ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@property (strong, nonatomic) UITableView *tableView;;


@end

@implementation HLHorribleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.tableView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HLSuggestionModel *)model {
    super.model = model;
    
    self.title_Label.text = model.title;
    
    [self loadLoveDetailData:model.title];
}

- (void)loadLoveDetailData:(NSString *)title {
    
    NSString *limit = @"6";
    NSString *offset = @"0";
    NSString *tag = title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - dataSource AND delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLHorribleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.model = self.dataArray[indexPath.row];
    
    
    return cell;
}

#pragma mark - get
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SSScreenW, 6 * 120) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.scrollEnabled = NO;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerNib:[UINib nibWithNibName:@"HLHorribleDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        tableView.rowHeight = 120;
        _tableView = tableView;
    }
    return _tableView;
}

@end
