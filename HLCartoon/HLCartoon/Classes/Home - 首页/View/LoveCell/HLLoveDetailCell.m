//
//  HLLoveDetailCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLLoveDetailCell.h"

@interface HLLoveDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@end

@implementation HLLoveDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(HLDetailModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.vertical_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.title_Label.text = model.title;
}

@end
