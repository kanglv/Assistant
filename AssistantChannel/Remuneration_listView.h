//
//  Remuneration_listView.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/1.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"
#import "XYStartEndDatePicker.h"

@interface Remuneration_listView : UIView<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate,XYStartEndDatePickerDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    tableViewHeader *tableViewheader;
    
}

@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

@end
