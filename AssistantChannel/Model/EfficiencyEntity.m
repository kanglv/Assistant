//
//  EfficiencyEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "EfficiencyEntity.h"

@implementation EfficiencyEntity

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    if (!self) {
        
        return nil;
    }
    
    self.Efficiency_id = [attributes valueForKey:@"Efficiency_id"];
    self.net_in_total = [attributes valueForKey:@"net_in_total"];
    self.net_in_djzz = [attributes valueForKey:@"v"];
    self.net_in_tkkk = [attributes valueForKey:@"net_in_tkkk"];
    self.terminal_yh = [attributes valueForKey:@"terminal_yh"];
    self.net_in_djzf = [attributes valueForKey:@"net_in_djzf"];
    self.stat_month = [attributes valueForKey:@"stat_month"];
    self.fee_total = [attributes valueForKey:@"fee_total"];
    self.card_rate = [attributes valueForKey:@"card_rate"];
    self.net_in_qy = [attributes valueForKey:@"net_in_qy"];
    self.stat_time = [attributes valueForKey:@"stat_time"];
    self.terminal_hyj = [attributes valueForKey:@"terminal_hyj"];
    self.terminal_total = [attributes valueForKey:@"terminal_total"];
    self.net_in_tczf = [attributes valueForKey:@"net_in_tczf"];
    self.terminal_lj = [attributes valueForKey:@"terminal_lj"];
    
    return self;
    
}

@end
