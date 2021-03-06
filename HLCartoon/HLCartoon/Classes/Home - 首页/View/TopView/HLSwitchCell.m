//
//  HLSwitchCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLSwitchCell.h"

@implementation HLSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setFirstView:(HLLeftView *)firstView {
    _firstView = firstView;
    [self.contentView addSubview:firstView];
}

- (void)setSecondView:(HLRightView *)secondView {
    _secondView = secondView;
    [self.contentView addSubview:secondView];
}

- (void)setModel:(HLBookDetailsModel *)model {
    _model = model;
    self.firstView.model = model;
    self.secondView.model = model;
}
@end
