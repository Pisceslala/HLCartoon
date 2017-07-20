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
@interface HLBottomView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) HLLeftView *leftView;
@property (strong, nonatomic) UITableView *tableView;

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
}


#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLSwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.firstView = self.leftView;
    }else {
        cell.secondView =self.tableView;
    }
    return cell;
}

#pragma mark - GET
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(SSScreenW, self.JYD_Height);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        collectionView.pagingEnabled = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
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

@end
