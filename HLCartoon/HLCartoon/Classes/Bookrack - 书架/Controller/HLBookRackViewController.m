//
//  HLBookRackViewController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBookRackViewController.h"
#import "HLBaseCollectionCell.h"
#import "HLBookRackModel.h"
#import "HLDetailsViewController.h"
@interface HLBookRackViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HLBaseCollectionCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HLBookRackViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSMutableArray *array = [[PINCache sharedCache] objectForKey:historyBookKey];
    self.dataArray = [HLBookRackModel mj_objectArrayWithKeyValuesArray:array];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configViews];
}

- (void)configViews {
    
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HLBaseCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"bookeRackCell"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookeRackCell" forIndexPath:indexPath];
    
    cell.bookModel = self.dataArray[indexPath.row];
    cell.delegate = self;
    [cell addGesturesForItem];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HLBookRackModel *model = self.dataArray[indexPath.row];
    
    HLDetailsViewController *vc = [[HLDetailsViewController alloc] init];
    vc.ID = model.ID;
    vc.imageURL = model.cover_image_url;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didEditCellItem:(HLBaseCollectionCell *)cell {
    [AlertControllerTool alertShootActionAtTitle:@"提示" message:@"是否删除漫画" sureTitle:@"残忍删除" cancelTitle:@"取消" confirmHandler:^(UIAlertAction *action) {
        [self deleteCell:cell];
    } cancelHandler:^(UIAlertAction *action) {
        
    }];
}

- (void)deleteCell:(HLBaseCollectionCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [self.dataArray removeObjectAtIndex:indexPath.row];
    NSMutableArray *array = [HLBookRackModel mj_keyValuesArrayWithObjectArray:self.dataArray];
    //更新缓存
    [[PINCache sharedCache] setObject:array forKey:historyBookKey];
    [self.collectionView reloadData];
}

#pragma mark - GET
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(SSScreenW / 3.0 - 10, (SSScreenH - 64 - 49) / 3.0);
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 3;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, SSScreenH - 49) collectionViewLayout:flow];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _collectionView = collectionView;
        
        
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
