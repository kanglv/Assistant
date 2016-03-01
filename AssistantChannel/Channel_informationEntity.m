//
//  Channel_informationEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Channel_informationEntity.h"

@implementation Channel_informationEntity


- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
 
    self.infomationID = [attributes valueForKeyPath:@"id"];
    self.name = [attributes valueForKeyPath:@"name"];
    self.uid = [attributes valueForKeyPath:@"uid"];
    self.nickname = [attributes valueForKey:@"nickname"];
    self.mobile = [attributes valueForKeyPath:@"mobile"];
    self.dep_name = [attributes valueForKeyPath:@"dep_name"];
    self.ctype = [attributes valueForKey:@"ctype"];
    self.last_time = [attributes valueForKeyPath:@"last_time"];
    self.manager_uid = [attributes valueForKeyPath:@"manager_uid"];
    self.manager_name = [attributes valueForKey:@"manager_name"];
    self.dep_id = [attributes valueForKeyPath:@"dep_id"];
    self.manager_mobile = [attributes valueForKey:@"manager_mobile"];
    self.code = [attributes valueForKey:@"code"];
    self.cstar = [attributes valueForKeyPath:@"cstar"];
    self.address = [attributes valueForKey:@"address"];
    
    return self;
}


@end
