//
//  Remuneration_Entity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Remuneration_Entity.h"

@implementation Remuneration_Entity

- (instancetype)initWithAttributes:(NSDictionary *)attributes{

    self = [super init];
    if (!self) {
    
        return nil;
    }

    self.terminal_total = [attributes valueForKey:@"terminal_total"];
    self.dep_name = [attributes valueForKey:@"dep_name"];
    self.fh_total = [attributes valueForKey:@"fh_total"];
    self.card_fee = [attributes valueForKey:@"card_fee"];
    self.terminal_4g_fee = [attributes valueForKey:@"terminal_4g_fee"];
    self.reduce_fee = [attributes valueForKey:@"reduce_fee"];
    self.zz_sx_fee = [attributes valueForKey:@"zz_sx_fee"];
    self.other_fee = [attributes valueForKey:@"other_fee"];
    self.total_fee = [attributes valueForKey:@"total_fee"];
    self.phone_total = [attributes valueForKey:@"phone_total"];
    self.channel_id = [attributes valueForKey:@"channel_id"];
    self.zz_kd_fee = [attributes valueForKey:@"zz_kd_fee"];
    self.num = [attributes valueForKey:@"num"];
    self.stat_month = [attributes valueForKey:@"stat_month"];
    self.name = [attributes valueForKey:@"name"];
    self.zz_total = [attributes valueForKey:@"zz_total"];
    self.jl_total = [attributes valueForKey:@"jl_total"];
    self.code = [attributes valueForKey:@"code"];
    self.service_fee = [attributes valueForKey:@"service_fee"];
    self.contract_fee = [attributes valueForKey:@"contract_fee"];
    
    self.ref_id = [attributes valueForKey:@"id"];
    
    return self;

}
@end
