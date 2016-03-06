//
//  Operate_DetailEntiey.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operate_DetailEntiey : NSObject

@property (nonatomic, copy) NSNumber *net_in_total;
@property (nonatomic, copy) NSString *dep_name;
@property (nonatomic, copy) NSNumber *net_in_djzz;
@property (nonatomic, copy) NSNumber *net_in_tkkk;
@property (nonatomic, copy) NSNumber *net_in_djzf;
@property (nonatomic, copy) NSNumber *ref_id;
@property (nonatomic, copy) NSNumber *fee_total;
@property (nonatomic, copy) NSNumber *num;
@property (nonatomic, copy) NSString *card_rate;
@property (nonatomic, copy) NSNumber *net_in_qy;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *terminal_hyj;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSNumber *terminal_total;
@property (nonatomic, copy) NSNumber *net_in_tczf;
@property (nonatomic, copy) NSNumber *terminal_lj;
@property (nonatomic, copy) NSNumber *terminal_yh;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
