//
//  Text_exam_gradeEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/11.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Text_exam_gradeEntity.h"

@implementation Text_exam_gradeEntity

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    if (!self) {
        return nil;
        
    }
    
    self.rank_status = [attributes valueForKey:@"rank_status"];
    self.total_grade = [attributes valueForKey:@"total_grade"];
    self.right_num = [attributes valueForKey:@"right_num"];
    self.ls = [attributes valueForKey:@"ls"];
    self.grade_rank = [attributes valueForKey:@"grade_rank"];
    self.error_num = [attributes valueForKey:@"error_num"];
    
    return  self;
}

@end
