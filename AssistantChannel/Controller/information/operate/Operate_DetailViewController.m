//
//  Operate_DetailViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Operate_DetailViewController.h"
#import "Operate_Detail_1TableViewCell.h"
#import "Operate_Detail_2TableViewCell.h"
#import "Operate_DetailEntiey.h"

@interface Operate_DetailViewController ()
{
    Operate_Detail_1TableViewCell *cell1;
    Operate_Detail_2TableViewCell *cell2;
}
@end

@implementation Operate_DetailViewController

- (void)viewDidLoad {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:NO animated:YES];
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.arrayContact = [[NSMutableArray alloc]init];
    
    [self getData];
    
    self.navigationItem.title = @"渠道运营状况详情";
}

#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    UserEntity *userEntity = [UserEntity sharedInstance];
    if ([userEntity.roles isEqualToString:@"11"]) {
        
    }else if ([userEntity.roles isEqualToString:@"12"]){
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.hVC setNavigationBarHidden:YES animated:NO];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        return 174;
    }else if(indexPath.row == 1){
        return 342;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"Operate_Detail_1TableViewCell";
    static NSString *identifier2 = @"Operate_Detail_2TableViewCell";

    cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    
    if (!cell1) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (!cell2) {
        cell2 = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
        [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    cell1.bgView.layer.borderWidth = 1.0;
    cell1.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    cell2.bgView.layer.borderWidth = 1.0;
    cell2.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    
    if (self.arrayContact.count == 1) {
        
        Operate_DetailEntiey *entity = [self.arrayContact objectAtIndex:0];
        
        if (indexPath.row == 0) {
            cell1.nameLabel.text = entity.name;
            cell1.codeLabel.text = entity.code;
            cell1.statistical_timeLabel.text = [NSString stringWithFormat:@"%@－－%@",self.startDate,self.endDate];
            cell1.Payment_amountLabel.text = [dateChange NsstringChangeYuan:[entity.fee_total stringValue]];
            cell1.card_rateLabel.text = [NSString stringWithFormat:@"%@％",entity.card_rate];
            
            return cell1;
        }else if (indexPath.row == 1){
            
            cell2.net_in_totalLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_total];
            cell2.net_in_totalLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_total];
            cell2.net_in_djzfLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_djzf];
    
            cell2.net_in_tczfLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_tczf];
            cell2.net_in_djzzLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_djzz];
    
            cell2.net_in_qyLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_qy];
            cell2.net_in_tkkkLabel.text = [NSString stringWithFormat:@"%@",entity.net_in_tkkk];
    
            cell2.terminal_totalLabel.text = [NSString stringWithFormat:@"%@",entity.terminal_total];
            cell2.terminal_hyjLabel.text = [NSString stringWithFormat:@"%@",entity.terminal_hyj];
            
            cell2.terminal_ljLabel.text = [NSString stringWithFormat:@"%@",entity.terminal_lj];
            cell2.terminal_yhLabel.text = [NSString stringWithFormat:@"%@",entity.terminal_yh];
            
            return cell2;
        }

    }else{
        if (indexPath.row == 0) {
            return cell1;
        }else if(indexPath.row == 1){
            return cell2;
        }
    }
   return nil;
}

- (void)getData{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"business_stat",@"a",
                           userEntity.sn,@"sn",
                           self.ref_id,@"ref_id",
                           @"0",@"ctype",
                           @"3",@"level",
                           self.startDate,@"from_time",
                           self.endDate,@"to_time",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSMutableArray *DataArr = [dic objectForKey:@"ls"];
            [self.arrayContact removeAllObjects];
            
            self.startDate = [dic objectForKey:@"from_time"];
            self.endDate = [dic objectForKey:@"to_time"];
            
            for (NSDictionary* attributes in DataArr) {
                
                Operate_DetailEntiey *entity = [[Operate_DetailEntiey alloc] init];
                entity = [entity initWithAttributes:attributes];
                [self.arrayContact addObject:entity];
            }
            
            [self.tableView reloadData];
            
        }else{
            
        }

    } Failed:^(int errorCode, NSString *message) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
