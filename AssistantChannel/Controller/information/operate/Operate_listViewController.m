//
//  Operate_listViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Operate_listViewController.h"
#import "Utilies.h"
#import "Operate_listTableViewCell.h"
#import "Operate_DetailViewController.h"
#import "Operate_listEntity.h"
#import "Operate_manage_listViewController.h"
#import "Operate_manage_operate_listViewController.h"

@interface Operate_listViewController ()
{
    Operate_listTableViewCell *cell;
    
}

@property (strong, nonatomic) NSString *next_level;

@end


@implementation Operate_listViewController

- (void)dealloc
{
    [_header free];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self)
    {
        
        self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc]init];
        
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    [self addRefreshView];
    [self getData:nil andWithTime:nil];
    [self reloadTableViewHeader];
    
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        [weakSelf getData:weakSelf.startTime_1 andWithTime:weakSelf.endTime_1];
    };
}

- (void)reloadTableViewHeader
{
    
    tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    tableViewheader.searchText.delegate = self;
    
    self.startTime = [Utilies getLastMonth];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.endTime = [dateFormatter stringFromDate:[NSDate date]];;
    
    [tableViewheader.DateBtn setTitle:[NSString stringWithFormat:@" %@ ~ %@",self.startTime,self.endTime]
                             forState:UIControlStateNormal];
    [tableViewheader.DateBtn addTarget:self action:@selector(dateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [tableViewheader.searchBtn addTarget:self action:@selector(seachBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = tableViewheader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayContact count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"Operate_listTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil][0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Operate_listEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    
    cell.title.text = entity.name;
    
    cell.net_amountLabel.text = [NSString stringWithFormat:@"总计入网量：%@",entity.net_in_total];
    cell.Total_salesLabel.text = [NSString stringWithFormat:@"终端总计销量：%@",entity.terminal_total];
    cell.Payment_amountLabel.text = [NSString stringWithFormat:@"缴费金额：%@",[dateChange NsstringChangeYuan:entity.fee_total]];
    cell.Spreading_rateLabel.text = [NSString stringWithFormat:@"铺开率：%@％",entity.card_rate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Operate_listEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    UserEntity *userEntity = [UserEntity sharedInstance];
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        Operate_manage_listViewController *vc = [[Operate_manage_listViewController alloc]init];
        
        vc.ref_id = entity.ref_id;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
        

    }else if([userEntity.roles isEqualToString:@"12"]){
        
        Operate_DetailViewController *vc = [[Operate_DetailViewController alloc]init];
        
        vc.level = self.next_level;
        vc.ref_id = entity.ref_id;
        vc.startDate = self.startTime_1;
        vc.endDate = self.endTime_1;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
    }
    
    
}

- (void) textFieldDidChange:(UITextField *) textField{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    UserEntity *userEntity = [UserEntity sharedInstance];
    
    if ([userEntity.roles isEqualToString:@"11"]) {
        Operate_manage_operate_listViewController *vc = [[Operate_manage_operate_listViewController alloc]init];
        
        vc.name = textField.text;
        vc.ref_id = @"0";
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
        
    }else if ([userEntity.roles isEqualToString:@"12"]){
        
        [self searchYunying:tableViewheader.searchText.text];
    }
    return YES;
}

- (void)dateBtnClicked{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *startDate = [dateFormatter dateFromString:self.startTime];
    NSDate *endDate = [dateFormatter dateFromString:self.endTime];
    
    XYStartEndDatePicker *picker = [XYStartEndDatePicker datePicker];
    picker.startDatePicker.date = startDate;
    picker.endDatePicker.date = endDate;
    picker.delegate = self;
    [picker show];
}

- (void)startEndDatePickerDonePressed:(XYStartEndDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.startTime_1 = [dateFormatter stringFromDate:datePicker.startDatePicker.date];
    self.endTime_1 = [dateFormatter stringFromDate:datePicker.endDatePicker.date];

    
    NSString *dateStr = [NSString stringWithFormat:@" %@ ~ %@",self.startTime_1,self.endTime_1];
    [tableViewheader.DateBtn setTitle:dateStr forState:UIControlStateNormal];
    
    [self getData:self.startTime_1 andWithTime:self.endTime_1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tableViewheader.searchText resignFirstResponder];
    [tableViewheader.dropDown hideDropDown:tableViewheader.cateBtn];
    tableViewheader.dropDown = nil;
}

- (void)getData:(NSString *)from_time andWithTime:(NSString *)to_time{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"business_stat",@"a",
                           userEntity.sn,@"sn",
                           userEntity.dep_id,@"ref_id",
                           @"0",@"ctype",
                           [userDefaultes objectForKey:@"ref_type"],@"level",
                           from_time?from_time:@"",@"from_time",
                           to_time?to_time:@"",@"to_time",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSMutableArray *DataArr = [dic objectForKey:@"ls"];
        
            self.next_level = [dic objectForKey:@"next_level"];
            
            
            [self.arrayContact removeAllObjects];
            [self.arrayCustomerTemp removeAllObjects];
            
            for (NSDictionary* attributes in DataArr) {
                
                Operate_listEntity *entity = [[Operate_listEntity alloc] init];
                entity = [entity initWithAttributes:attributes];
                [self.arrayContact addObject:entity];
                [self.arrayCustomerTemp addObject:entity];
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

- (void)seachBtnClick{
    
    UserEntity *userEntity = [UserEntity sharedInstance];
    [tableViewheader.searchText resignFirstResponder];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if ([userEntity.roles isEqualToString:@"11"]) {
        
        Operate_manage_operate_listViewController *vc = [[Operate_manage_operate_listViewController alloc]init];
        
        vc.name = tableViewheader.searchText.text;
        vc.ref_id = @"0";
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [app.hVC pushViewController:vc animated:YES];
        
    }else if ([userEntity.roles isEqualToString:@"12"]){
        
        [self searchYunying:tableViewheader.searchText.text];
    }
    
    
}

- (void)searchYunying:(NSString*)name{
    
    
    [self.arrayContact removeAllObjects];
    if (name == nil || name.length == 0) {
        for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
            Operate_listEntity *entity = [self.arrayCustomerTemp objectAtIndex:i];
            [self.arrayContact addObject:entity];
        }
        [self.tableView reloadData];
        return;
    }
    
    for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
        Operate_listEntity *entity = [self.arrayCustomerTemp objectAtIndex:i];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
