//
//  HLBottomView.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBottomView.h"
#import "HLLeftView.h"
#import "HLSwitchCell.h"
#import "HLRightView.h"
@interface HLBottomView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (strong, nonatomic) HLLeftView *leftView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HLBottomView

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

- (void)configViews {
    [self addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HLSwitchCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLSwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.dataArray.count > 0) {
        if (indexPath.row == 0) {
            cell.firstView = self.leftView;
            cell.model = self.dataArray[0];
        }else {
            cell.secondView =self.tableView;
            cell.model = self.dataArray[0];
        }
    }
   
    return cell;
}


- (void)setID:(NSString *)ID {
    _ID = ID;
    
    [self loadDetailsDataWithID:ID];
}

#pragma mark - 网络请求
- (void)loadDetailsDataWithID:(NSString *)ID {
    NSString *URL = [NSString stringWithFormat:@"%@/%@",DETAIL,ID];
    NSString *sort = @"1";
    
    NSDictionary *pram = NSDictionaryOfVariableBindings(sort);
    
    
    [[HLSessionManager shareHLSessionManager] GET:URL parameters:pram progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HLBookDetailsModel *model = [HLBookDetailsModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        [self.dataArray addObject:model];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - GET
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(SSScreenW, self.JYD_Height);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        collectionView.pagingEnabled = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (HLLeftView *)leftView {
    if (!_leftView) {
        _leftView = [HLLeftView shwoLeftView];
    }
    return _leftView;
}

- (HLRightView *)tableView {
    if (!_tableView) {
        _tableView = [[HLRightView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, self.JYD_Height - 349)];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
