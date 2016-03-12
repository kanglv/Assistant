//
//  PracticeViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "PracticeViewController.h"
#import "Text_exam_listEntity.h"
#import "Text_exam_gradeEntity.h"
#import "PracticeCell.h"
#import "DetailViewController.h"

@interface PracticeViewController ()
{
    UserEntity *userEntity;
}
@property (strong , nonatomic) NSMutableArray *dataArr;
@end

@implementation PracticeViewController

- (void)dealloc
{
    [_testHeader free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [[NSMutableArray alloc]init];
    
    userEntity = [UserEntity sharedInstance];
    
    
    testHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    testHUD.delegate = self;
    testHUD.labelText = @"努力加载中...";
    
    [self getExam_list:@"1" andWithFrom_time:nil andWithToTime:nil];
    
}
- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _testHeader = [MJRefreshHeaderView header];
    _testHeader.scrollView = _table;
    _testHeader.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        [weakSelf getExam_list:@"1" andWithFrom_time:nil andWithToTime:nil];
    };
    
}

- (void)reloadTableViewHeader{
    self.titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    tableViewheader = [[tableViewHeader alloc] initWithFrameanSearch:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    tableViewheader.searchText.placeholder = @"标题";
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
    NSLog(@"%ld",_dataArr .count);
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
    PracticeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[PracticeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    if([self comparetime:[dic objectForKey:@"end_time"]]){
        cell.title.textColor = [UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1];
    }
    NSLog(@"ooooooooooo%@",dic);
    NSLog(@"------%@",[dic objectForKey:@"seconds"]);
    cell.title.text = [dic objectForKey:@"title"];
    cell.personName.text = [dic objectForKey:@"nickname"];
    NSString *begin = [dic objectForKey:@"begin_time"];
    NSString *end = [dic objectForKey:@"end_time"];
    cell.time.text = [self transTime:begin];
    cell.eTime.text = [self transTime:end];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc.dic = _dataArr[indexPath.row];
    dvc.hastitle = @"练习详情";
    [app.hVC pushViewController:dvc animated:YES];
}

- (void) textFieldDidChange:(UITextField *) textField{
    
    [self searchData:textField.text];
    
}
//比较结束时间与当前时间
- (BOOL)comparetime:(NSString *)date{
    BOOL ret = NO;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    if([date doubleValue] > a){
        ret = YES;
    }
    return ret;
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

- (void)getExam_list:(NSString*)tflag andWithFrom_time:(NSString *)from_time andWithToTime:(NSString *)to_time{
    
    CommonService *service = [[CommonService alloc] init];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"exam_list",@"a",
                           userEntity.sn,@"sn",
                           userEntity.dep_id,@"dep_id",
                           @"0",@"answer_status",
                           tflag,@"tflag",
                           @"0",@"page",
                           @"20",@"page_size",
                           from_time,@"from_time",
                           to_time,@"to_time",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSLog(@"%@",dic);
            NSNumber *total = [dic valueForKeyPath:@"total"];
            NSString *totalState = [NSString stringWithFormat:@"%d", [total intValue]];
            
            [self.arrayContact removeAllObjects];
            [self.arrayCustomerTemp removeAllObjects];
            
            if ([totalState isEqualToString:@"0"]) {
                
            }else{
                
                _dataArr = [dic objectForKey:@"ls"];
                for (NSDictionary* attributes in _dataArr) {
                    
                    Text_exam_listEntity *entity = [[Text_exam_listEntity alloc] init];
                    entity = [entity initWithAttributes:attributes];
                    [self.arrayContact addObject:entity];
                    [self.arrayCustomerTemp addObject:entity];
                }
                _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT) style:UITableViewStylePlain];
                _table.delegate = self;
                _table.dataSource = self;
                _table.separatorStyle = NO;
                [self.view addSubview:_table];
                [self reloadTableViewHeader];
                [self addRefreshView];
            }
            
            
        }
        [_testHeader endRefreshing];
        [testHUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        [_testHeader endRefreshing];
        [testHUD hide:YES];
        
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
    
}



@end
