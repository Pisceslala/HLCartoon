//
//  HLAncientCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/19.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLAncientCell.h"
#import "HLBaseCollectionCell.h"
@interface HLAncientCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation HLAncientCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    super.suggestionTitle = suggestionTitle;
    
    [self loadAncientDetailData:suggestionTitle];
    
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HLBaseCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"AncientCell"];

}

#pragma mark - 加载数据
- (void)loadAncientDetailData:(NSString *)title {
    
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

#pragma mark - deleagte AND dataSoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AncientCell" forIndexPath:indexPath];
    HLDetailModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


#pragma mark - get 
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
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
