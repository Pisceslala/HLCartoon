//
//  HLHomeViewController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLHomeViewController.h"
#import "HLBannersView.h"
#import "HLBannersModel.h"
#import "HLSuggestionModel.h"
#import "HLLoveCell.h"
#import "HLFunnyCell.h"
#import "HLBaseCell.h"
#import "HLSessionManager.h"
#import "HLHorribleCell.h"
@interface HLHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listView;

@property (strong, nonatomic) NSMutableArray *bannerArray;

@property (strong, nonatomic) NSMutableArray *suggestion;

@property (strong, nonatomic) HLBannersView *bannerView; //轮播图

@end

@implementation HLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews];
    
    [self loadBannersData]; //轮播图数据
    
    [self loadCartoonListData];
}

- (void)configViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"HLLoveCell" bundle:nil] forCellReuseIdentifier:@"loveCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"HLFunnyCell" bundle:nil] forCellReuseIdentifier:@"funnyCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"HLHorribleCell" bundle:nil] forCellReuseIdentifier:@"horribleCell"];
    
}

#pragma mark - dataSource AND delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.suggestion.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HLLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loveCell"];
        HLSuggestionModel *model = self.suggestion[0];
        cell.model = model;
        return cell;
    }else if (indexPath.section == 1) {
        HLFunnyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funnyCell"];
        HLSuggestionModel *model = self.suggestion[3];
        cell.model = model;
        return cell;
    }else if (indexPath.section == 2) {
        HLHorribleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"horribleCell"];
        HLSuggestionModel *model = self.suggestion[1];
        cell.model = model;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    }
    
    cell.textLabel.text = @"qwe";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//设置间距
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 220;
    }else {
        return 10.f;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
    
}

//返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
    }else if (indexPath.section == 1) {
        return 410;
    }else if (indexPath.section == 2) {
        return 750;
    }
    return 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.bannerView;
    }
    return nil;
}




#pragma mark - 数据请求
- (void)loadBannersData {
    
    [[HLSessionManager shareHLSessionManager] GET:BANNERS parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"][@"banner_group"];
        self.bannerArray = [HLBannersModel mj_objectArrayWithKeyValuesArray:array];
        [self configBannersView:self.bannerArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 : %@",error);
    }];
    
}

- (void)configBannersView:(NSMutableArray *)bannerModelArray {
    HLBannersView *bannerView = [[HLBannersView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 220)];
    bannerView.bannerModelArray = bannerModelArray;
    self.bannerView = bannerView;
    [self.listView reloadData];
}


- (void)loadCartoonListData {
    
    [[HLSessionManager shareHLSessionManager] GET:SUGGESTION parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.suggestion = [HLSuggestionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"suggestion"]];
        [self.listView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 : %@",error);
    }];
    
}

#pragma mark - Get
- (UITableView *)listView {
    if (_listView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, SSScreenH) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        _listView = tableView;
    }
    return _listView;
}

- (NSMutableArray *)bannerArray {
    if (_bannerArray == nil) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

- (NSMutableArray *)suggestion {
    if (_suggestion == nil) {
        _suggestion = [NSMutableArray array];
    }
    return _suggestion;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
