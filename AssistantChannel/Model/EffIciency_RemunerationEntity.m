//
//  EffIciency_RemunerationEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "EffIciency_RemunerationEntity.h"

@implementation EffIciency_RemunerationEntity

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    if (!self) {
        
        return nil;
    }
    
    self.service_num = [attributes valueForKey:@"service_num"];
    self.fh_dgdd_num = [attributes valueForKey:@"fh_dgdd_num"];
    self.card_total = [attributes valueForKey:@"card_total"];
    self.card_fee = [attributes valueForKey:@"card_fee"];
    
    self.jl_hz_fee = [attributes valueForKey:@"jl_hz_fee"];
    self.ref_id = [attributes valueForKey:@"id"];
    self.fh_qqt_num = [attributes valueForKey:@"fh_qqt_num"];
    self.zz_kd_num = [attributes valueForKey:@"zz_kd_num"];
    
    self.phone_tc_fee = [attributes valueForKey:@"phone_tc_fee"];
    self.reduce_fee = [attributes valueForKey:@"reduce_fee"];
    self.zz_sx_fee = [attributes valueForKey:@"zz_sx_fee"];
    self.jl_total = [attributes valueForKey:@"jl_total"];
    
    self.jl_td_num = [attributes valueForKey:@"jl_td_num"];
    self.jl_qt_num = [attributes valueForKey:@"jl_qt_num"];
    self.fh_total = [attributes valueForKey:@"fh_total"];
    self.zz_total = [attributes valueForKey:@"zz_total"];
    self.terminal_total = [attributes valueForKey:@"terminal_total"];
    
    self.other_num = [attributes valueForKey:@"other_num"];
    self.contract_fee = [attributes valueForKey:@"contract_fee"];
    self.zz_kd_fee = [attributes valueForKey:@"zz_kd_fee"];
    self.phone_total = [attributes valueForKey:@"phone_total"];
    
    self.stat_time = [attributes valueForKey:@"stat_time"];
    self.phone_kzcz_fee = [attributes valueForKey:@"phone_kzcz_fee"];
    self.jl_td_fee = [attributes valueForKey:@"jl_td_fee"];
    self.phone_kzcz_num = [attributes valueForKey:@"phone_kzcz_num"];
    
    self.jl_qt_fee = [attributes valueForKey:@"jl_qt_fee"];
    self.phone_tc_num = [attributes valueForKey:@"phone_tc_num"];
    self.fh_szx_fee = [attributes valueForKey:@"fh_szx_fee"];
    self.other_fee = [attributes valueForKey:@"other_fee"];
    
    self.contract_num = [attributes valueForKey:@"contract_num"];
    self.jl_hz_num = [attributes valueForKey:@"jl_hz_num"];
    self.stat_month = [attributes valueForKey:@"stat_month"];
    self.fh_szx_num = [attributes valueForKey:@"fh_szx_num"];
    
    
    self.terminal_4g_num = [attributes valueForKey:@"terminal_4g_num"];
    self.terminal_ls_num = [attributes valueForKey:@"terminal_ls_num"];
    self.fh_dgdd_fee = [attributes valueForKey:@"fh_dgdd_fee"];
    self.zz_sx_num = [attributes valueForKey:@"zz_sx_num"];
    
    self.service_fee = [attributes valueForKey:@"service_fee"];
    self.phone_dshf_num = [attributes valueForKey:@"phone_dshf_num"];
    self.terminal_qt_num = [attributes valueForKey:@"terminal_qt_num"];
    self.phone_dshf_fee = [attributes valueForKey:@"phone_dshf_fee"];
    
    self.terminal_4g_fee = [attributes valueForKey:@"terminal_4g_fee"];
    self.terminal_ls_fee = [attributes valueForKey:@"terminal_ls_fee"];
    self.fh_qqt_fee = [attributes valueForKey:@"fh_qqt_fee"];
    self.total_fee = [attributes valueForKey:@"total_fee"];
    
    self.terminal_qt_fee = [attributes valueForKey:@"terminal_qt_fee"];
    
    return self;
    
}


@end
