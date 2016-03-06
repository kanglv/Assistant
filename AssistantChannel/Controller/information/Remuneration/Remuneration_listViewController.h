//
//  Remuneration_listViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"
#import "XYStartEndDatePicker.h"

@interface Remuneration_listViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate,XYStartEndDatePickerDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    tableViewHeader *tableViewheader;
    
}

@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;
@property(nonatomic, copy) NSString *startTime_1;
@property(nonatomic, copy) NSString *endTime_1;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)getData:(NSString *)from_time andWithTime:(NSString *)to_time;

@end
