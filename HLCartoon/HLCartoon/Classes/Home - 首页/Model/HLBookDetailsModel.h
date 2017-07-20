//
//  HLBookDetailsModel.h
//  HLCartoon
//
//  Created by Pisces on 2017/7/20.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLBookDetailsModel : NSObject

@property (nonatomic, copy) NSString *discover_image_url;

/**
 真实图片
 */
@property (nonatomic, copy) NSString *vertical_image_url;

/**
 更新时间
 */
@property (nonatomic, assign) NSInteger updated_at;

/**
 cover图片
 */
@property (nonatomic, copy) NSString *cover_image_url;
//替换
/**
 漫画简介
 */
@property (nonatomic, copy) NSString *descriptions;

/**
 创建时间
 */
@property (nonatomic, assign) NSInteger created_at;

/**
 ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 标签id
 */
@property (nonatomic, assign) NSInteger label_id;

@property (assign, nonatomic) NSInteger order;

/**
 章数
 */
@property (assign, nonatomic) NSInteger comics_count;

/**
 更新状态
 */
@property (strong, nonatomic) NSString *update_status;

/**
 更新日期
 */
@property (nonatomic, copy) NSString *update_day;

/**
 评论数
 */
@property (assign, nonatomic) NSInteger comments_count;

/**
 收藏人数
 */
@property (assign, nonatomic) NSInteger likes_count;

/**
 点赞数
 */
@property (assign, nonatomic) NSInteger fav_count;

/**
 是否点赞
 */
@property (assign, nonatomic) BOOL is_favourite;

/**
 排序
 */
@property (assign, nonatomic) NSInteger sort;

/**
 作者信息
 */
@property (strong, nonatomic) NSDictionary *user;

/**
 有关作者
 */
@property (strong, nonatomic) NSArray *related_authors;

/**
 观看人数
 */
@property (assign, nonatomic) NSInteger view_count;

/**
 标签
 */
@property (strong, nonatomic) NSDictionary *label;

/**
 类别
 */
@property (strong, nonatomic) NSArray *category;

/**
 是否是免费
 */
@property (assign, nonatomic) BOOL is_free;

/**
 是否隐藏ip
 */
@property (assign, nonatomic) BOOL ip_hidden;

/**
 漫画篇章
 */
@property (strong, nonatomic) NSArray *comics;




@end
