//
//  HLBannersView.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBannersView.h"
#import "HLBannersModel.h"
#import <UIButton+WebCache.h>
@interface HLBannersView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIButton *bannerButton; //滚动图

@property (nonatomic, strong) UIScrollView *bannerScrollView;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger pageNum;
@end

@implementation HLBannersView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configViews];
    }
    return self;
}



- (void)configViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 220)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    self.bannerScrollView = scrollView;
    [self addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame) - 20, 100, 20)];
    pageControl.JYD_CenterX = scrollView.JYD_CenterX;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}



- (void)setBannerModelArray:(NSMutableArray *)bannerModelArray {
   
    _bannerModelArray = bannerModelArray;

    self.bannerScrollView.contentSize = CGSizeMake(bannerModelArray.count * SSScreenW, 0);
    
    //创建轮播
    for (int i = 0; i < bannerModelArray.count; i++) {
        HLBannersModel *model  = bannerModelArray[i];
        CGFloat x              = i * SSScreenW;
        UIButton *bannerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bannerButton.frame = CGRectMake(x, 0, SSScreenW, 220);
        
        //取消点击时图片高亮显示阴影
        [bannerButton setAdjustsImageWhenHighlighted:NO];
        
        [bannerButton sd_setImageWithURL:[NSURL URLWithString:model.pic] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        
        [bannerButton addTarget:self action:@selector(bannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.bannerButton      = bannerButton;
        bannerButton.tag       = i * 100;
        [self.bannerScrollView addSubview:bannerButton];
    }
    
    self.pageNum = 0;
    self.pageControl.numberOfPages = bannerModelArray.count;
    self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    //开启轮播
    [self configTime];
    
}



- (void)configTime {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}



- (void)timeAction {
    ++self.pageNum;
    
    if (self.pageNum > self.bannerModelArray.count - 1) {
        self.pageNum = 0;
    }
    
    [self.bannerScrollView setContentOffset:CGPointMake(self.pageNum * SSScreenW, 0) animated:YES];
}



- (void)changePage:(UIPageControl *)pageContrl {
    
    //根据当前的页数，使得scrollView也滑动到对应的子视图  通过设置scrollView的contentOffSet来实现（改变contentOffSet实际上就是改变scrollView的bounds）
    int page = (int)pageContrl.currentPage;//得到当前页数
    //设置scrollView的偏移量
    [self.bannerScrollView setContentOffset:CGPointMake(page * CGRectGetWidth(self.frame), 0) animated:YES];
    
}



- (void)bannerButtonClick:(UIButton *)btn{
    
}


#pragma mark - delegate 
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //拖动时停止
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self configTime];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    int page = offsetX / SSScreenW + 0.5 ;

    self.pageControl.currentPage = page;
    
}

@end
