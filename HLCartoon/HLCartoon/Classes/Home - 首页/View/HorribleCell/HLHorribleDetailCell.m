//
//  HLHorribleDetailCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/15.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLHorribleDetailCell.h"

@interface HLHorribleDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@property (weak, nonatomic) IBOutlet UILabel *descriLabel;

@end


@implementation HLHorribleDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(HLDetailModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.vertical_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.title_Label.text = model.title;
    self.descriLabel.text = model.descriptions;
}
@end
