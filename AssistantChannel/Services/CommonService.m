//
//  CommonService.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "CommonService.h"
#import "AFNetworking.h"

@implementation CommonService

- (void)getNetWorkData:(NSDictionary *)param Successed:(void(^)(id entity)) successed Failed:(void(^)(int errorCode ,NSString *message))failed
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[[NSURL alloc] initWithString:BASEURL]];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    client.parameterEncoding = AFFormURLParameterEncoding;
    
    [client postPath:PATH
          parameters:param
             success:^(AFHTTPRequestOperation *operation, id responseObject) {

                 
                 NSError *e;
                 NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&e];
                 
                 successed(resultDictionary);
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSInteger errorCode = error.code;
                 NSString *errorMessage = [error localizedDescription];
                 
                 failed(errorCode,errorMessage);
             }];
}

@end
