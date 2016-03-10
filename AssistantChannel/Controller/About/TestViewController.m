//
//  TestViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    UserEntity *userEntity;
}
@property (strong , nonatomic) NSMutableArray *dataArr;
@end

@implementation TestViewController
- (void)dealloc
{
    [_header free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    cateArr = [[NSMutableArray alloc]init];
    _dataArr = [[NSMutableArray alloc]init];
    
    userEntity = [UserEntity sharedInstance];
    
    [cateArr addObject:@"所有类型"];
    
    
//    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.delegate = self;
//    HUD.labelText = @"努力加载中...";
    
    [self reloadTableViewHeader];
//    [self typesData];
//    [self getData:self.currentPage andWithPage:0 andWithPageSize:3];
}

- (void)reloadTableViewHeader{
    tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andPages:cateArr];
    tableViewheader.searchText.placeholder = @"标题";
    tableViewheader.delegate = self;
    tableViewheader.searchText.delegate = self;
    self.tableview.tableHeaderView = tableViewheader;
    [tableViewheader.searchBtn addTarget:self action:@selector(seachBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_HEIGHT/5;
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
                           @"knowledge",@"m",
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
                           @"knowledge",@"m",
                           @"list",@"a",
                           userEntity.sn,@"sn",
                           userEntity.dep_id,@"dep_id",
                           userEntity.roles,@"role",
                           @(type),@"ntype",
                           @(page),@"page",
                           @(pagesize),@"page_size",
                           nil
                           ];
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            _dataArr = [dic objectForKey:@"ls"];
            [self.tableview reloadData];
            
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
