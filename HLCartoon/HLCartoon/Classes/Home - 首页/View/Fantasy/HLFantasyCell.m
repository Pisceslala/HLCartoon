//
//  HLFantasyCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/19.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLFantasyCell.h"

@interface HLFantasyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@end

@implementation HLFantasyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(HLDetailModel *)model {
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.vertical_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconView.layer.masksToBounds = YES;
    
    
    self.title_Label.text = model.title;
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height += 10;
    frame.origin.y -= 5;
    frame.size.width -= 6;
    frame.origin.x += 3;
    [super setFrame:frame];
}
@end
