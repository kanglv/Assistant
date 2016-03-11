//
//  TestViewController.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"
@interface TestViewController : UIViewController<tableViewHeaderDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *cateArr;
    tableViewHeader *tableViewheader;
}
@property (strong, nonatomic) UITableView *tableview;
@property(nonatomic, assign) int currentPage;

@end