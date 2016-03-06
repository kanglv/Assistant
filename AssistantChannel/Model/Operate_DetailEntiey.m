//
//  Operate_DetailEntiey.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Operate_DetailEntiey.h"

@implementation Operate_DetailEntiey

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.net_in_total = [attributes valueForKey:@"net_in_total"];
    self.net_in_djzz = [attributes valueForKey:@"net_in_djzz"];
    self.net_in_tkkk = [attributes valueForKey:@"net_in_tkkk"];
    self.net_in_djzf = [attributes valueForKey:@"net_in_djzf"];
    self.ref_id = [attributes valueForKey:@"ref_id"];
    self.fee_total = [attributes valueForKey:@"fee_total"];
    self.num = [attributes valueForKey:@"num"];
    self.card_rate = [attributes valueForKey:@"card_rate"];
    self.net_in_qy = [attributes valueForKey:@"net_in_qy"];
    self.name = [attributes valueForKey:@"name"];
    self.terminal_hyj = [attributes valueForKey:@"terminal_hyj"];
    self.terminal_total = [attributes valueForKey:@"terminal_total"];
    self.net_in_tczf = [attributes valueForKey:@"net_in_tczf"];
    self.terminal_lj = [attributes valueForKey:@"terminal_lj"];
    self.code = [attributes valueForKey:@"code"];
    self.terminal_yh = [attributes valueForKey:@"terminal_yh"];
    self.dep_name = [attributes valueForKey:@"dep_name"];
    
    return self;
}

@end
