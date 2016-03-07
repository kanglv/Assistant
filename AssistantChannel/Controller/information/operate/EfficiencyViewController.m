//
//  EfficiencyViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "EfficiencyViewController.h"
#import "Utilies.h"
#import "EfficiencyTableViewCell.h"
#import "EfficiencyEntity.h"

@interface EfficiencyViewController ()
{
    EfficiencyTableViewCell *cell;
}
@end

@implementation EfficiencyViewController

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
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:self.tableView];
        [self reloadTableViewHeader];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayContact = [[NSMutableArray alloc]init];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    [self addRefreshView];
    [self getData:nil andWithTime:nil];
    
    
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
    
    self.titleview = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, 40)];
    
    tableViewheader = [[tableViewHeader alloc] initWithFrameanDate:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    tableViewheader.searchText.delegate = self;
    
    self.startTime = [Utilies getLastMonth];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.endTime = [dateFormatter stringFromDate:[NSDate date]];;
    
    [tableViewheader.DateBtn setTitle:[NSString stringWithFormat:@" %@ ~ %@",self.startTime,self.endTime]
                             forState:UIControlStateNormal];
    [tableViewheader.DateBtn addTarget:self action:@selector(dateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleview addSubview:tableViewheader];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayContact count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"EfficiencyTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil][0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    EfficiencyEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    
    cell.bgView.layer.borderWidth = 1.0;
    cell.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    
    cell.titleLabel.text = entity.stat_month;
    
    cell.net_total_numLabel.text = entity.net_in_total;
    cell.Terminal__numtotalLabel.text = entity.terminal_total;
    cell.Payment_amount_numLebel.text = [NSString stringWithFormat:@"%@",[dateChange NsstringChangeYuan:entity.fee_total]];
    cell.Card_rate_numLabel.text = [NSString stringWithFormat:@"%@％",entity.card_rate];
    
    return cell;
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
                           @"business_list",@"a",
                           userEntity.sn,@"sn",
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
            
            
            
            [self.arrayContact removeAllObjects];
            
            for (NSDictionary* attributes in DataArr) {
                
                EfficiencyEntity *entity = [[EfficiencyEntity alloc] init];
                entity = [entity initWithAttributes:attributes];
                [self.arrayContact addObject:entity];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
