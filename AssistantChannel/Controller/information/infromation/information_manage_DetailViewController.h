//
//  information_manage_DetailViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableViewHeader.h"

@interface information_manage_DetailViewController : ZXYBaseViewController<tableViewHeaderDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *cateArr;
    tableViewHeader *tableViewheader;
    
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, assign) int currentPage;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

@property (nonatomic, copy) NSString *dep_id;
@property (nonatomic, copy) NSString *manage_dep_id;

@property (nonatomic, copy) NSString *name;
@end
