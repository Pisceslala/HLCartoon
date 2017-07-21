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
#import "HLBaseHeader.h"
#import "HLAncientCell.h"
#import "HLFantasy.h"
#import "HLSchoolCell.h"
#import "HLCityCell.h"
#import "HLRainbowCell.h"
#import "HLYoungCell.h"
#import "HLPresidentCell.h"
#import "HLEnergyCell.h"
#import "HLColumnCell.h"
#import "HLCompleteCell.h"
#import "HLMoreListViewController.h"
#import "HLDetailsViewController.h"
typedef NS_ENUM(NSInteger, HeaderViewStyle) {
    HeaderViewStyleLove,        //==> 0
    HeaderViewStyleHorrible,
    HeaderViewStyleAncient,
    HeaderViewStyleFunny,
    HeaderViewStyleFantasy,
    HeaderViewStyleSchool,
    HeaderViewStyleCity
};

@interface HLHomeViewController ()<UITableViewDelegate, UITableViewDataSource, HLBaseHeaderDelegate>

@property (nonatomic, strong) UITableView *listView; //主列表

@property (strong, nonatomic) NSMutableArray *bannerArray; //轮播图数组

@property (strong, nonatomic) NSMutableArray *suggestion; //头部栏目标题数组

@property (strong, nonatomic) HLBannersView *bannerView; //轮播图

@property (strong, nonatomic) HLBaseHeader *baseHeader; //头部视图

@property (assign, nonatomic) HeaderViewStyle HeaderViewStyle;

@end

@implementation HLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews]; //初始化
    
    [self loadBannersData]; //轮播图数据
    
    [self loadCartoonListData]; //加载列表数据
}

#pragma mark - 初始化
- (void)configViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listView];
    
    [self registerCell];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSelector:) name:kHomeCellDidClickNotification object:nil];
    
}

#pragma mark - 注册Cell
- (void)registerCell {
    [self registrTabelViewCellWithNibName:NSStringFromClass([HLLoveCell class]) cellReuseIdentifier:listViewCellIdentifierForLove];
    [self registrTabelViewCellWithNibName:NSStringFromClass([HLFunnyCell class]) cellReuseIdentifier:listViewCellIdentifierForFunny];
    [self registrTabelViewCellWithNibName:NSStringFromClass([HLHorribleCell class]) cellReuseIdentifier:listViewCellIdentifierForHorrible];
    
    [self.listView registerClass:[HLAncientCell class] forCellReuseIdentifier:listViewCellIdentifierForAncient];
    [self.listView registerClass:[HLFantasy class] forCellReuseIdentifier:listViewCellIdentifierForFantasy];
    [self.listView registerClass:[HLSchoolCell class] forCellReuseIdentifier:listViewCellIdentifierForSchool];
    [self.listView registerClass:[HLCityCell class] forCellReuseIdentifier:listViewCellIdentifierForCity];
    [self.listView registerClass:[HLRainbowCell class] forCellReuseIdentifier:listViewCellIdentifierForRainbow];
    [self.listView registerClass:[HLYoungCell class] forCellReuseIdentifier:listViewCellIdentifierForYoung];
    [self.listView registerClass:[HLPresidentCell class] forCellReuseIdentifier:listViewCellIdentifierForPresident];
    [self.listView registerClass:[HLEnergyCell class] forCellReuseIdentifier:listViewCellIdentifierForEnergy];
    [self.listView registerClass:[HLColumnCell class] forCellReuseIdentifier:listViewCellIdentifierForColumn];
    [self.listView registerClass:[HLCompleteCell class] forCellReuseIdentifier:listViewCellIdentifierForComplete];
    
}

