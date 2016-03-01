//
//  CommonService.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonService : NSObject

- (void)getNetWorkData:(NSDictionary *)param Successed:(void(^)(id entity)) successed Failed:(void(^)(int errorCode ,NSString *message))failed;

@end
