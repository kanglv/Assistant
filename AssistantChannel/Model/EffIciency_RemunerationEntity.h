//
//  EffIciency_RemunerationEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  strongright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EffIciency_RemunerationEntity : NSObject

@property (nonatomic, strong) NSNumber *service_num;
@property (nonatomic, strong) NSNumber *fh_dgdd_num;
@property (nonatomic, strong) NSNumber *card_total;
@property (nonatomic, strong) NSNumber *card_fee;

@property (nonatomic, strong) NSNumber *jl_hz_fee;
@property (nonatomic, copy) NSString *ref_id;
@property (nonatomic, strong) NSNumber *fh_qqt_num;
@property (nonatomic, strong) NSNumber *zz_kd_num;

@property (nonatomic, strong) NSNumber *phone_tc_fee;
@property (nonatomic, strong) NSNumber *reduce_fee;
@property (nonatomic, strong) NSNumber *zz_sx_fee;
@property (nonatomic, strong) NSNumber *jl_total;

@property (nonatomic, strong) NSNumber *jl_td_num;
@property (nonatomic, strong) NSNumber *jl_qt_num;
@property (nonatomic, strong) NSNumber *fh_total;
@property (nonatomic, strong) NSNumber *zz_total;
@property (nonatomic, strong) NSNumber *terminal_total;

@property (nonatomic, strong) NSNumber *other_num;
@property (nonatomic, strong) NSNumber *contract_fee;
@property (nonatomic, strong) NSNumber *zz_kd_fee;
@property (nonatomic, strong) NSNumber *phone_total;

@property (nonatomic, copy) NSString *stat_time;
@property (nonatomic, strong) NSNumber *phone_kzcz_fee;
@property (nonatomic, strong)NSNumber  *jl_td_fee;
@property (nonatomic, strong) NSNumber *phone_kzcz_num;

@property (nonatomic, strong) NSNumber *jl_qt_fee;
@property (nonatomic, strong) NSNumber *phone_tc_num;
@property (nonatomic, strong) NSNumber *fh_szx_fee;
@property (nonatomic, strong) NSNumber *other_fee;

@property (nonatomic, strong) NSNumber *contract_num;
@property (nonatomic, strong) NSNumber *jl_hz_num;
@property (nonatomic, copy) NSString *stat_month;
@property (nonatomic, strong) NSNumber *fh_szx_num;

@property (nonatomic, strong) NSNumber *terminal_4g_num;
@property (nonatomic, strong) NSNumber *terminal_ls_num;
@property (nonatomic, strong) NSNumber *fh_dgdd_fee;
@property (nonatomic, strong) NSNumber *zz_sx_num;

@property (nonatomic, strong) NSNumber *service_fee;
@property (nonatomic, strong) NSNumber *phone_dshf_num;
@property (nonatomic, strong) NSNumber *terminal_qt_num;
@property (nonatomic, strong) NSNumber *phone_dshf_fee;

@property (nonatomic, strong) NSNumber *terminal_4g_fee;
@property (nonatomic, strong) NSNumber *terminal_ls_fee;
@property (nonatomic, strong) NSNumber *fh_qqt_fee;
@property (nonatomic, strong) NSNumber *total_fee;

@property (nonatomic, strong) NSNumber *terminal_qt_fee;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;


@end
