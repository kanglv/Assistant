//
//  NewsViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property (nonatomic, strong) NSMutableArray *mutableArryNews;
@property (nonatomic, strong) NSMutableArray *mutableArrys;
@property (nonatomic, strong) NSString *strSearchKey;

- (void) loadData;
@end
