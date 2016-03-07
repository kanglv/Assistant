//
//  Efficiency_Remuneration_DetailViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EffIciency_RemunerationEntity.h"

@interface Efficiency_Remuneration_DetailViewController : ZXYBaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EffIciency_RemunerationEntity *entity;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@end
