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


/**************** CellIdentifiter ***********************/
UIKIT_EXTERN NSString * const listViewCellIdentifierForLove;
UIKIT_EXTERN NSString * const listViewCellIdentifierForFunny;
UIKIT_EXTERN NSString * const listViewCellIdentifierForHorrible;
UIKIT_EXTERN NSString * const listViewCellIdentifierForAncient;
UIKIT_EXTERN NSString * const listViewCellIdentifierForFantasy;
UIKIT_EXTERN NSString * const listViewCellIdentifierForSchool;
UIKIT_EXTERN NSString * const listViewCellIdentifierForCity;
UIKIT_EXTERN NSString * const listViewCellIdentifierForRainbow;
UIKIT_EXTERN NSString * const listViewCellIdentifierForYoung;
UIKIT_EXTERN NSString * const listViewCellIdentifierForPresident;
UIKIT_EXTERN NSString * const listViewCellIdentifierForEnergy;
UIKIT_EXTERN NSString * const listViewCellIdentifierForColumn;
UIKIT_EXTERN NSString * const listViewCellIdentifierForComplete;
@end
