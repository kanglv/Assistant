//
//  information_DetailViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/1.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface information_DetailViewController : ZXYBaseViewController

@property (strong, nonatomic)NSString *infomationID;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *arrayContact;

@property (assign, nonatomic) int type;


@end
