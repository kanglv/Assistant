//
//  UserEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    dep_id：用户所属机构id
    dep_code：用户所属机构编码
    dep_name：部门名称
    role_name：用户角色文字描述
    sn为已登录用户凭证，需要客户端保存并在后续调用接口时传递该参数
 
 角色，roles:
 11-主管登录，
 12-渠道经理登录，
 13-渠道商登录，
*/

@interface UserEntity : NSObject

@property (nonatomic,strong) NSString *success;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *dep_id;
@property (nonatomic,strong) NSString *dep_code;
@property (nonatomic,strong) NSString *roles;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *sn;
@property(nonatomic, copy) NSString *role_name;
@property(nonatomic, copy) NSString *dep_name; 


+ (id)sharedInstance;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
- (void) deepCopy:(UserEntity *)sender;
- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;


@end
