//
//  HLSessionManager.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLSessionManager.h"

@implementation HLSessionManager

//超时时间
static int const DEFAULT_REQUEST_TIME_OUT = 20;
+(AFHTTPSessionManager *)shareHLSessionManager {
        static HLSessionManager *sharedHttpSession = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedHttpSession = [[HLSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
            sharedHttpSession.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
            sharedHttpSession.responseSerializer = [AFJSONResponseSerializer serializer];
            sharedHttpSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"multipart/form-data",@"text/plain",nil];
            //开始监听网络状态
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
            [manager startMonitoring];
            
        });
        
        return sharedHttpSession;
        
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id _Nullable))success
    failure:(void (^)(NSError * _Nullable))failure {
    
    AFHTTPSessionManager *manager = [self shareHLSessionManager];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败,请检查网络!"];
        
        if (error) {
            NSLog(@"error = %@",error);
        }
        failure(error);
    }];
   
    
}

+ (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

@end
