//
//  HLBottomView.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLRightView;
@interface HLBottomView : UIView

@property (nonatomic, copy) NSString *ID;

@property (strong,nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) HLRightView *tableView;

@end
