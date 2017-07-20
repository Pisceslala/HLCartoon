//
//  HLMoreListCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLMoreListCell.h"

@interface HLMoreListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *coin_Numb;

@end

@implementation HLMoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    self.authorName.text = [NSString stringWithFormat:@"作者: %@",model.user[@"nickname"]];
    
    NSString *likes = @"";
    if (model.likes_count > 10000) {
        likes = [NSString stringWithFormat:@"%zd万",model.likes_count / 10000];
    }else {
        likes = [NSString stringWithFormat:@"%zd",model.likes_count];
    }
    
    self.coin_Numb.attributedText = [self attributedStringWithImage:@"likes" AppendString:likes];
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
