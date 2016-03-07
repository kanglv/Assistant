//
//  Remuneration_Entity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Remuneration_Entity : NSObject

/*
 
 page：当前第几页
 channel_id：渠道id
 num：记录条数
 fh_total：放号酬金总计
 card_fee：充值卡业务酬金
 service_fee：服务酬金
 phone_total：话费服务酬金
 zz_sx_fee：数信业务酬金
 zz_kd_fee：宽带业务酬金
 zz_total：增值业务酬金总计
 contract_fee：合作酬金
 jl_total：激励酬金
 terminal_4g_fee：4G终端酬金
 terminal_total：终端酬金
 reduce_fee：扣减金额
 other_fee：其它扣减酬金
 total_fee：酬金总计
 
 */
@property (nonatomic, copy) NSString *terminal_total;
@property (nonatomic, copy) NSString *dep_name;
@property (nonatomic, copy) NSString *fh_total;
@property (nonatomic, copy) NSString *card_fee;
@property (nonatomic, copy) NSString *terminal_4g_fee;
@property (nonatomic, copy) NSString *reduce_fee;
@property (nonatomic, copy) NSString *zz_sx_fee;
@property (nonatomic, copy) NSString *other_fee;
@property (nonatomic, copy) NSString *total_fee;
@property (nonatomic, copy) NSString *phone_total;
@property (nonatomic, copy) NSString *channel_id;
@property (nonatomic, copy) NSString *zz_kd_fee;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *stat_month;
@property (nonatomic, copy) NSString *ref_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *zz_total;
@property (nonatomic, copy) NSString *jl_total;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *service_fee;
@property (nonatomic, copy) NSString *contract_fee;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
