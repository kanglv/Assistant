//
//  Operate_manage_listViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"
#import "XYStartEndDatePicker.h"

@interface Operate_manage_listViewController : ZXYBaseViewController<XYStartEndDatePickerDelegate>
{
    MJRefreshHeaderView *_header;
    tableViewHeader *tableViewheader;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *arrayContact;

@property (strong, nonatomic) NSString *ref_id;

@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;
@property(nonatomic, copy) NSString *startTime_1;
@property(nonatomic, copy) NSString *endTime_1;

@end
