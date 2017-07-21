//
//  HLCityCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/19.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCityCell.h"
#import "HLBaseCollectionCell.h"
@interface HLCityCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectView;

@end

@implementation HLCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    super.suggestionTitle = suggestionTitle;
    
    [self.contentView addSubview:self.collectView];
    
    [self.collectView registerNib:[UINib nibWithNibName:@"HLBaseCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cityCell"];
    
    [self loadCityDetailData:suggestionTitle];
    
    
}

- (void)loadCityDetailData:(NSString *)title {
    
    NSString *limit = @"6";
    NSString *offset = @"0";
    NSString *tag = title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.collectView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cityCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HLDetailModel *model = self.dataArray[indexPath.row];
    
    NSDictionary *dict = @{@"ID": model.ID, @"imageURL": model.cover_image_url};
    //发送通知跳转
    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeCellDidClickNotification object:dict];

}

#pragma mark - GET
- (UICollectionView *)collectView {
    if (_collectView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(SSScreenW / 2 - 7, 110);
        flow.minimumLineSpacing = 4;
        flow.minimumInteritemSpacing = 4;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 3 * 110 + 8)collectionViewLayout:flow];
        collectionView.contentInset = UIEdgeInsetsMake(0, 3, 0, 3);
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.scrollEnabled = NO;
        _collectView = collectionView;
        
    }
    return _collectView;
}

@end
