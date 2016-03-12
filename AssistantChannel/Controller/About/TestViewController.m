//
//  TestViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "TestViewController.h"
#import "Text_exam_listEntity.h"
#import "Text_exam_gradeEntity.h"
#import "PracticeCell.h"
@interface TestViewController ()
{
    UserEntity *userEntity;
}
@property (strong , nonatomic) NSMutableArray *dataArr;
@end

@implementation TestViewController
- (void)dealloc
{
    [_testHeader free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    cateArr = [[NSMutableArray alloc]init];
    _dataArr = [[NSMutableArray alloc]init];
    
    userEntity = [UserEntity sharedInstance];
    
    [cateArr addObject:@"类型"];
    
    testHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    testHUD.delegate = self;
    testHUD.labelText = @"努力加载中...";
    [self typesData];
    [self getExam_list:@"0" andWithFrom_time:nil andWithToTime:nil];
    
}

- (void)reloadTableViewHeader{
    tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andPages:cateArr];
    tableViewheader.searchText.placeholder = @"标题";
    tableViewheader.delegate = self;
    tableViewheader.searchText.delegate = self;
    self.table.tableHeaderView = tableViewheader;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"tab1";
     PracticeCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[PracticeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    NSLog(@"%@",dic);
    cell.title.text = [dic objectForKey:@"title"];
    cell.personName.text = [dic objectForKey:@"nickname"];
    cell.time.text = @"1";
    cell.eTime.text = @"2";
    return cell;
}

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index{
    
    self.currentPage = index;
//    [self getData:index andWithPage:0 andWithPageSize:20];
    
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
            }
            
            
        }else{
            
        }
    } Failed:^(int errorCode, NSString *message) {
        
        
    }];
    
}

- (void)getDepartmentData{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
