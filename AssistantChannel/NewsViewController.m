//
//  NewsViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "NewsContentViewController.h"

@interface NewsViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@end


@implementation NewsViewController

@synthesize mutableArryNews,mutableArrys;
@synthesize strSearchKey;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mutableArryNews = [[NSMutableArray alloc]init];
    mutableArrys = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = @"公告";
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self addRefreshView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self reloadNewsData];
    
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    [self.mutableArryNews removeAllObjects];
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [weakSelf loadData];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [mutableArryNews count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *couponTableViewCellIdentifier=@"NewsTableViewCell";
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:couponTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:couponTableViewCellIdentifier owner:nil options:nil] firstObject];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NewsModel *entity = [mutableArryNews objectAtIndex:indexPath.row];

    cell.labelTitle.text = entity.title;

    if ([entity.is_visited intValue] == 0) {
        cell.labelType.text = @"未读";
    }else if ([entity.is_visited intValue] == 1){
        cell.labelType.text = @"已读";
    }

    cell.labelDate.text = [dateChange NsstringChangeDate:entity.create_time];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void) loadData
{

    UserEntity *userEntity = [UserEntity sharedInstance];
    CommonService *service = [[CommonService alloc]init];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"list", @"a",
                           @"notice", @"m",
                           userEntity.dep_id, @"dep_id",
                           userEntity.roles, @"role",
                           @"", @"title",
                           @"0", @"page",
                           @"20", @"page_size",
                           userEntity.sn,@"sn",
                           nil];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSMutableArray *array = [dic objectForKey:@"ls"];
            
            NSNumber *total = [dic valueForKeyPath:@"total"];
            NSString *strTotal = [NSString stringWithFormat:@"%d", [total intValue]];
            if ([strTotal isEqualToString:@"0"]) {
                
                
            }else{
                [mutableArryNews removeAllObjects];
                
                for (NSDictionary* attributes in array) {
                    NewsModel *entity = [[NewsModel alloc] init];
                    entity = [entity initWithAttributes:attributes];
                    [mutableArryNews addObject:entity];
                    [mutableArrys addObject:entity];
                }
                [self.tableView reloadData];
            }
           
        }else{
            
        }
        
        [HUD hide:YES];
        [_header endRefreshing];
    } Failed:^(int errorCode, NSString *message) {
        [_header endRefreshing];
        [HUD hide:YES];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsContentViewController *vc = [[NewsContentViewController alloc]init];
    NewsModel *entity = [self.mutableArryNews objectAtIndex:indexPath.row];
    vc.url = entity.url;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)reloadNewsData{
    
    [HUD hide:YES];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    [mutableArryNews removeAllObjects];
    HUD.labelText = @"努力加载中...";
    [self loadData];

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [searchBar resignFirstResponder];
    strSearchKey = searchBar.text;
    
    [mutableArryNews removeAllObjects];
    if (strSearchKey == nil || strSearchKey.length == 0) {
        for (int i = 0; i < [mutableArrys count]; i++) {
            NewsModel *entity = [mutableArrys objectAtIndex:i];
            [mutableArryNews addObject:entity];
        }
        [self.tableView reloadData];
        return;
    }
    
    for (int i = 0; i < [mutableArrys count]; i++) {
        NewsModel *entity = [mutableArrys objectAtIndex:i];
        
        NSRange range = [entity.title rangeOfString:strSearchKey];//判断字符串是否包含
        
        if (range.length > 0)//包含
        {
            [mutableArryNews addObject:entity];
        } else//不包含
        {
        }
    }
    
    [self.tableView reloadData];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.searchBar resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
