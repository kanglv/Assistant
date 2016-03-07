//
//  Remuneration_DetailViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Remuneration_DetailViewController : ZXYBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (strong, nonatomic) NSMutableArray *arrayContact;
@property (strong, nonatomic) NSString *channel_id;

@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;


@end
