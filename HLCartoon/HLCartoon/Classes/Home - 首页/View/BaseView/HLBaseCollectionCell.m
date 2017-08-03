//
//  HLBaseCollectionCell.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBaseCollectionCell.h"

@interface HLBaseCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *baseImageView;
@property (weak, nonatomic) IBOutlet UILabel *baseTitle;

@end

@implementation HLBaseCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HLDetailModel *)model {
    _model = model;
    
    self.baseTitle.text = model.title;
    
    [self.baseImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setBookModel:(HLBookRackModel *)bookModel {
    _bookModel = bookModel;
    
    self.baseTitle.text = bookModel.title;
    
    [self.baseImageView sd_setImageWithURL:[NSURL URLWithString:bookModel.vertical_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end
