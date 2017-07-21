//
//  HLSessionManager.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HLSessionManager : AFHTTPSessionManager

+ (AFHTTPSessionManager *_Nullable)shareHLSessionManager;

/**
 *  发送GET请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(nonnull NSString *)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(id _Nullable responseObject))success
    failure:(nullable void (^)(NSError * _Nullable error))failure;

+ (NSString *_Nullable)networkingStatesFromStatebar;

@end
