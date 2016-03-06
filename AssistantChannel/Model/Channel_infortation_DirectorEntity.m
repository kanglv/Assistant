//
//  Channel_infortation_DirectorEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Channel_infortation_DirectorEntity.h"

@implementation Channel_infortation_DirectorEntity


- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
//    
//    self.is_manage = [attributes valueForKeyPath:@"is_manage"];
//    self.head = [attributes valueForKeyPath:@"head"];
//    self.dep_id = [attributes valueForKeyPath:@"dep_id"];

    self.title = [attributes valueForKeyPath:@"title"];
    self.total = [attributes valueForKey:@"total"];
    self.stat = [attributes valueForKeyPath:@"stat"];
    self.ls_dep_id = [attributes valueForKey:@"dep_id"];
    
    
    return self;
}

- (instancetype)initWithAarray:(NSDictionary *)attributes{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [attributes valueForKeyPath:@"title"];
    self.total = [attributes valueForKey:@"total"];
    self.stat = [attributes valueForKeyPath:@"stat"];
    self.ls_dep_id = [attributes valueForKey:@"dep_id"];
    
    return self;
}

@end
