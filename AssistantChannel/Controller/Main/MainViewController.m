//
//  MainViewController.m
//  AssistantChannel
//
//  Created by 胡礼节 on 16/2/27.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MainViewController.h"
#import "Text_exam_listEntity.h"
#import "Text_exam_gradeEntity.h"

@interface MainViewController ()
{
    UserEntity *userEntity;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];
    
    //学习园地，练习
    //    [self getExam_list:@"1" andWithFrom_time:nil andWithToTime:nil];
    
    //学习园地，考试中心
    //    [self getExam_list:@"0" andWithFrom_time:nil andWithToTime:nil];
    
    //学习园地，获取考试结果:传人考试ID
    [self getExam_list:@"28"];
}



- (void)getExam_list:(NSString*)tflag andWithFrom_time:(NSString *)from_time andWithToTime:(NSString *)to_time{
    
    CommonService *service = [[CommonService alloc] init];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"exam_list",@"a",
                           userEntity.sn,@"sn",
                           userEntity.dep_id,@"dep_id",
                           @"0",@"answer_status",
                           tflag,@"tflag",
                           @"0",@"page",
                           @"20",@"page_size",
                           from_time,@"from_time",
                           to_time,@"to_time",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSNumber *total = [dic valueForKeyPath:@"total"];
            NSString *totalState = [NSString stringWithFormat:@"%d", [total intValue]];
            
            [self.arrayContact removeAllObjects];
            [self.arrayCustomerTemp removeAllObjects];
            
            if ([totalState isEqualToString:@"0"]) {
                
            }else{
                NSMutableArray *typesArr = [dic objectForKey:@"ls"];
                for (NSDictionary* attributes in typesArr) {
                    
                    Text_exam_listEntity *entity = [[Text_exam_listEntity alloc] init];
                    entity = [entity initWithAttributes:attributes];
                    [self.arrayContact addObject:entity];
                    [self.arrayCustomerTemp addObject:entity];
                    
                }
            }
            
            
        }else{
            
        }
    } Failed:^(int errorCode, NSString *message) {
        
        
    }];
    
}

- (void)getExam_list:(NSString*)test_id{
    
    CommonService *service = [[CommonService alloc] init];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"exam_grade",@"a",
                           userEntity.sn,@"sn",
                           test_id,@"id",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            
            [self.arrayContact removeAllObjects];
            
            Text_exam_gradeEntity *entity = [[Text_exam_gradeEntity alloc] init];
            entity = [entity initWithAttributes:dic];
            [self.arrayContact addObject:entity];
            
            
        }else{
            
        }
    } Failed:^(int errorCode, NSString *message) {
        
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
