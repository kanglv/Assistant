//
//  Text_exam_listEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/11.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 num：考试出题数量
 begin_time：考试开始时间时间戳
 end_time：考试结束时间
 seconds：考试时长，单位：秒
 has_answer：是否已经答题过，1-是，0-否
 right_num：答题正确数，has_answer=1时有效
 error_num：答题错误数
 total_grade：总分
 grade_rank： 排名
 tflag：是否考试练习，1-是，0-否
 */
@interface Text_exam_listEntity : NSObject

@property (copy, nonatomic) NSString *begin_time;
@property (copy, nonatomic) NSString *has_answer;
@property (copy, nonatomic) NSString *seconds;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *total_grade;
@property (copy, nonatomic) NSString *text_id;
@property (copy, nonatomic) NSString *dep_code;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *num;
@property (copy, nonatomic) NSString *error_num;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *right_num;
@property (copy, nonatomic) NSString *grade_rank;
@property (copy, nonatomic) NSString *answer_num;
@property (copy, nonatomic) NSString *end_time;
@property (copy, nonatomic) NSString *tflag;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *dep_name;
@property (copy, nonatomic) NSString *dep_id;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
