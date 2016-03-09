//
//  LearningViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "LearningViewController.h"

@interface LearningViewController ()
{
    UserEntity *userEntity;
}

@end

@implementation LearningViewController

- (void)dealloc
{
    [_header free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
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
        tableViewheader = [[tableViewHeader alloc] initWithFrameanSearch:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
        tableViewheader.delegate = self;
        tableViewheader.searchText.delegate = self;
        self.tableview.tableHeaderView = tableViewheader;
        
        [tableViewheader.searchBtn addTarget:self action:@selector(seachBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([userEntity.roles isEqualToString:@"11"]) {
        
    }else if([userEntity.roles isEqualToString:@"12"]){
       
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index{
    
    self.currentPage = index;
    [self getData:index andWithPage:0 andWithPageSize:20];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

- (void) textFieldDidChange:(UITextField *) textField{
    
    [self searchData:textField.text];
    
}

- (void)searchData:(NSString *)string{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)seachBtnClick{
    
    [tableViewheader.searchText resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tableViewheader.searchText resignFirstResponder];
    [tableViewheader.dropDown hideDropDown:tableViewheader.cateBtn];
    tableViewheader.dropDown = nil;
}

//获取下拉列表数据
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
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
