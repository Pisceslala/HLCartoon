//
//  HLLeftView.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLLeftView.h"

@interface HLLeftView ()
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UILabel *authoName;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@end

@implementation HLLeftView

+ (instancetype)shwoLeftView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HLLeftView class]) owner:nil options:nil] lastObject];
}

- (void)setModel:(HLBookDetailsModel *)model {
    _model = model;
    
    self.title_Label.text = model.title;
    
    self.authoName.text = [NSString stringWithFormat:@"作者: %@",model.user[@"nickname"]];

    self.desLabel.text = model.descriptions;
}
@end
