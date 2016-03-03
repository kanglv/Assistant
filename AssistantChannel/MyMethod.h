//
//  MyMethod.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMethod : NSObject

//清除缓存
- (void)clearCache;
//计算缓存
-(float)folderSizeAtPath:(NSString*)folderPath;
@end
