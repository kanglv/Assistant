//
//  Operate_listEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/1.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operate_listEntity : NSObject

//@property (nonatomic, copy) NSString *to_time;
//@property (nonatomic, copy) NSString *level;
//@property (nonatomic, copy) NSString *from_time;
//@property (nonatomic, copy) NSString *ctype;
//@property (nonatomic, copy) NSString *total;
//@property (nonatomic, copy) NSString *next_level;
//@property (nonatomic, copy) NSMutableArray *ls;

@property (nonatomic, copy) NSString *net_in_total;
@property (nonatomic, copy) NSString *net_in_djzz;
@property (nonatomic, copy) NSString *net_in_tkkk;
@property (nonatomic, copy) NSString *net_in_djzf;
@property (nonatomic, copy) NSString *ref_id;
@property (nonatomic, copy) NSString *fee_total;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *card_rate;
@property (nonatomic, copy) NSString *net_in_qy;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *terminal_hyj;
@property (nonatomic, copy) NSString *terminal_total;
@property (nonatomic, copy) NSString *net_in_tczf;
@property (nonatomic, copy) NSString *terminal_lj;
@property (nonatomic, copy) NSString *terminal_yh;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
