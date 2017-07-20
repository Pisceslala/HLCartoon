//
//  HLBaseHeader.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/18.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSuggestionModel.h"

@protocol HLBaseHeaderDelegate <NSObject>

- (void)didClickMoreButtonInHeaderView:(NSString *)suggestion;

@end

@interface HLBaseHeader : UIView
@property (strong, nonatomic) HLSuggestionModel *suggestionModel;

@property (weak, nonatomic) id<HLBaseHeaderDelegate> delegate;


+ (instancetype)showBaseHeaderView;
@end
