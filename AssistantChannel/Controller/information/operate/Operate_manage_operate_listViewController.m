//
//  Operate_manage_operate_listViewController.m
//  AssistantChannel
//
//  Created by 林琪 on 16/3/5.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Operate_manage_operate_listViewController.h"
#import "Operate_listTableViewCell.h"
#import "Operate_listEntity.h"
#import "Utilies.h"
#import "Operate_DetailViewController.h"

@interface Operate_manage_operate_listViewController ()
{
    Operate_listTableViewCell *cell;
}
@end

@implementation Operate_manage_operate_listViewController

- (void)dealloc
{
    [_header free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = [[UITableView alloc]init];
    
    self.arrayContact = [[NSMutableArray alloc]init];
    
    [self addRefreshView];
    
    [self getData:nil andWithTime:nil];
    
    [self reloadTableViewHeader];
    
    self.navigationItem.title = @"渠道运营状况列表";
    
}

#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    
    tableViewheader = [[tableViewHeader alloc] initWithFrameanDate:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    self.startTime = [Utilies getLastMonth];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.endTime = [dateFormatter stringFromDate:[NSDate date]];;
    
    [tableViewheader.DateBtn setTitle:[NSString stringWithFormat:@" %@ ~ %@",self.startTime,self.endTime]
                             forState:UIControlStateNormal];
    [tableViewheader.DateBtn addTarget:self action:@selector(dateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
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

    
    Operate_DetailViewController *vc = [[Operate_DetailViewController alloc]init];
    
    vc.ref_id = entity.ref_id;
    vc.startDate = self.startTime_1;
    vc.endDate = self.endTime_1;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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

- (void)getData:(NSString *)from_time andWithTime:(NSString *)to_time{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"business_stat",@"a",
                           userEntity.sn,@"sn",
                           self.ref_id,@"ref_id",
                           @"0",@"ctype",
                           @"2",@"level",
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
            
            [self.arrayContact removeAllObjects];
            
            for (NSDictionary* attributes in DataArr) {
                
                Operate_listEntity *entity = [[Operate_listEntity alloc]init];
                
                entity = [entity initWithAttributes:attributes];
                [self.arrayContact addObject:entity];
                
            }
            
            [self.tableView reloadData];
            
        }else{
            
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
