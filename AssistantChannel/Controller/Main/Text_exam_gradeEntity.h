//
//  Text_exam_gradeEntity.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/11.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 right_num：答题正确个数
 error_num：答题错误个数
 total_grade：总得分
 grade_rank：成绩排名
 rank_status：排名状态，0-临时排名，1-最终排名
 ls：问题列表，包括答案answer、用户的选项val和结果is_right，
 如果考试还未结束则ls为空数组
 
 */

@interface Text_exam_gradeEntity : NSObject

@property (copy, nonatomic) NSString *rank_status;
@property (copy, nonatomic) NSString *total_grade;
@property (copy, nonatomic) NSString *right_num;
@property (strong, nonatomic) NSArray *ls;
@property (copy, nonatomic) NSString *grade_rank;
@property (copy, nonatomic) NSString *error_num;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
