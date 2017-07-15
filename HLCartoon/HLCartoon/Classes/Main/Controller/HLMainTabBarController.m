//
//  HLMainTabBarController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLMainTabBarController.h"
#import "HLSettingViewController.h" //设置
#import "HLHomeViewController.h"    //首页
#import "HLBookRackViewController.h"    //书架

@interface HLMainTabBarController ()

@end

@implementation HLMainTabBarController

+ (void)initialize {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self addChileVC];
    
    self.selectedIndex = 1;
}

- (void)addChileVC {
    
    [self setupChileViewController:[[HLBookRackViewController alloc] init]
                         WithTitle:@"书架"
                       NormalImage:@"书架"
                       SelectImage:@"书架_select"];
    
    [self setupChileViewController:[[HLHomeViewController alloc] init]
                         WithTitle:@"首页"
                       NormalImage:@"home"
                       SelectImage:@"home_select"];
    
    [self setupChileViewController:[[HLSettingViewController alloc] init]
                         WithTitle:@"设置"
                       NormalImage:@"set"
                       SelectImage:@"set_select"];
}

#pragma mark - 添加子控制器
- (void)setupChileViewController:(UIViewController *)childVC
                       WithTitle:(NSString *)title
                     NormalImage:(NSString *)imageName
                     SelectImage:(NSString *)selectImage {
    
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
