//
//  PracticeViewController.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"
@interface PracticeViewController : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    MBProgressHUD *testHUD;
    MJRefreshHeaderView *_testHeader;
    
    NSMutableArray *cateArr;
    tableViewHeader *tableViewheader;
}
@property (strong, nonatomic) UITableView *table;
@property(nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;
@property (nonatomic, strong) UIView *titleview;

@end
