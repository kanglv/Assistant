//
//  Information_detaileViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Information_detaileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *cateArr;
    
}
@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) UIImageView *titleImg;

@property (nonatomic, strong) NSMutableArray *arrayContact;
@property (nonatomic, strong) NSMutableArray *arrayCustomerTemp;

- (instancetype)initWithFrame:(CGRect)frame;

@end
