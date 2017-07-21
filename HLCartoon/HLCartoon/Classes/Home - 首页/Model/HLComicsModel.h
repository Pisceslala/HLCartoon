//
//  HLComicsModel.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/21.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLComicsModel : NSObject
@property (nonatomic, assign) BOOL can_view;

@property (nonatomic, copy) NSString *cover_image_url;

@property (nonatomic, copy) NSString *storyboard_cnt;

@property (nonatomic, assign) NSInteger created_at;

@property (assign, nonatomic) BOOL has_pay;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (assign, nonatomic) NSInteger likes_count;

@property (strong, nonatomic) NSDictionary *special_offer;

@property (assign, nonatomic) NSInteger updated_at;

@property (assign, nonatomic) NSInteger comments_count;

@property (assign, nonatomic) BOOL is_free;

@property (assign, nonatomic) NSInteger push_flag;

@property (nonatomic, copy) NSString *ID;

@property (assign, nonatomic) NSInteger topic_id;

@property (assign, nonatomic) NSInteger serial_no;

@property (nonatomic, copy) NSString *status;


@end


@interface HLCartoonModel : NSObject

@property (strong, nonatomic) NSArray *images;

@end
