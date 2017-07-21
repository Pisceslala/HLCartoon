//
//  HLRightView.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLBookDetailsModel.h"

@protocol HLRightViewDelegate <NSObject>

- (void)didSelectRowAtID:(NSString *)ID;

@end

@interface HLRightView : UIView
@property (strong, nonatomic) HLBookDetailsModel *model;

@property (weak, nonatomic) id<HLRightViewDelegate> delegate;

@end
