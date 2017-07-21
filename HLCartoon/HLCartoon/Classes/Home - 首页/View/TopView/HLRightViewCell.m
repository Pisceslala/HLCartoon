//
//  HLRightViewCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLRightViewCell.h"

@interface HLRightViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

@implementation HLRightViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HLComicsModel *)model {
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.title_Label.text = model.title;
    
    NSString *likes = @"";
    if (model.likes_count > 10000) {
        likes = [NSString stringWithFormat:@"%zd万",model.likes_count / 10000];
    }else {
        likes = [NSString stringWithFormat:@"%zd",model.likes_count];
    }
    
    self.likesLabel.attributedText = [self attributedStringWithImage:@"likes" AppendString:likes];
}

#pragma mark - 图文混排
- (NSAttributedString *)attributedStringWithImage:(NSString *)imageName AppendString:(NSString *)text {
    
    NSTextAttachment *chment                  = [[NSTextAttachment alloc] init];
    
    chment.image                              = [UIImage imageNamed:imageName];
    
    chment.bounds                             = CGRectMake(0, -2, 12, 12);
    
    NSAttributedString *imageAttributed       = [NSAttributedString attributedStringWithAttachment:chment];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:imageAttributed];
    
    NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedText appendAttributedString:textAttributed];
    
    return attributedText;
}

@end
