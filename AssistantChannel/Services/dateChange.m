//
//  dateChange.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "dateChange.h"

@implementation dateChange

+ (NSString *)NsstringChangeDate:(NSString *)nsstring{
    
    
    NSString *time = [NSString stringWithFormat:@"%@",nsstring];
    
    NSInteger num = [time integerValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+ (NSString *)NsstringChangeYuan:(NSString *)nsstring{
    
    double yuan = [nsstring doubleValue];
    NSString *str = [NSString stringWithFormat:@"%0.1f",yuan];
    
    return str;
}



@end
