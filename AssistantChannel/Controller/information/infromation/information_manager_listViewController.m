//
//  information_manager_listViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "information_manager_listViewController.h"
#import "Channel_infortation_DirectorTableViewCell.h"
#import "Channel_infortation_DirectorEntity.h"
#import "Channel_infortation_DirectorTableViewCell.h"
#import "information_manage_DetailViewController.h"

@interface information_manager_listViewController ()
{
    Channel_infortation_DirectorTableViewCell *cell;
}
@end

@implementation information_manager_listViewController

- (void)dealloc
{
    [_header free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:NO animated:YES];
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"渠道经理列表";
    
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];
    self.arrayContact_1 = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp_1 = [[NSMutableArray alloc]init];
    
    [self getData];
    
    [self reloadTableViewHeader];
    
    [self addRefreshView];
}

#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:YES animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [weakSelf getData];
    };
    
}

- (void)reloadTableViewHeader
{
    
        
    tableViewheader = [[tableViewHeader alloc] initWithFrameanSearch:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
    tableViewheader.searchText.delegate = self;
    self.tableView.tableHeaderView = tableViewheader;
    
    [tableViewheader.searchBtn addTarget:self action:@selector(seachBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.arrayContact count] + 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"Channel_infortation_DirectorTableViewCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
    }

    if (indexPath.row == 0) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
        cell.departmentLabel.text = @"渠道经理";
        cell.total_outletsLabel.text = @"网点总数";
        cell.Self_OfficeLabel.text = @"自营厅";
        cell.Social_channelsLabel.text = @"社会渠道";

    }else{
        Channel_infortation_DirectorEntity *entity = [self.arrayContact objectAtIndex:indexPath.row - 1];
        
        cell.departmentLabel.text = entity.title;
        cell.total_outletsLabel.text = [NSString stringWithFormat:@"%@",entity.total];
        cell.Self_OfficeLabel.text = [NSString stringWithFormat:@"%@",[entity.stat firstObject]];
        cell.Social_channelsLabel.text = [NSString stringWithFormat:@"%@",[entity.stat lastObject]];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 || indexPath.row == self.arrayContact.count) {
        
       
    }else{
        Channel_infortation_DirectorEntity *entity = [self.arrayContact objectAtIndex:indexPath.row - 1];
        
        information_manage_DetailViewController *vc = [[information_manage_DetailViewController alloc]init];

        vc.dep_id = entity.ls_dep_id;
        vc.manage_dep_id = self.dep_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self searchQuDao:textField.text];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tableViewheader.searchText resignFirstResponder];
}

- (void)seachBtnClick{
    
    [tableViewheader.searchText resignFirstResponder];
    [self searchQuDao:tableViewheader.searchText.text];
}

- (void)searchQuDao:(NSString*)name{
    
    
    [self.arrayContact removeAllObjects];
    if (name == nil || name.length == 0) {
        for (int i = 0; i < [self.arrayContact_1 count]; i++) {
            Channel_infortation_DirectorEntity *entity = [self.arrayContact_1 objectAtIndex:i];
            [self.arrayContact addObject:entity];
        }
        [self.tableView reloadData];
        return;
    }
    
    for (int i = 0; i < [self.arrayContact_1 count]; i++) {
        Channel_infortation_DirectorEntity *entity = [self.arrayContact_1 objectAtIndex:i];
        
        NSRange range = [entity.title rangeOfString:name];//判断字符串是否包含
        
        if (range.length > 0)//包含
        {
            [self.arrayContact addObject:entity];
        } else//不包含
        {
        }
    }
    
    [self.tableView reloadData];
}

- (void)getData{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"stat",@"a",
                           userEntity.sn,@"sn",
                           self.dep_id,@"dep_id",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            
            [self.arrayContact removeAllObjects];
            
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            
            Channel_infortation_DirectorEntity *entity = [[Channel_infortation_DirectorEntity alloc] init];
            
            entity = [entity initWithAttributes:dic];
            
            [self.arrayCustomerTemp addObject:entity];
            [self.arrayCustomerTemp_1 addObject:entity];
            
            NSMutableArray *typesArr = [dic objectForKey:@"ls"];
            for (NSDictionary* attributes in typesArr) {
    
                Channel_infortation_DirectorEntity *entity = [[Channel_infortation_DirectorEntity alloc] init];
                
                entity = [entity initWithAarray:attributes];
                [self.arrayContact addObject:entity];
                [self.arrayContact_1 addObject:entity];
            }
            
            [self.tableView reloadData];
            
        }else{
//            iToast *toast = [iToast makeText:@"暂无数据"];
//            [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:-30];
//            [toast setDuration:500];
//            [toast show:iToastTypeNotice];
        }
        
        [_header endRefreshing];
    } Failed:^(int errorCode, NSString *message) {
        
        [_header endRefreshing];
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
