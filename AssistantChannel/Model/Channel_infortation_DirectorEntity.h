//
//  Channel_infortation_DirectorEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel_infortation_DirectorEntity : NSObject

@property (nonatomic, strong) NSNumber *is_manage;
@property (nonatomic, strong) NSArray *head;
@property (nonatomic, copy) NSString *dep_id;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSArray *stat;
@property (nonatomic, copy) NSString *ls_dep_id;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (instancetype)initWithAarray:(NSDictionary *)attributes;

@end
