//
//  Infortion_DetailEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Infortion_DetailEntity.h"

@implementation Infortion_DetailEntity


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
 
    self.legal_mobile = [attributes valueForKeyPath:@"legal_mobile"];
    self.manager_uid = [attributes valueForKeyPath:@"manager_uid"];
    self.legal_man = [attributes valueForKeyPath:@"legal_man"];
    self.by_uid = [attributes valueForKeyPath:@"by_uid"];
    self.mobile = [attributes valueForKeyPath:@"mobile"];
    self.region = [attributes valueForKeyPath:@"region"];
    self.ctype = [attributes valueForKeyPath:@"ctype"];
    self.name = [attributes valueForKeyPath:@"name"];
    self.img = [attributes valueForKeyPath:@"img"];
    self.last_time = [attributes valueForKeyPath:@"last_time"];
    self.lng = [attributes valueForKeyPath:@"lng"];
    self.service = [attributes valueForKeyPath:@"service"];
    self.manager_mobile = [attributes valueForKeyPath:@"manager_mobile"];
    self.is_store = [attributes valueForKeyPath:@"is_store"];
    self.cstar = [attributes valueForKeyPath:@"cstar"];
    self.create_time = [attributes valueForKeyPath:@"create_time"];
    self.informtionID = [attributes valueForKeyPath:@"informtionID"];
    self.dep_code = [attributes valueForKeyPath:@"dep_code"];
    self.address = [attributes valueForKeyPath:@"address"];
    self.uid = [attributes valueForKeyPath:@"uid"];
    self.signed_time = [attributes valueForKeyPath:@"signed_time"];
    self.ctype_desc = [attributes valueForKeyPath:@"ctype_desc"];
    self.cstar_desc = [attributes valueForKeyPath:@"cstar_desc"];
    self.clevel = [attributes valueForKeyPath:@"clevel"];
    self.lat = [attributes valueForKeyPath:@"lat"];
    self.code = [attributes valueForKeyPath:@"code"];
    self.nickname = [attributes valueForKeyPath:@"nickname"];
    self.manager_nickname = [attributes valueForKeyPath:@"manager_nickname"];
    self.invalid_time = [attributes valueForKeyPath:@"invalid_time"];
    self.dep_name = [attributes valueForKeyPath:@"dep_name"];
    self.status = [attributes valueForKeyPath:@"status"];
    self.dep_id = [attributes valueForKeyPath:@"dep_id"];
    
    return self;
}
@end