- (void)registrTabelViewCellWithNibName:(NSString *)cellName cellReuseIdentifier:(NSString *)listViewCellIdentifiter {
    
    [self.listView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:listViewCellIdentifiter];
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
        HLLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForLove];
        cell.suggestionTitle = @"恋爱";
        return cell;
    }else if (indexPath.section == 1) {
        HLFunnyCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForFunny];
        cell.suggestionTitle = @"爆笑";
        return cell;
    }else if (indexPath.section == 2) {
        HLHorribleCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForHorrible];
        cell.suggestionTitle = @"灵异";
        return cell;
    }else if (indexPath.section == 3) {
        HLAncientCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForAncient];
        cell.suggestionTitle = @"古风";
        return cell;
    }else if (indexPath.section == 4) {
        HLFantasy *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForFantasy];
        cell.suggestionTitle = @"奇幻";
        return cell;
    }else if (indexPath.section == 5) {
        HLSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForSchool];
        cell.suggestionTitle = @"校园";
        return cell;
    }else if (indexPath.section == 6) {
        HLCityCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForCity];
        cell.suggestionTitle = @"都市";
        return cell;
    }else if (indexPath.section == 7) {
        HLRainbowCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForRainbow];
        cell.suggestionTitle = @"彩虹";
        return cell;
    }else if (indexPath.section == 8) {
        HLYoungCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForYoung];
        cell.suggestionTitle = @"少年";
        return cell;
    }else if (indexPath.section == 9) {
        HLPresidentCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForPresident];
        cell.suggestionTitle = @"总裁";
        return cell;
    }else if (indexPath.section == 10) {
        HLEnergyCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForEnergy];
        cell.suggestionTitle = @"正能量";
        return cell;
    }else if (indexPath.section == 11) {
        HLColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForColumn];
        cell.suggestionTitle = @"栏目";
        return cell;
    }else if (indexPath.section == 12) {
        HLCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:listViewCellIdentifierForComplete];
        cell.suggestionTitle = @"完结";
        return cell;
    }
    return nil;
    
}

#pragma mark - 设置间距
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 220;
    }else {
        return 40;
    }
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

//返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 240;
    }else if (indexPath.section == 1) {
        return 380; //-30
    }else if (indexPath.section == 2) {
        return 300;
    }else if (indexPath.section == 3) {
        return 258;
    }else if (indexPath.section == 4) {
        return 250;
    }else if (indexPath.section == 5) {
        return 440;
    }else if (indexPath.section == 6) {
        return 340;
    }else if (indexPath.section == 7) {
        return 375;
    }else if (indexPath.section == 8) {
        return 330;
    }else if (indexPath.section == 9) {
        return 250;
    }else if (indexPath.section == 10) {
        return 130;
    }else if (indexPath.section == 11) {
        return 250;
    }else if (indexPath.section == 12) {
        return 338;
    }
    return 64;
}

//返回每一行的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.bannerView;
    }else if (section == 1) {
        return [self addHeaderViewForHeaderInSection:3];
    }else if (section == 2) {
        return [self addHeaderViewForHeaderInSection:1];
    }else if (section == 3) {
        return [self addHeaderViewForHeaderInSection:2];
    }else if (section == 4) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 5) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 6) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 7) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 8) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 9) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 10) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 11) {
        return [self addHeaderViewForHeaderInSection:section];
    }else if (section == 12) {
        return [self addHeaderViewForHeaderInSection:section];
    }
    
    
    
    return nil;

}


/**
 快速创建每行头部视图

 @param section 行
 @return 头部视图
 */
- (HLBaseHeader *)addHeaderViewForHeaderInSection:(NSInteger)section {
    HLBaseHeader *baseHeader = [HLBaseHeader showBaseHeaderView];
    HLSuggestionModel *model = self.suggestion[section];
    baseHeader.suggestionModel = model;
    baseHeader.delegate = self;
    return baseHeader;
}

#pragma mark - headerViewDelegate
- (void)didClickMoreButtonInHeaderView:(NSString *)suggestion {
    HLMoreListViewController *vc = [[HLMoreListViewController alloc] init];
    vc.title = suggestion;
    vc.suggestion = suggestion;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 数据请求(轮播图数据)
- (void)loadBannersData {
    
    [[HLSessionManager shareHLSessionManager] GET:BANNERS parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"data"][@"banner_group"];
        self.bannerArray = [HLBannersModel mj_objectArrayWithKeyValuesArray:array];
        
        //设置轮播图
        [self configBannersView:self.bannerArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 : %@",error);
    }];
    
}

#pragma mark - 初始化轮播图
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

#pragma mark - 接收消息执行方法
- (void)notificationSelector:(NSNotification *)notifitce {
    NSDictionary *dict = notifitce.object;
    
    HLDetailsViewController *vc = [[HLDetailsViewController alloc] init];
    vc.ID = dict[@"ID"];
    vc.imageURL = dict[@"imageURL"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
