//
//  Remuneration_DetailEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Remuneration_DetailEntity.h"

@implementation Remuneration_DetailEntity

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
    self.ref_id = [attributes valueForKey:@"ref_id"];
    self.fh_qqt_num = [attributes valueForKey:@"fh_qqt_num"];
    self.zz_kd_num = [attributes valueForKey:@"zz_kd_num"];
    self.phone_tc_fee = [attributes valueForKey:@"phone_tc_fee"];
    self.reduce_fee = [attributes valueForKey:@"reduce_fee"];
    self.to_time = [attributes valueForKey:@"to_time"];
    self.zz_sx_fee = [attributes valueForKey:@"zz_sx_fee"];
    self.jl_total = [attributes valueForKey:@"jl_total"];
    self.dep_id = [attributes valueForKey:@"dep_id"];
    self.jl_td_num = [attributes valueForKey:@"jl_td_num"];
    self.jl_qt_num = [attributes valueForKey:@"jl_qt_num"];
    self.num = [attributes valueForKey:@"num"];
    self.fh_total = [attributes valueForKey:@"fh_total"];
    self.zz_total = [attributes valueForKey:@"zz_total"];
    self.terminal_total = [attributes valueForKey:@"terminal_total"];
    self.other_num = [attributes valueForKey:@"other_num"];
    self.contract_fee = [attributes valueForKey:@"contract_fee"];
    self.zz_kd_fee = [attributes valueForKey:@"zz_kd_fee"];
    self.phone_total = [attributes valueForKey:@"phone_total"];
    self.from_time = [attributes valueForKey:@"from_time"];
    self.phone_kzcz_fee = [attributes valueForKey:@"phone_kzcz_fee"];
    self.jl_td_fee = [attributes valueForKey:@"jl_td_fee"];
    self.name = [attributes valueForKey:@"name"];
    self.phone_kzcz_num = [attributes valueForKey:@"phone_kzcz_num"];
    self.phone_tc_num = [attributes valueForKey:@"phone_tc_num"];
    self.jl_qt_fee = [attributes valueForKey:@"jl_qt_fee"];
    self.fh_szx_fee = [attributes valueForKey:@"fh_szx_fee"];
    self.other_fee = [attributes valueForKey:@"other_fee"];
    self.code = [attributes valueForKey:@"code"];
    self.contract_num = [attributes valueForKey:@"contract_num"];
    self.jl_hz_num = [attributes valueForKey:@"jl_hz_num"];
    self.terminal_4g_num = [attributes valueForKey:@"terminal_4g_num"];
    self.fh_szx_num = [attributes valueForKey:@"fh_szx_num"];
    self.terminal_ls_num = [attributes valueForKey:@"terminal_ls_num"];
    self.fh_dgdd_fee = [attributes valueForKey:@"fh_dgdd_fee"];
    self.service_fee = [attributes valueForKey:@"service_fee"];
    self.zz_sx_num = [attributes valueForKey:@"zz_sx_num"];
    self.dep_code = [attributes valueForKey:@"dep_code"];
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
