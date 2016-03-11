//
//  Text_exam_listEntity.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/11.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Text_exam_listEntity.h"

@implementation Text_exam_listEntity


- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    
    self = [super init];
    if (!self) {
        return nil;
        
    }
    
    self.begin_time = [attributes valueForKey:@"begin_time"];
    self.has_answer = [attributes valueForKey:@"has_answer"];
    self.seconds = [attributes valueForKey:@"seconds"];
    self.create_time = [attributes valueForKey:@"create_time"];
    self.total_grade = [attributes valueForKey:@"total_grade"];
    self.text_id = [attributes valueForKey:@"id"];
    self.dep_code = [attributes valueForKey:@"dep_code"];
    
    self.uid = [attributes valueForKey:@"uid"];
    self.num = [attributes valueForKey:@"num"];
    self.error_num = [attributes valueForKey:@"error_num"];
    self.title = [attributes valueForKey:@"title"];
    self.nickname = [attributes valueForKey:@"nickname"];
    self.right_num = [attributes valueForKey:@"right_num"];
    
    self.grade_rank = [attributes valueForKey:@"grade_rank"];
    self.answer_num = [attributes valueForKey:@"answer_num"];
    self.end_time = [attributes valueForKey:@"end_time"];
    self.tflag = [attributes valueForKey:@"tflag"];
    self.status = [attributes valueForKey:@"status"];
    self.dep_name = [attributes valueForKey:@"dep_name"];

    self.dep_id = [attributes valueForKey:@"dep_id"];

    
    
    return  self;
}


@end
