//
//  Information_baseView.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"


@interface Information_baseView : UIView<UITableViewDataSource,UITableViewDelegate,tableViewHeaderDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
   
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
    NSMutableArray *cateArr;
    tableViewHeader *tableViewheader;
    
}

@property (strong, nonatomic) UITableView *tableView;

@property(nonatomic, assign) int currentPage;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

- (void)typesData;
@end
