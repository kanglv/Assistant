//
//  Information_baseViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Information_baseViewController.h"
#import "Channel_informationEntity.h"
#import "Channel_infortationTableViewCell.h"
#import "information_DetailViewController.h"
#import "InformationViewController.h"
#import "Channel_infortation_DirectorTableViewCell.h"
#import "Channel_infortation_DirectorEntity.h"
#import "information_manager_listViewController.h"
#import "information_manage_DetailViewController.h"

@interface Information_baseViewController ()
{
    Channel_infortationTableViewCell *cell1;
    Channel_infortation_DirectorTableViewCell *cell2;
    UserEntity *userEntity;
}
@end

@implementation Information_baseViewController

- (void)dealloc
{
    [_header free];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self)
    {
        self.tableview = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.tableFooterView = [[UIView alloc]init];
        
        [self.view addSubview:self.tableview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cateArr = [[NSMutableArray alloc]init];
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];
    self.ArrayDepartment = [[NSMutableArray alloc]init];
    self.ArrayDepartmentTemp = [[NSMutableArray alloc]init];
    
    userEntity = [UserEntity sharedInstance];
    
    [cateArr addObject:@"所有类型"];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        [self getDepartmentData];
        
    }else if ([userEntity.roles isEqualToString:@"12"]){
        
        [self getData:0 andWithPage:0 andWithPageSize:20];
    }
    
    
    [self addRefreshView];
    
    [self reloadTableViewHeader];
    
    [self typesData];
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableview;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [weakSelf getData:weakSelf.currentPage andWithPage:0 andWithPageSize:20];
    };
    
}

