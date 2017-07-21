//
//  HLBookRackModel.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLBookRackModel : NSObject

@property (nonatomic, copy) NSString *discover_image_url;

@property (nonatomic, copy) NSString *vertical_image_url;

@property (nonatomic, copy) NSString *cover_image_url;
//要更换
@property (nonatomic, copy) NSString *descriptions;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *is_favourite;

@property (nonatomic, copy) NSString *title;

@property (assign, nonatomic) NSInteger likes_count;

@property (nonatomic, copy) NSString *updated_at;

@property (strong, nonatomic) NSMutableDictionary *special_offer;

@property (assign, nonatomic) NSInteger user_id;

@property (assign, nonatomic) NSInteger comments_count;

@property (assign, nonatomic) BOOL is_free;

@property (nonatomic, copy) NSString *ID;

@property (strong, nonatomic) NSDictionary *user;

@property (assign, nonatomic) NSInteger label_id;

@property (assign, nonatomic) NSInteger order;

@property (assign, nonatomic) NSInteger comics_count;


@end
