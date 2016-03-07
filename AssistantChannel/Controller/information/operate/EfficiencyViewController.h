//
//  EfficiencyViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"
#import "XYStartEndDatePicker.h"

@interface EfficiencyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate,XYStartEndDatePickerDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    tableViewHeader *tableViewheader;
    
}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *titleview;

@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;
@property(nonatomic, copy) NSString *startTime_1;
@property(nonatomic, copy) NSString *endTime_1;

@property (nonatomic, strong) NSMutableArray *arrayContact;
- (instancetype)initWithFrame:(CGRect)frame;

@end
