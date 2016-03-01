//
//  Information_baseView.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Information_baseView.h"
#import "Channel_informationEntity.h"
#import "Channel_infortationTableViewCell.h"

@interface Information_baseView ()
{
    Channel_infortationTableViewCell *cell;
}

@end

@implementation Information_baseView

- (void)dealloc
{
    [_header free];
    [_footer free];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
   
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    cateArr = [[NSMutableArray alloc]init];
    self.arrayContact = [[NSMutableArray alloc]init];
    self.arrayCustomerTemp = [[NSMutableArray alloc]init];
    
    [cateArr addObject:@"所有类型"];
    [self addSubview:self.tableView];
    
    HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    [self getData:0 andWithPage:0 andWithPageSize:20];
    
    [self addRefreshView];
    
    [self reloadTableViewHeader];
    
    [self typesData];
    
    return self;
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        weakSelf.currentPage = 0;
        [weakSelf getData:0 andWithPage:0 andWithPageSize:20];
    };
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        [weakSelf getData:0 andWithPage:weakSelf.currentPage++ andWithPageSize:20];
    };
}

- (void)reloadTableViewHeader
{
    
    tableViewheader = [[tableViewHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andPages:cateArr];
    tableViewheader.delegate = self;
    tableViewheader.searchText.delegate = self;
//    [tableViewheader.searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.tableView.tableHeaderView = tableViewheader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayContact count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Channel_infortationTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil][0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Channel_informationEntity *entity = [self.arrayContact objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = entity.name;
    cell.telLabel.text = [NSString stringWithFormat:@"电话：%@",entity.mobile];
    
    [self setStarNum:entity.cstar];
    
    return cell;
}

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index{
    

//    [self getData:index andWithPage:0 andWithPageSize:20];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) textFieldDidChange:(UITextField *) textField{
    
    [self searchQuDao:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self searchQuDao:textField.text];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [tableViewheader.searchText resignFirstResponder];
    [tableViewheader.dropDown hideDropDown:tableViewheader.cateBtn];
    tableViewheader.dropDown = nil;
}


- (void)typesData{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
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
    UserEntity *userEntity = [UserEntity sharedInstance];
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
            NSMutableArray *typesArr = [dic objectForKey:@"ls"];
            
            [self.arrayContact removeAllObjects];
            [self.arrayCustomerTemp removeAllObjects];
            
            for (NSDictionary* attributes in typesArr) {
                
                Channel_informationEntity *entity = [[Channel_informationEntity alloc] init];
                entity = [entity initWithAttributes:attributes];
                [self.arrayContact addObject:entity];
                [self.arrayCustomerTemp addObject:entity];
            }
            
            [self.tableView reloadData];
            
        }else{
            
        }
        [_header endRefreshing];
        [_footer endRefreshing];
        [HUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        
        [_header endRefreshing];
        [_footer endRefreshing];
         [HUD hide:YES];
    }];
    
}

- (void)searchQuDao:(NSString*)name{
    
    
    [self.arrayContact removeAllObjects];
    if (name == nil || name.length == 0) {
        for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
            Channel_informationEntity *entity = [self.arrayCustomerTemp objectAtIndex:i];
            [self.arrayContact addObject:entity];
        }
        [self.tableView reloadData];
        return;
    }
    
    for (int i = 0; i < [self.arrayCustomerTemp count]; i++) {
        Channel_informationEntity *entity = [self.arrayCustomerTemp objectAtIndex:i];
        
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

- (void)setStarNum:(NSString *)num{
    
    cell.star_1.image = [UIImage imageNamed:@"star_2"];
    cell.star_2.image = [UIImage imageNamed:@"star_2"];
    cell.star_3.image = [UIImage imageNamed:@"star_2"];
    cell.star_4.image = [UIImage imageNamed:@"star_2"];
    cell.star_5.image = [UIImage imageNamed:@"star_2"];

    if ([num isEqualToString:@"0.5"]) {
        cell.star_1.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"1"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"1.5"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"2"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"2.5"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
        cell.star_3.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"3"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
        cell.star_3.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"3.5"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
        cell.star_3.image = [UIImage imageNamed:@"star_1"];
        cell.star_4.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"4"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
        cell.star_3.image = [UIImage imageNamed:@"star_1"];
        cell.star_4.image = [UIImage imageNamed:@"star_1"];
    }else if ([num isEqualToString:@"4.5"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
        cell.star_3.image = [UIImage imageNamed:@"star_1"];
        cell.star_4.image = [UIImage imageNamed:@"star_1"];
        cell.star_5.image = [UIImage imageNamed:@"star_3"];
    }else if ([num isEqualToString:@"5"]){
        cell.star_1.image = [UIImage imageNamed:@"star_1"];
        cell.star_2.image = [UIImage imageNamed:@"star_1"];
        cell.star_3.image = [UIImage imageNamed:@"star_1"];
        cell.star_4.image = [UIImage imageNamed:@"star_1"];
        cell.star_5.image = [UIImage imageNamed:@"star_1"];
    }
    
}

@end
