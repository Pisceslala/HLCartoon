//
//  HLRightView.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLRightView.h"
#import "HLComicsModel.h"
#import "HLRightViewCell.h"
@interface HLRightView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HLRightView

#pragma mark - 构建
- (instancetype)init {
    if (self = [super init]) {
        [self configViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configViews];
    }
    return self;
}

#pragma mark - 初始化
- (void)configViews {
    [self addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HLRightViewCell class]) bundle:nil] forCellReuseIdentifier:@"rightCell"];
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLRightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HLComicsModel *model = self.dataArray[indexPath.row];
    
    __weak typeof(self)weakSelf = self;
    
    if ([weakSelf.delegate respondsToSelector:@selector(didSelectRowAtID:)]) {
        [weakSelf.delegate didSelectRowAtID:model.ID];
    }
}


#pragma mark - GET AND SET
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, self.JYD_Height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 75;
        
    }
    return _tableView;
}



- (void)setModel:(HLBookDetailsModel *)model {
    _model = model;
    
    self.dataArray = [HLComicsModel mj_objectArrayWithKeyValuesArray:model.comics];
    
    [self.tableView reloadData];
}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
@end
