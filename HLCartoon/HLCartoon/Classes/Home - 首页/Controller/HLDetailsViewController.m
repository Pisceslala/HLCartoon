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
#import "HLRightView.h"
#import "HLCartoonViewController.h"
@interface HLDetailsViewController ()<HLTopViewDelegate,HLRightViewDelegate>

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
    self.hidesBottomBarWhenPushed = NO;
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

    self.bottomView.ID = ID;
}

- (void)setImageURL:(NSString *)imageURL {
    
    _imageURL = imageURL;
    
    self.topView.imageURL = imageURL;
}

#pragma mark - topViewDelegate
- (void)didClickLeftBtn {
    
    [UIView animateWithDuration:0.2 animations:^{
    
        self.bottomView.collectionView.contentOffset = CGPointMake(0, 0);
    
    }];
}

- (void)didClickRightBtn {
    
    [UIView animateWithDuration:0.2 animations:^{
    
        self.bottomView.collectionView.contentOffset = CGPointMake(SSScreenW, 0);
    
    }];
}

#pragma mark - bottomRightViewDelegate
- (void)didSelectRowAtID:(NSString *)ID {
    HLCartoonViewController *vc = [[HLCartoonViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    vc.ID = ID;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - GET

- (HLTopView *)topView {
    if (_topView == nil) {
    
        _topView = [HLTopView showTopView];
        
        _topView.delegate = self;
    
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
      
        _bottomView = [[HLBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SSScreenW, SSScreenH)];
        
        _bottomView.tableView.delegate = self;
    
    }
    
    return _bottomView;
}


@end
