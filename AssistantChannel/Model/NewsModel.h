//
//  NewsModel.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property (nonatomic, copy) NSString *newsid;
@property (nonatomic, copy) NSString *ntype_name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *view_num;
@property (nonatomic, copy) NSString *dep_code;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *valid_time;
@property (nonatomic, copy) NSString *ntype;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *dep_id;
@property (nonatomic, copy) NSString *is_visited;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
