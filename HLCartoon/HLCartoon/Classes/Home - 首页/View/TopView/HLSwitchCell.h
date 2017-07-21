//
//  HLSwitchCell.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLBookDetailsModel.h"
#import "HLLeftView.h"
#import "HLRightView.h"
@interface HLSwitchCell : UICollectionViewCell

@property (nonatomic,strong)HLLeftView *firstView;
@property (nonatomic,strong)HLRightView *secondView;
@property (strong, nonatomic) HLBookDetailsModel *model;
@end
