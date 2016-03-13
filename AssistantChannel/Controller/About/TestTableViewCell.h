//
//  TestTableViewCell.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/13.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestSubTableViewCell.h"
#import "DetailTableViewCell.h"
@interface TestTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (strong , nonatomic)NSMutableDictionary *dic;
@property (strong , nonatomic)UITableView *table;
@property int index ;

@end
