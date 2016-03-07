//
//  Remuneration_listViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Remuneration_listViewController.h"
#import "Utilies.h"
#import "Remuneration_listTableViewCell.h"
#import "Remuneration_DetailViewController.h"
#import "Remuneration_Entity.h"
#import "EffIciency_RemunerationEntity.h"
#import "Efficiency_Remuneration_DetailViewController.h"

@interface Remuneration_listViewController ()
{
    Remuneration_listTableViewCell *cell;
    
   
}
@end


@implementation Remuneration_listViewController

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
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userEntity = [UserEntity sharedInstance];
    
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    [self addRefreshView];
    [self reloadTableViewHeader];
    
    if ([_userEntity.roles isEqualToString:@"13"]) {
        [self get_Efficiency_Data:nil andWithTime:nil];
    }else{
        [self getData:nil andWithTime:nil];
    }
    
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        if ([weakSelf.userEntity.roles isEqualToString:@"13"]) {
            [weakSelf get_Efficiency_Data:weakSelf.startTime_1 andWithTime:weakSelf.endTime_1];
        }else{
            [weakSelf getData:weakSelf.startTime_1 andWithTime:weakSelf.endTime_1];
        }
        
        
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
    
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"Remuneration_listTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil][0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    
    
    cell.bgView.layer.borderWidth = 1.0;
    cell.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    
    if ([_userEntity.roles isEqualToString:@"13"]) {
       EffIciency_RemunerationEntity *entityEff = [self.arrayContact objectAtIndex:indexPath.row];
        cell.titleLabel.text = entityEff.stat_month;
        
        cell.fh_totalLabel.text = [NSString stringWithFormat:@"放号酬金\n%@",entityEff.fh_total];
        cell.zz_sx_feeLabel.text = [NSString stringWithFormat:@"数信酬金\n%@",entityEff.zz_sx_fee];
        cell.zz_kd_feeLebel.text = [NSString stringWithFormat:@"宽带酬金\n%@",entityEff.zz_kd_fee];
        cell.reduce_feeLabel.text = [NSString stringWithFormat:@"扣减酬金\n%@",entityEff.reduce_fee];
        cell.terminal_4g_feeLabel.text = [NSString stringWithFormat:@"4G终端\n%@",entityEff.terminal_4g_fee];
        cell.jl_totalLabel.text = [NSString stringWithFormat:@"激励合作\n%@",entityEff.jl_total];
        cell.other_feeLabel.text = [NSString stringWithFormat:@"其它金额\n%@",entityEff.other_fee];
        cell.total_feeLabel.text = [NSString stringWithFormat:@"代办总计\n%@",entityEff.total_fee];
        
    }else{
       Remuneration_Entity *entity = [self.arrayContact objectAtIndex:indexPath.row];
        cell.titleLabel.text = entity.name;
        cell.fh_totalLabel.text = [NSString stringWithFormat:@"放号酬金\n%@",entity.fh_total];
        cell.zz_sx_feeLabel.text = [NSString stringWithFormat:@"数信酬金\n%@",entity.zz_sx_fee];
        cell.zz_kd_feeLebel.text = [NSString stringWithFormat:@"宽带酬金\n%@",entity.zz_kd_fee];
        cell.reduce_feeLabel.text = [NSString stringWithFormat:@"扣减酬金\n%@",entity.reduce_fee];
        cell.terminal_4g_feeLabel.text = [NSString stringWithFormat:@"4G终端\n%@",entity.terminal_4g_fee];
        cell.jl_totalLabel.text = [NSString stringWithFormat:@"激励合作\n%@",entity.jl_total];
        cell.other_feeLabel.text = [NSString stringWithFormat:@"其它金额\n%@",entity.other_fee];
        cell.total_feeLabel.text = [NSString stringWithFormat:@"代办总计\n%@",entity.total_fee];
        
    }
    
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    
    if ([_userEntity.roles isEqualToString:@"13"]) {
        
        Efficiency_Remuneration_DetailViewController *vc = [[Efficiency_Remuneration_DetailViewController alloc]init];
        
        EffIciency_RemunerationEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    
        vc.entity = entity;
        vc.name = self.name;
        vc.code = self.code;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [app.hVC pushViewController:vc animated:YES];

    }else{
        Remuneration_DetailViewController *vc = [[Remuneration_DetailViewController alloc]init];
        
        Remuneration_Entity *entity = [self.arrayContact objectAtIndex:indexPath.row];
        
        vc.channel_id = entity.channel_id;
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
    
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"reward_stat",@"a",
                           _userEntity.sn,@"sn",
                           @"0",@"dep_id",
                           @"",@"name",
                           @"0",@"page",
                           @"20",@"page_size",
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
            [self.arrayCustomerTemp removeAllObjects];
            
            for (NSDictionary* attributes in DataArr) {
                
                Remuneration_Entity *entity = [[Remuneration_Entity alloc] init];
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
        
        [_header endRefreshing];
        [HUD hide:YES];
    }];
}

- (void)get_Efficiency_Data:(NSString *)from_time andWithTime:(NSString *)to_time{
    
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"reward_list",@"a",
                           _userEntity.sn,@"sn",
                           @"0",@"id",
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

            self.name = [dic objectForKey:@"name"];
            self.code= [dic objectForKey:@"code"];
            
            [self.arrayContact removeAllObjects];
            [self.arrayCustomerTemp removeAllObjects];
            
            for (NSDictionary* attributes in DataArr) {
                
                EffIciency_RemunerationEntity *entity = [[EffIciency_RemunerationEntity alloc] init];
                entity = [entity initWithAttributes:attributes];
                [self.arrayContact addObject:entity];
            }
            
            [self.tableView reloadData];
            
        }else{
            
        }
        [_header endRefreshing];
        
        [HUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        
        [_header endRefreshing];
        [HUD hide:YES];
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
            Remuneration_Entity *entity = [self.arrayCustomerTemp objectAtIndex:i];
            [self.arrayContact addObject:entity];
        }
        [self.tableView reloadData];
        return;
    }
    
    for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
        Remuneration_Entity *entity = [self.arrayCustomerTemp objectAtIndex:i];
        
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
