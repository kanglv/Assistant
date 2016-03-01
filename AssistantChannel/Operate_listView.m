//
//  Operate_listView.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/1.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Operate_listView.h"
#import "Utilies.h"
#import "Operate_listTableViewCell.h"
#import "Operate_listEntity.h"

@implementation Operate_listView
{
    Operate_listTableViewCell *cell;
}

- (void)dealloc
{
    [_header free];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];

    [self addSubview:self.tableView];
    
    [self addRefreshView];
    [self reloadTableViewHeader];

    [self getData:self.startTime andWithTime:self.endTime];
    
    return self;
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {

        [weakSelf getData:weakSelf.startTime andWithTime:weakSelf.endTime];
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
    double yuan = [entity.fee_total doubleValue];
    NSString *str = [NSString stringWithFormat:@"%0.1f",yuan];
    
    cell.net_amountLabel.text = [NSString stringWithFormat:@"总计入网量：%@",entity.net_in_total];
    cell.Total_salesLabel.text = [NSString stringWithFormat:@"终端总计销量：%@",entity.terminal_total];
    cell.Payment_amountLabel.text = [NSString stringWithFormat:@"缴费金额：%@",str];
    cell.Spreading_rateLabel.text = [NSString stringWithFormat:@"铺开率：%@％",entity.card_rate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) textFieldDidChange:(UITextField *) textField{
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self searchYunying:textField.text];
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
    
    self.startTime = [dateFormatter stringFromDate:datePicker.startDatePicker.date];
    self.endTime = [dateFormatter stringFromDate:datePicker.endDatePicker.date];
    
    
    NSString *dateStr = [NSString stringWithFormat:@" %@ ~ %@",self.startTime,self.endTime];
    [tableViewheader.DateBtn setTitle:dateStr forState:UIControlStateNormal];
    
    [self getData:self.startTime andWithTime:self.endTime];
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
                           userEntity.uid,@"ref_id",
                           @"0",@"ctype",
                           [userDefaultes objectForKey:@"ref_type"],@"level",
                           from_time,@"from_time",
                           to_time,@"to_time",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSMutableArray *DataArr = [dic objectForKey:@"ls"];
            
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
        [_footer endRefreshing];

    } Failed:^(int errorCode, NSString *message) {
        
        [_header endRefreshing];
        [_footer endRefreshing];

    }];
}

- (void)seachBtnClick{
    
    [tableViewheader.searchText resignFirstResponder];
    [self searchYunying:tableViewheader.searchText.text];
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

@end
