//
//  Operate_DetailViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Operate_DetailViewController : ZXYBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *level;
@property (strong, nonatomic) NSString *ref_id;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;

@property (strong, nonatomic) NSMutableArray *arrayContact;
@end
