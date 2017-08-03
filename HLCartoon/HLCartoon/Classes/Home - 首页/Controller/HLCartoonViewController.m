//
//  HLCartoonViewController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCartoonViewController.h"
#import "HLComicsModel.h"
#import "HLCartoonCell.h"
@interface HLCartoonViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *historyArray;

@property (assign, nonatomic) CGFloat rowHight;
@end

@implementation HLCartoonViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    //移动网络下载提示是否打开
    NSUserDefaults *def  = [NSUserDefaults standardUserDefaults];
    NSString *showStatus = [def objectForKey:NetWorkTipsKey];
    if ([showStatus integerValue]) {
        [self netWorkStatus]; //当前网络状态
    }
    
    
}

- (void)netWorkStatus {
    
    //获取网络状态
    if ([[HLSessionManager networkingStatesFromStatebar] isEqualToString:@"notReachable"]) {
        [AlertControllerTool alertSingleActionAtTitle:@"提示" message:@"当前网络不可用" actionTitle:@"返回" confirmHandler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if ([[HLSessionManager networkingStatesFromStatebar] isEqualToString:@"2G"]
              || [[HLSessionManager networkingStatesFromStatebar] isEqualToString:@"3G"]
              || [[HLSessionManager networkingStatesFromStatebar] isEqualToString:@"4G"]) {
        
        [AlertControllerTool alertSingleActionAtTitle:@"提示" message:@"当前使用移动网络,请注意流量~" actionTitle:@"确定" confirmHandler:^(UIAlertAction *action) {
            
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HLCartoonCell class] forCellReuseIdentifier:@"cartoonCell"];
    self.tableView.backgroundColor = [UIColor blackColor];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLCartoonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartoonCell" forIndexPath:indexPath];
    
    cell.imageURL = self.dataArray[indexPath.row];
    
    self.rowHight = cell.pageView.JYD_Size.height;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHight;
}

#pragma mark - SET
- (void)setID:(NSString *)ID {
    _ID = ID;
    
    [self loadCartoonImageByID:ID];
}

- (void)loadCartoonImageByID:(NSString *)ID {
    NSString *URL = [NSString stringWithFormat:@"%@/%@",COMICE,ID];
 
    [[HLSessionManager shareHLSessionManager] GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HLCartoonModel *model = [HLCartoonModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        for (NSString *imageURL in model.images) {
            [self.dataArray addObject:imageURL];
        }
        
        [self cacaheHistoryBook:responseObject[@"data"][@"topic"]]; //缓存到书架
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)cacaheHistoryBook:(NSDictionary *)dict {
    
    NSMutableArray *array = [[PINCache sharedCache] objectForKey:historyBookKey];

    //查重
    for (NSDictionary *hisDict in array) {
        
        if ([dict[@"title"] isEqualToString:hisDict[@"title"]]) {
            return;
        }
    }
    
    
    if (array.count == 0) {
        
        [self.historyArray addObject:dict];
        
        [[PINCache sharedCache] setObject:self.historyArray forKey:historyBookKey];
    }else {
        
        [array addObject:dict];
                
        [[PINCache sharedCache] setObject:array forKey:historyBookKey];
    }

    //[[PINCache sharedCache] removeAllObjects];

}
#pragma mark - get
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

@end
