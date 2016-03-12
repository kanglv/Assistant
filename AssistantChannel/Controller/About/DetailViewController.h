//
//  DetailViewController.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/12.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : ZXYBaseViewController
@property (strong , nonatomic) NSDictionary *dic;
@property (strong , nonatomic)NSString *hastitle;
@property (strong ,nonatomic)NSMutableArray *defaultAdd,*dataAdd;
@end
