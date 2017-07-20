//
//  HLBookDetailsModel.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBookDetailsModel.h"

@implementation HLBookDetailsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"descriptions" : @"description"
             };
}

@end
