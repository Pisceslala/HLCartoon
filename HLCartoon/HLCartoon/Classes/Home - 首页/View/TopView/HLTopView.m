//
//  HLTopView.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLTopView.h"

@interface HLTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UIButton *desBtn;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation HLTopView
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configViews];
}

- (void)configViews {
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.frame) - 1, self.contentBtn.JYD_Width - 100, 1)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self addSubview:self.lineView];
}

+ (instancetype)showTopView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HLTopView class]) owner:nil options:nil] lastObject];
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}
- (IBAction)desBtn:(id)sender {
    
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.lineView.JYD_X = 50;
        
    } completion:^(BOOL finished) {
        
        
    }];

    
}
- (IBAction)contentBtn:(id)sender {
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.lineView.JYD_X = CGRectGetMaxX(self.desBtn.frame) + 50;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

@end
