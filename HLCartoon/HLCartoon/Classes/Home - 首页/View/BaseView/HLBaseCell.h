//
//  HLBaseCell.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/14.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HLDetailModel.h"
@interface HLBaseCell : UITableViewCell
@property (nonatomic, copy) NSString *suggestionTitle;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end
