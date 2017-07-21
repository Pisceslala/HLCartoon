//
//  HLCartoonCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCartoonCell.h"

@interface HLCartoonCell ()

@property (assign, nonatomic) CGSize imgSize;


@end

@implementation HLCartoonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    
    
    [self.pageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        UIImage *newImage = [[UIImage alloc] imageCompressForWidthScale:image targetWidth:SSScreenW];
        
        self.pageView.JYD_Size = newImage.size;
        
    }];
    
    
}

- (UIImageView *)pageView {
    if (!_pageView) {
        _pageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, SSScreenH)];
        _pageView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_pageView];
    }
    return _pageView;
}

@end
