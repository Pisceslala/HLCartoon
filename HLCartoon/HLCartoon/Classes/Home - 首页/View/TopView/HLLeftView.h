//
//  HLLeftView.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLBookDetailsModel.h"
@interface HLLeftView : UIView
@property (strong, nonatomic) HLBookDetailsModel *model;
+ (instancetype)shwoLeftView;

@end
