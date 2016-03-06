//
//  Information_baseViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"


@interface Information_baseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,tableViewHeaderDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *cateArr;
    tableViewHeader *tableViewheader;
    
}

@property (strong, nonatomic) UITableView *tableview;
@property(nonatomic, assign) int currentPage;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

@property (nonatomic, strong) NSMutableArray *ArrayDepartment;
@property (nonatomic, strong) NSMutableArray *ArrayDepartmentTemp;


- (instancetype)initWithFrame:(CGRect)frame;
- (void)getData:(int)type andWithPage:(int)page andWithPageSize:(int)pagesize;
@end
