//
//  HLBaseCell.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLSuggestionModel.h"
#import "HLDetailModel.h"
@interface HLBaseCell : UITableViewCell
@property (strong, nonatomic) HLSuggestionModel *model;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end
