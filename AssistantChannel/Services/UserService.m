//
//  UserService.m
//  MobileAssistant
//
//  Created by 房 国生 on 14-9-13.
//  Copyright (c) 2014年 avatek. All rights reserved.
//

#import "UserService.h"
#import "AFNetworking.h"
#import "UserEntity.h"

@implementation UserService

- (void)loginWithPassword:(NSDictionary *)param Successed:(void(^)(UserEntity *entity)) successed Failed:(void(^)(int errorCode ,NSString *message))failed
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[[NSURL alloc] initWithString:BASEURL]];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding = AFFormURLParameterEncoding;
    
    [client postPath:PATH
         parameters:param
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError *e;
                NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&e];
                
                UserEntity *entity = [[UserEntity alloc] init];
                entity = [entity initWithAttributes:resultDictionary];
                UserEntity *userEntity = [UserEntity sharedInstance];
                [userEntity deepCopy:entity];
                successed(entity);
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@"0" forKey:@"ref_type"];
                if ([entity.roles isEqualToString:@"11"]) {
          
                    [userDefaults setObject:@"0" forKey:@"ref_type"];

                }else if ([entity.roles isEqualToString:@"12"]){
             
                    [userDefaults setObject:@"1" forKey:@"ref_type"];
                }
                [userDefaults synchronize];

                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSInteger errorCode = error.code;
                NSString *errorMessage = [error localizedDescription];
                
                failed(errorCode,errorMessage);
            }];
}

@end
