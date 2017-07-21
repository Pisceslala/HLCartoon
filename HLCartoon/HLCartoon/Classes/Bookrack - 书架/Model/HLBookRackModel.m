//
//  HLBookRackModel.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBookRackModel.h"

@implementation HLBookRackModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"descriptions" : @"description"
             };
}

@end
