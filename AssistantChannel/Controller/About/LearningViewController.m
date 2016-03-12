//
//  LearningViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "LearningViewController.h"
#import "LearnCell.h"

@interface LearningViewController ()
{
    UserEntity *userEntity;
}
@property (strong , nonatomic) NSMutableArray *dataArr;
@end

@implementation LearningViewController

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
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = NO;
    [self.view addSubview:_tableview];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    [self reloadTableViewHeader];
    [self addRefreshView];
    
    [self typesData];
    [self getData:self.currentPage andWithPage:0 andWithPageSize:20];
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

- (void)reloadTableViewHeader{
    self.titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andPages:cateArr];
    tableViewheader.searchText.placeholder = @"标题";
    tableViewheader.delegate = self;
    tableViewheader.searchText.delegate = self;
    [self.titleview addSubview:tableViewheader];
    [self.view addSubview:self.titleview];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"tab1";
    LearnCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[LearnCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.title.text = [dic objectForKey:@"title"];
    cell.personName.text = [dic objectForKey:@"nickname"];
    NSString *time =[dic objectForKey:@"create_time"];
    cell.time.text = [self transTime:time];
    cell.type1.text = [dic objectForKey:@"ntype_name"];
    return cell;
}

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index{
    
    self.currentPage = index;
    [self getData:index andWithPage:0 andWithPageSize:20];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    LearnDetailViewController *ldvc = [[LearnDetailViewController alloc]init];
    ldvc.url = [_dataArr[indexPath.row] objectForKey:@"url"];
    [app.hVC pushViewController:ldvc animated:YES];
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


//时间戳转时间
-(NSString *)transTime:(NSString *)timeStamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *datea = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSString *dateString = [formatter stringFromDate:datea];
    return dateString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
