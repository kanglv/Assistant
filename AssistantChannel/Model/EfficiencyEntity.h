//
//  EfficiencyEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EfficiencyEntity : NSObject

@property (nonatomic, copy) NSString *Efficiency_id;
@property (nonatomic, copy) NSString *net_in_total;
@property (nonatomic, copy) NSString *net_in_djzz;
@property (nonatomic, copy) NSString *net_in_tkkk;
@property (nonatomic, copy) NSString *terminal_yh;
@property (nonatomic, copy) NSString *net_in_djzf;
@property (nonatomic, copy) NSString *stat_month;
@property (nonatomic, copy) NSString *fee_total;
@property (nonatomic, copy) NSString *card_rate;
@property (nonatomic, copy) NSString *net_in_qy;
@property (nonatomic, copy) NSString *stat_time;
@property (nonatomic, copy) NSString *terminal_hyj;
@property (nonatomic, copy) NSString *terminal_total;
@property (nonatomic, copy) NSString *net_in_tczf;
@property (nonatomic, copy) NSString *terminal_lj;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;


@end
