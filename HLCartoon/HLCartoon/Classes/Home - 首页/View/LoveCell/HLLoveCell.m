//
//  HLLoveCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLLoveCell.h"
#import "HLSuggestionModel.h"
#import "HLLoveDetailCell.h"
#import "HLDetailModel.h"
@interface HLLoveCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation HLLoveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HLLoveDetailCell" bundle:nil] forCellWithReuseIdentifier:@"detailCell"];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(SSScreenW / 3, self.collectionView.JYD_Height);
    flow.minimumLineSpacing = 5.0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.collectionView.collectionViewLayout = flow;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSuggestionTitle:(NSString *)suggestionTitle {
    _suggestionTitle = suggestionTitle;
    
    self.title_Label.text = suggestionTitle;
    
    [self loadLoveDetailData:suggestionTitle];
    
}

- (void)loadLoveDetailData:(NSString *)title {
    
    NSString *limit = @"20";
    NSString *offset = @"0";
    NSString *tag = title;
    NSDictionary *parm = NSDictionaryOfVariableBindings(limit,offset,tag);
    
    [[HLSessionManager shareHLSessionManager] GET:DETAIL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [HLDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topics"]];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - delegate AND dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HLLoveDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
    
    HLDetailModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


#pragma mark - get
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