- (void)reloadTableViewHeader
{

    if ([userEntity.roles isEqualToString:@"11"]) {
        
        tableViewheader = [[tableViewHeader alloc] initWithFrameanSearch:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
        tableViewheader.delegate = self;
        tableViewheader.searchText.delegate = self;
        self.tableview.tableHeaderView = tableViewheader;
        
        [tableViewheader.searchBtn addTarget:self action:@selector(seachBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else if([userEntity.roles isEqualToString:@"12"]){
        
        tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andPages:cateArr];
        tableViewheader.delegate = self;
        tableViewheader.searchText.delegate = self;
        self.tableview.tableHeaderView = tableViewheader;
        
        [tableViewheader.searchBtn addTarget:self action:@selector(seachBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else if([userEntity.roles isEqualToString:@"13"]){
        

    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        return [self.ArrayDepartment count] + 1;
    }else if([userEntity.roles isEqualToString:@"12"]){
        
        return [self.arrayContact count];
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([userEntity.roles isEqualToString:@"11"]) {
        return 40;
    }else if([userEntity.roles isEqualToString:@"12"]){
        return 75;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"Channel_infortationTableViewCell";
    static NSString *identifier2 = @"Channel_infortation_DirectorTableViewCell";
    
    cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    if (!cell1) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (!cell2) {
        cell2 = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
    }
    
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        if (indexPath.row == 0) {
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell2.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
            cell2.departmentLabel.text = @"部门";
            cell2.total_outletsLabel.text = @"网点总数";
            cell2.Self_OfficeLabel.text = @"自营厅";
            cell2.Social_channelsLabel.text = @"社会渠道";

        }else{
            Channel_infortation_DirectorEntity *entity = [self.ArrayDepartment objectAtIndex:indexPath.row - 1];

            cell2.departmentLabel.text = entity.title;
            cell2.total_outletsLabel.text = [NSString stringWithFormat:@"%@",entity.total];
            cell2.Self_OfficeLabel.text = [NSString stringWithFormat:@"%@",[entity.stat firstObject]];
            cell2.Social_channelsLabel.text = [NSString stringWithFormat:@"%@",[entity.stat lastObject]];

        }
        return cell2;
    }else if ([userEntity.roles isEqualToString:@"12"]) {
        
        Channel_informationEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
        cell1.titleLabel.text = entity.name;
        cell1.telLabel.text = [NSString stringWithFormat:@"电话：%@",entity.mobile];
        [self setStarNum:entity.cstar];
        return cell1;
    }
    
    return nil;
}

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index{
    
    self.currentPage = index;
    [self getData:index andWithPage:0 andWithPageSize:20];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if ([userEntity.roles isEqualToString:@"11"]) {
        if (indexPath.row == 0 ||indexPath.row == self.ArrayDepartment.count) {

        }else{
            
            Channel_infortation_DirectorEntity *entity = [self.ArrayDepartment objectAtIndex:indexPath.row - 1];
            
            if ([[entity.total stringValue] isEqualToString:@"0"]) {
                
//                iToast *toast = [iToast makeText:@"暂无子列表"];
//                [toast setGravity:iToastGravityBottom offsetLeft:0 offsetTop:-30];
//                [toast setDuration:500];
//                [toast show:iToastTypeNotice];
                
            }else{
                
                information_manager_listViewController *vc = [[information_manager_listViewController alloc]init];
                vc.dep_id = entity.ls_dep_id;
                
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [app.hVC pushViewController:vc animated:YES];
            }
        }
        
    }else if([userEntity.roles isEqualToString:@"12"]){
        
        Channel_informationEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
        information_DetailViewController *vc = [[information_DetailViewController alloc]init];
        
        vc.infomationID = entity.infomationID;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
    }
    
    
}

- (void) textFieldDidChange:(UITextField *) textField{
    
   
    [self searchQuDao:textField.text];
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        information_manage_DetailViewController *vc = [[information_manage_DetailViewController alloc]init];
        vc.name = textField.text;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
        
    }else if([userEntity.roles isEqualToString:@"12"]){
        [self searchQuDao:textField.text];
    }
    return YES;
}

- (void)seachBtnClick{
    
    [tableViewheader.searchText resignFirstResponder];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        information_manage_DetailViewController *vc = [[information_manage_DetailViewController alloc]init];
        vc.name = tableViewheader.searchText.text;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
        
    }else if([userEntity.roles isEqualToString:@"12"]){
        
        [self searchQuDao:tableViewheader.searchText.text];
    }
    
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
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"list",@"a",
                           userEntity.sn,@"sn",
                           userEntity.dep_id,@"dep_id",
                           [userDefaultes objectForKey:@"ref_type"],@"ref_type",
                           @(type),@"type_id",
                           @"",@"name",
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
                
            }else{
                 NSMutableArray *typesArr = [dic objectForKey:@"ls"];
                for (NSDictionary* attributes in typesArr) {
                    
                    Channel_informationEntity *entity = [[Channel_informationEntity alloc] init];
                    entity = [entity initWithAttributes:attributes];
                    [self.arrayContact addObject:entity];
                    [self.arrayCustomerTemp addObject:entity];
                }
            }
            
            [self.tableview reloadData];
            
        }else{
            
        }
        [_header endRefreshing];
        [HUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        
        [_header endRefreshing];
        [HUD hide:YES];
    }];
    
}

- (void)getDepartmentData{
    
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"stat",@"a",
                           userEntity.sn,@"sn",
                           @"0",@"dep_id",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            
            [self.ArrayDepartment removeAllObjects];
            
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            
           Channel_infortation_DirectorEntity *entity = [[Channel_infortation_DirectorEntity alloc] init];
            
            entity = [entity initWithAttributes:dic];
            
            [self.ArrayDepartmentTemp addObject:entity];

            NSMutableArray *typesArr = [dic objectForKey:@"ls"];
            for (NSDictionary* attributes in typesArr) {
                
                Channel_infortation_DirectorEntity *entity = [[Channel_infortation_DirectorEntity alloc] init];
                entity = [entity initWithAarray:attributes];
                [self.ArrayDepartment addObject:entity];
            }
        
            [self.tableview reloadData];
            
        }else{
            
        }
        [_header endRefreshing];
        [HUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        
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
        [self.tableview reloadData];
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
    
    [self.tableview reloadData];
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
