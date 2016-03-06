//
//  NewsModel.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel



- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.newsid = [attributes valueForKeyPath:@"id"];
    self.ntype_name = [attributes valueForKeyPath:@"ntype_name"];
    self.uid = [attributes valueForKeyPath:@"uid"];
    self.title = [attributes valueForKey:@"title"];
    self.url = [attributes valueForKeyPath:@"url"];
    self.view_num = [attributes valueForKeyPath:@"view_num"];
    self.dep_code = [attributes valueForKey:@"dep_code"];
    self.create_time = [attributes valueForKeyPath:@"create_time"];
    self.valid_time = [attributes valueForKeyPath:@"valid_time"];
    self.ntype = [attributes valueForKey:@"ntype"];
    self.nickname = [attributes valueForKeyPath:@"nickname"];
    self.dep_id = [attributes valueForKeyPath:@"dep_id"];
    self.is_visited = [attributes valueForKey:@"is_visited"];

    
    return self;
}

@end
