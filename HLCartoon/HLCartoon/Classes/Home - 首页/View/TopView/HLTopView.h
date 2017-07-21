//
//  HLTopView.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLTopViewDelegate <NSObject>

- (void)didClickLeftBtn;

- (void)didClickRightBtn;

@end

@interface HLTopView : UIView
+ (instancetype)showTopView;
@property (assign, nonatomic) NSString *imageURL;

@property (weak, nonatomic) id<HLTopViewDelegate> delegate;

@property (strong, nonatomic) UIView *lineView;

@end
