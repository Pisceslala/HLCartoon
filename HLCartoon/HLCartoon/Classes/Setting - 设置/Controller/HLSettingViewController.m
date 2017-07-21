//
//  HLSettingViewController.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLSettingViewController.h"
#import "ClearCacheTool.h"
@interface HLSettingViewController ()

@property (strong, nonatomic) UISwitch *switchBtn;

@end

@implementation HLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"移动网络下载阅读/下载提醒";
        
        cell.accessoryView = self.switchBtn;
        
    }else {
       
        cell.textLabel.text = @"清理缓存";
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lfM",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0];
    
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [AlertControllerTool alertDestructionTitle:@"提示" Mesasge:@"是否清空缓存?" sureTitle:@"确定" cancelTitle:@"取消" confirmHandler:^(UIAlertAction *action) {
            
            [SVProgressHUD showWithStatus:@"正在清理..."];
            
            [[SDImageCache sharedImageCache] clearMemory];
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
                [SVProgressHUD dismiss];
                
                [SVProgressHUD showSuccessWithStatus:@"清理完成!"];
            
            }];
            [self.tableView reloadData];

            
        } cancleHandler:^(UIAlertAction *action) {
            
        }];
    }
}

#pragma mark - 开关按钮点击
- (void)saveSwitchStatus:(UISwitch *)switchBtn {
    
    //使用偏好设置保存值
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    [def setBool:switchBtn.isOn forKey:NetWorkTipsKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5.0;
    
}

- (UISwitch *)switchBtn {
    
    if (_switchBtn == nil) {
        
        _switchBtn = [[UISwitch alloc] init];
        
        NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:NetWorkTipsKey];
        
        [_switchBtn setOn:[status integerValue]];
        
        [_switchBtn addTarget:self action:@selector(saveSwitchStatus:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchBtn;
}

- (void)dealloc {
    NSLog(@"dealloc");
}
@end
