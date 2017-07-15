//
//  Const.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIKIT_EXTERN	        extern __attribute__((visibility ("default")))


@interface Const : NSObject

UIKIT_EXTERN NSString * const BASEURL;

UIKIT_EXTERN NSString * const BANNERS;

UIKIT_EXTERN NSString * const SUGGESTION;

UIKIT_EXTERN NSString * const DETAIL;

@end
