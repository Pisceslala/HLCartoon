//
//  HLBaseCollectionCell.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLDetailModel.h"
#import "HLBookRackModel.h"
@class HLBaseCollectionCell;
@protocol HLBaseCollectionCellDelegate <NSObject>

- (void)didEditCellItem:(HLBaseCollectionCell *)cell;

@end

@interface HLBaseCollectionCell : UICollectionViewCell

@property (strong, nonatomic) HLDetailModel *model;

@property (strong, nonatomic) HLBookRackModel *bookModel;

- (void)addGesturesForItem;

@property (weak, nonatomic) id<HLBaseCollectionCellDelegate> delegate;


@end
