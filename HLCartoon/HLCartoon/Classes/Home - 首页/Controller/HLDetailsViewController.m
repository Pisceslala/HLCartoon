//
//  HLDetailsViewController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLDetailsViewController.h"
#import "HLTopView.h"
#import "HLBookDetailsModel.h"
#import "HLBottomView.h"
@interface HLDetailsViewController ()

@property (strong, nonatomic) HLTopView *topView;

@property (strong, nonatomic) HLBottomView *bottomView;

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation HLDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews];
}

#pragma mark - 初始化
- (void)configViews {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.bottomView];
}



#pragma mark - Set
- (void)setID:(NSString *)ID {
    _ID = ID;
    
    NSLog(@"漫画id = %@",ID);
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    self.topView.imageURL = imageURL;
}


#pragma mark - GET

- (HLTopView *)topView {
    if (_topView == nil) {
        _topView = [HLTopView showTopView];
    }
    return _topView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        sc.contentSize = CGSizeMake(0, SSScreenH + 300 - 50);
        _scrollView = sc;
    }
    return _scrollView;
}

- (HLBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[HLBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SSScreenW, SSScreenH - 300)];
    }
    return _bottomView;
}

@end
