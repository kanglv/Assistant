//
//  information_manage_DetailViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/4.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "information_manage_DetailViewController.h"
#import "Channel_infortationTableViewCell.h"
#import "information_DetailViewController.h"
#import "Channel_informationEntity.h"

@interface information_manage_DetailViewController ()
{
    Channel_infortationTableViewCell *cell1;
    UserEntity *userEntity;
}
@end

@implementation information_manage_DetailViewController

- (void)dealloc
{
    [_header free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userEntity = [UserEntity sharedInstance];
    
    
    if (self.name.length == 0) {
        
    }else{
     
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.hVC setNavigationBarHidden:NO animated:YES];
    }
  
    
    self.navigationItem.title = @"渠道网点";
    
    cateArr = [[NSMutableArray alloc]init];
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];

    self.tableView.tableFooterView = [[UITableView alloc]init];
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cateArr addObject:@"所有类型"];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    [self addRefreshView];
    
    [self reloadTableViewHeader];
    
    [self typesData];
    
    [self getData:0 andWithPage:0 andWithPageSize:20];
}

#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    if (self.name.length == 0) {
        
    }else{
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.hVC setNavigationBarHidden:YES animated:NO];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [weakSelf getData:weakSelf.currentPage andWithPage:0 andWithPageSize:20];
    };
    
}

- (void)reloadTableViewHeader
{
    tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andPages:cateArr];
    tableViewheader.delegate = self;
    tableViewheader.searchText.delegate = self;
    self.tableView.tableHeaderView = tableViewheader;
    
    if ([userEntity.roles isEqualToString:@"11"]) {
       
        tableViewheader.searchText.text = self.name;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:tableViewheader.searchText];
        
    }else if ([userEntity.roles isEqualToString:@"12"]){
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayContact count];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"Channel_infortationTableViewCell";
    
    cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];

    
    if (!cell1) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Channel_informationEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    cell1.titleLabel.text = entity.name;
    cell1.telLabel.text = [NSString stringWithFormat:@"电话：%@",entity.mobile];
    [self setStarNum:entity.cstar];
    
    return cell1;

}

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index{
    
    self.currentPage = index;
    [self getData:index andWithPage:0 andWithPageSize:20];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Channel_informationEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    information_DetailViewController *vc = [[information_DetailViewController alloc]init];
    
    vc.infomationID = entity.infomationID;
    vc.type = MANAGERNEXT;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void) textFieldDidChange:(UITextField *) textField{
    
    if (tableViewheader.searchText.text.length == 0) {
        
        [tableViewheader.searchText resignFirstResponder];
        
        [self getData:0 andWithPage:0 andWithPageSize:20];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self searchQuDao:textField.text];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tableViewheader.searchText resignFirstResponder];
    [tableViewheader.dropDown hideDropDown:tableViewheader.cateBtn];
    tableViewheader.dropDown = nil;
}


- (void)typesData{
    
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"types",@"a",
                           userEntity.sn,@"sn",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSMutableArray *typesArr = [dic objectForKey:@"ls"];
            
            for (NSDictionary* attributes in typesArr) {
                
                [cateArr addObject:[attributes objectForKey:@"name"]];
                
            }
            
            [self reloadTableViewHeader];
            
        }else{
            
        }
        
    } Failed:^(int errorCode, NSString *message) {
        
    }];
}

- (void)getData:(int)type andWithPage:(int)page andWithPageSize:(int)pagesize{
    
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"list",@"a",
                           userEntity.sn,@"sn",
                           self.dep_id?self.dep_id:@"0",@"dep_id",
                           @"0" ,@"ref_type",
                           @(type),@"type_id",
                           tableViewheader.searchText.text?tableViewheader.searchText.text:@"",@"name",
                           @(page),@"page",
                           @(pagesize),@"page_size",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSNumber *total = [dic valueForKeyPath:@"total"];
            NSString *totalState = [NSString stringWithFormat:@"%d", [total intValue]];
            
            [self.arrayContact removeAllObjects];
            [self.arrayCustomerTemp removeAllObjects];
            
            if ([totalState isEqualToString:@"0"]) {
                
//                iToast *toast = [iToast makeText:@"暂无数据"];
//                [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:-30];
//                [toast setDuration:500];
//                [toast show:iToastTypeNotice];
                
            }else{
                NSMutableArray *typesArr = [dic objectForKey:@"ls"];
                for (NSDictionary* attributes in typesArr) {
                    
                    Channel_informationEntity *entity = [[Channel_informationEntity alloc] init];
                    entity = [entity initWithAttributes:attributes];
                    [self.arrayContact addObject:entity];
                    [self.arrayCustomerTemp addObject:entity];
                }
            }
            
            [self.tableView reloadData];
            
        }else{
           
        }
        [_header endRefreshing];
        [HUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        
//        iToast *toast = [iToast makeText:@"网络不给力，请检查网络"];
//        [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:-30];
//        [toast setDuration:500];
//        [toast show:iToastTypeNotice];
        
        [_header endRefreshing];
        [HUD hide:YES];
    }];
    
}

- (void)searchQuDao:(NSString*)name{
    
    
    [self.arrayContact removeAllObjects];
    if (name == nil || name.length == 0) {
        for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
            Channel_informationEntity *entity = [self.arrayCustomerTemp objectAtIndex:i];
            [self.arrayContact addObject:entity];
        }
        [self.tableView reloadData];
        return;
    }
    
    for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
        Channel_informationEntity *entity = [self.arrayCustomerTemp objectAtIndex:i];
        
        NSRange range = [entity.name rangeOfString:name];//判断字符串是否包含
        
        if (range.length > 0)//包含
        {
            [self.arrayContact addObject:entity];
        } else//不包含
        {
        }
    }
    
    [self.tableView reloadData];
}

- (void)setStarNum:(NSString *)num{
    
    cell1.star_1.image = [UIImage imageNamed:@"star_2"];
    cell1.star_2.image = [UIImage imageNamed:@"star_2"];
    cell1.star_3.image = [UIImage imageNamed:@"star_2"];
    cell1.star_4.image = [UIImage imageNamed:@"star_2"];
    cell1.star_5.image = [UIImage imageNamed:@"star_2"];
    
    if ([num isEqualToString:@"0.5"]) {
        cell1.star_1.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"1"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"1.5"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"2"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"2.5"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
        cell1.star_3.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"3"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
        cell1.star_3.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"3.5"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
        cell1.star_3.image = [UIImage imageNamed:@"star_1"];
        cell1.star_4.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"4"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
        cell1.star_3.image = [UIImage imageNamed:@"star_1"];
        cell1.star_4.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"4.5"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
        cell1.star_3.image = [UIImage imageNamed:@"star_1"];
        cell1.star_4.image = [UIImage imageNamed:@"star_1"];
        cell1.star_5.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"5"]){
        cell1.star_1.image = [UIImage imageNamed:@"star_1"];
        cell1.star_2.image = [UIImage imageNamed:@"star_1"];
        cell1.star_3.image = [UIImage imageNamed:@"star_1"];
        cell1.star_4.image = [UIImage imageNamed:@"star_1"];
        cell1.star_5.image = [UIImage imageNamed:@"star_1"];
    }
    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
