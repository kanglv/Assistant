//
//  information_manager_listViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"

@interface information_manager_listViewController : ZXYBaseViewController<UITextFieldDelegate>
{
    tableViewHeader *tableViewheader;
    MJRefreshHeaderView *_header;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

@property (nonatomic, strong) NSMutableArray *arrayContact_1;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp_1;

@property (nonatomic, copy) NSString *dep_id;
@end
