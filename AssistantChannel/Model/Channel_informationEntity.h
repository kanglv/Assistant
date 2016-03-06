//
//  Channel_informationEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 uid：渠道商uid
 name:渠道名称,
 nickname:渠道商昵称
 mobile": 渠道商手机号
 dep_name:机构名
 ctype:渠道子类型
 "last_time":时间,
 manager_uid":"12",
 manager_name:渠道经理名
 manager_mobile":渠道经理手机号
 code:
 address:地址
 cstar:
 */
@interface Channel_informationEntity : NSObject

@property (nonatomic, copy) NSString *infomationID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *dep_id;
@property (nonatomic, copy) NSString *dep_name;
@property (nonatomic, copy) NSString *ctype;
@property (nonatomic, copy) NSString *last_time;
@property (nonatomic, copy) NSString *manager_uid;
@property (nonatomic, copy) NSString *manager_name;
@property (nonatomic, copy) NSString *manager_mobile;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *cstar;
@property (nonatomic, copy) NSString *address;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;


@end
