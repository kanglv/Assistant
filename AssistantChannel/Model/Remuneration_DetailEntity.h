//
//  Remuneration_DetailEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 card_total:卡数量
 card_fee：卡总额
 service_num:服务数量
 service_fee：服务酬金
 ref_id:渠道id
 code:编码
 total_fee:酬金总计
 fh_total:放号酬金总计
 fh_qqt_num:全球通数量
 fh_qqt_fee:全球通酬金
 fh_szx_num:神州行数量
 fh_szx_fee:神州行酬金
 fh_dgdd_num：动感地带数量
 fh_dgdd_fee:动感地带酬金
 phone_total:话费总计
 phone_tc_num:话费套餐数量
 phone_tc_fee:话费套餐酬金
 phone_kzcz_fee:空中充值酬金
 phone_kzcz_num:空中充值数量
 phone_dshf_num:代收话费数量
 phone_dshf_fee:代收话费酬金
 reduce_fee:扣减金额
 jl_total:激励酬金总计
 jl_td_num:激励TD数量
 jl_td_fee:激励TD酬金
 jl_qt_num:激励其他数量
 jl_qt_fee:激励其他酬金
 jl_hz_num:激励合作数量
 jl_hz_fee:激励合作酬金
 other_num:其他扣减数量
 other_fee:其他扣减酬金
 zz_total:增值总计
 zz_sx_num:数信业务数量
 zz_sx_fee:数信业务酬金
 zz_kd_num:增值宽带业务数量
 zz_kd_fee:增值宽带业务酬金
 contract_num:合作数量
 contract_fee:合作酬金
 terminal_total：终端服务酬金总计
 terminal_qt_num:端其他终端数量
 terminal_qt_fee:终端其他终端酬金
 terminal_4g_num:终端4g终端数量
 terminal_4g_fee:终端4g终端酬金
 terminal_ls_num:终端连锁终端数量
 terminal_ls_fee:终端连锁终端酬金
 */
@interface Remuneration_DetailEntity : NSObject

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
@property (nonatomic, copy) NSString *to_time;
@property (nonatomic, strong) NSNumber *zz_sx_fee;
@property (nonatomic, strong) NSNumber *jl_total;
@property (nonatomic, copy) NSString *dep_id;
@property (nonatomic, strong) NSNumber *jl_td_num;
@property (nonatomic, strong) NSNumber *jl_qt_num;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSNumber *fh_total;
@property (nonatomic, strong) NSNumber *zz_total;
@property (nonatomic, strong) NSNumber *terminal_total;
@property (nonatomic, strong) NSNumber *other_num;
@property (nonatomic, strong) NSNumber *contract_fee;
@property (nonatomic, strong) NSNumber *zz_kd_fee;
@property (nonatomic, strong) NSNumber *phone_total;
@property (nonatomic, copy) NSString *from_time;
@property (nonatomic, strong) NSNumber *phone_kzcz_fee;
@property (nonatomic, strong) NSNumber *jl_td_fee;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *phone_kzcz_num;
@property (nonatomic, strong) NSNumber *phone_tc_num;
@property (nonatomic, strong) NSNumber *jl_qt_fee;
@property (nonatomic, strong) NSNumber *fh_szx_fee;
@property (nonatomic, strong) NSNumber *other_fee;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSNumber *contract_num;
@property (nonatomic, strong) NSNumber *jl_hz_num;
@property (nonatomic, strong) NSNumber *terminal_4g_num;
@property (nonatomic, strong) NSNumber *fh_szx_num;
@property (nonatomic, strong) NSNumber *terminal_ls_num;
@property (nonatomic, strong) NSNumber *fh_dgdd_fee;
@property (nonatomic, strong) NSNumber *service_fee;
@property (nonatomic, strong) NSNumber *zz_sx_num;
@property (nonatomic, copy) NSString *dep_code;
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
