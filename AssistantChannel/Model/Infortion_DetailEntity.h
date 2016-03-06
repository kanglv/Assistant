//
//  Infortion_DetailEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 nickname：负责人姓名
 mobile：负责人手机号
 signed_time：协议签订时间
 invalid_time：协议过期时间
 is_store：是否手机卖场，0-否，1-是
 */

@interface Infortion_DetailEntity : NSObject

@property (nonatomic, copy) NSString *legal_mobile;
@property (nonatomic, copy) NSString *manager_uid;
@property (nonatomic, copy) NSString *legal_man;
@property (nonatomic, copy) NSString *by_uid;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *ctype;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *last_time;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *service;
@property (nonatomic, copy) NSString *manager_mobile;
@property (nonatomic, copy) NSString *is_store;
@property (nonatomic, copy) NSString *cstar;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *informtionID;
@property (nonatomic, copy) NSString *dep_code;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *signed_time;
@property (nonatomic, copy) NSString *ctype_desc;
@property (nonatomic, copy) NSString *cstar_desc;
@property (nonatomic, copy) NSString *clevel;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *manager_nickname;
@property (nonatomic, copy) NSString *invalid_time;
@property (nonatomic, copy) NSString *dep_name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *dep_id;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
