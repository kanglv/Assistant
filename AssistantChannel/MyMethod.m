//
//  MyMethod.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyMethod.h"

@implementation MyMethod

/**
 *  deal cache caculate/clear
 */

//清除缓存
- (void)clearCache{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString*path = [paths lastObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    for (NSString *str in files) {
        NSError* error;
        NSString* path_ = [path stringByAppendingPathComponent:str];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path_]) {
                [[NSFileManager defaultManager] removeItemAtPath:path_ error:&error];
            }
        }
}

-(long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//计算缓存
-(float)folderSizeAtPath:(NSString*)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject])!=nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


@end
