//
//  HLPresidentCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLPresidentCell.h"
#import "HLBaseCollectionCell.h"

@interface HLPresidentCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation HLPresidentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    super.suggestionTitle = suggestionTitle;
    
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HLBaseCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"presidentCell"];
    
    [self loadPresidentDetailData:suggestionTitle];
    
    
}

- (void)loadPresidentDetailData:(NSString *)title {
    
    NSString *limit = @"4";
    NSString *offset = @"0";
    NSString *tag = title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"presidentCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - GET
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize  = CGSizeMake(SSScreenW / 2 - 4, 250/2);
        flow.minimumLineSpacing = 2;
        flow.minimumInteritemSpacing = 0;
        
        UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 250) collectionViewLayout:flow];
        collectView.scrollEnabled = NO;
        collectView.contentInset = UIEdgeInsetsMake(0, 3, 0, 3);
        collectView.backgroundColor = [UIColor whiteColor];
        collectView.delegate = self;
        collectView.dataSource = self;
        _collectionView = collectView;
    }
    return _collectionView;
}

@end
