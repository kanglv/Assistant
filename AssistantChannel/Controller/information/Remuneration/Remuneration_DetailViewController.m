//
//  Remuneration_DetailViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "Remuneration_DetailViewController.h"
#import "Remuneration_Detail_1TableViewCell.h"
#import "Remuneration_Detail_2TableViewCell.h"
#import "Remuneration_Detail_3TableViewCell.h"
#import "Remuneration_Detail_4TableViewCell.h"
#import "Remuneration_DetailEntity.h"

@interface Remuneration_DetailViewController ()
{
    Remuneration_Detail_1TableViewCell *cell1;
    Remuneration_Detail_2TableViewCell *cell2;
    Remuneration_Detail_3TableViewCell *cell3;
    Remuneration_Detail_4TableViewCell *cell4;
}
@end

@implementation Remuneration_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:NO animated:YES];
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.arrayContact = [[NSMutableArray alloc]init];
    
    [self getData];
    
    self.navigationItem.title = @"渠道酬金详情";
}

#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:YES animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return 135;
    }else if(indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 8){
        return 131;
    }else if(indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 9){
        return 95;
    }else if(indexPath.row == 3){
        return 128;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"Remuneration_Detail_1TableViewCell";
    static NSString *identifier2 = @"Remuneration_Detail_2TableViewCell";
    static NSString *identifier3 = @"Remuneration_Detail_3TableViewCell";
    static NSString *identifier4 = @"Remuneration_Detail_4TableViewCell";
    
    cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    cell3 = [tableView dequeueReusableCellWithIdentifier:identifier3];
    cell4 = [tableView dequeueReusableCellWithIdentifier:identifier4];
    
    if (!cell1) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (!cell2) {
        cell2 = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
        [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (!cell3) {
        cell3 = [[[NSBundle mainBundle] loadNibNamed:identifier3 owner:nil options:nil] firstObject];
        [cell3 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (!cell4) {
        cell4 = [[[NSBundle mainBundle] loadNibNamed:identifier4 owner:nil options:nil] firstObject];
        [cell4 setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell1.bgView.layer.borderWidth = 1.0;
    cell1.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    cell2.bgView.layer.borderWidth = 1.0;
    cell2.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    cell3.bgView.layer.borderWidth = 1.0;
    cell3.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    cell4.bgView.layer.borderWidth = 1.0;
    cell4.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    
    if (self.arrayContact.count == 1) {
        
        Remuneration_DetailEntity *entity = [self.arrayContact objectAtIndex:0];
        [self setTabelViewCell:indexPath.row];
        switch (indexPath.row) {
            case 0:
                
                cell1.nameLabel.text = [NSString stringWithFormat:@"名称：%@",entity.name];
                cell1.codeLabel.text = [NSString stringWithFormat:@"编码：%@",entity.code];
                cell1.Payment_timeLabel.text = [NSString stringWithFormat:@"酬金时间：%@－－%@",entity.from_time,entity.to_time];
                cell1.Fee_deductionLabel.text = [NSString stringWithFormat:@"酬金扣减金额：%@",[dateChange NsstringChangeYuan:[entity.reduce_fee stringValue]]];
                cell1.Total_remunerationLabel.text = [NSString stringWithFormat:@"酬金总计：%@",[dateChange NsstringChangeYuan:[entity.total_fee stringValue]]];
                
                return cell1;
                break;
            case 1:
 
                cell2.Remuneration_totalLabel.text = [NSString stringWithFormat:@"放号酬金总计：%@", [dateChange NsstringChangeYuan:[entity.fh_total stringValue]]];
                cell2.GSM_NumLabel.text = [NSString stringWithFormat:@"%@", entity.fh_qqt_num];
                cell2.GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.fh_qqt_fee stringValue]]];
                cell2.EasyOwn_NumLabel.text = [NSString stringWithFormat:@"%@", entity.fh_szx_num];
                cell2.EasyOwn_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.fh_szx_fee stringValue]]];
                cell2.M_Zone_NumLabel.text = [NSString stringWithFormat:@"%@", entity.fh_dgdd_num];
                cell2.M_Zone_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.fh_dgdd_fee stringValue]]];
                
                return cell2;
                break;
            case 2:
   
                
                cell3.total_free_NumLabel.text = [NSString stringWithFormat:@"%@", entity.card_total];
                cell3.total_Remuneration_NumLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.card_fee stringValue]]];
                
                return cell3;
                break;
            case 3:

                cell4.Remuneration_totalLabel.text = [NSString stringWithFormat:@"增值业务总计：%@",[dateChange NsstringChangeYuan:[entity.zz_total stringValue]]];
                
                cell4.One_NumLabel.text = [NSString stringWithFormat:@"%@", entity.zz_sx_num];
                cell4.One_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.zz_sx_fee stringValue]]];
                cell4.Two_NumLabel.text = [NSString stringWithFormat:@"%@", entity.zz_kd_num];
                cell4.Two_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.zz_kd_fee stringValue]]];
                
                return cell4;
                break;
            case 4:

                cell3.total_free_NumLabel.text = [NSString stringWithFormat:@"%@", entity.service_num];
                cell3.total_Remuneration_NumLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.service_fee stringValue]]];
                
                return cell3;
                break;
            case 5:
            

                cell2.Remuneration_totalLabel.text = [NSString stringWithFormat:@"话费服务酬金总金额：%@",[dateChange NsstringChangeYuan:[entity.phone_total stringValue]]];
                cell2.GSM_NumLabel.text = [NSString stringWithFormat:@"%@", entity.phone_tc_num];
                cell2.GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.phone_tc_fee stringValue]]];
                cell2.EasyOwn_NumLabel.text = [NSString stringWithFormat:@"%@", entity.phone_dshf_num];
                cell2.EasyOwn_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.phone_dshf_fee stringValue]]];
                cell2.M_Zone_NumLabel.text = [NSString stringWithFormat:@"%@", entity.phone_kzcz_num];
                cell2.M_Zone_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.phone_kzcz_fee stringValue]]];
                
                return cell2;
                break;
            case 6:
                

                
                cell3.total_free_NumLabel.text = [NSString stringWithFormat:@"%@", entity.contract_num];
                cell3.total_Remuneration_NumLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.contract_fee stringValue]]];
                
                return cell3;
                break;
            case 7:

                cell2.Remuneration_totalLabel.text = [NSString stringWithFormat:@"激励酬金总计：%@",[dateChange NsstringChangeYuan:[entity.jl_total stringValue]]];
                cell2.GSM_NumLabel.text = [NSString stringWithFormat:@"%@", entity.jl_hz_num];
                cell2.GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.jl_hz_fee stringValue]]];
                cell2.EasyOwn_NumLabel.text = [NSString stringWithFormat:@"%@", entity.jl_qt_num];
                cell2.EasyOwn_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.jl_qt_fee stringValue]]];
                cell2.M_Zone_NumLabel.text = [NSString stringWithFormat:@"%@", entity.jl_td_num];
                cell2.M_Zone_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.jl_td_fee stringValue]]];
                return cell2;
                break;
            case 8:

                cell2.Remuneration_totalLabel.text = [NSString stringWithFormat:@"终端服务酬金总计：%@",[dateChange NsstringChangeYuan:[entity.terminal_total stringValue]]];
                cell2.GSM_NumLabel.text = [NSString stringWithFormat:@"%@", entity.terminal_4g_num];
                cell2.GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.terminal_4g_fee stringValue]]];
                cell2.EasyOwn_NumLabel.text = [NSString stringWithFormat:@"%@", entity.terminal_qt_num];
                cell2.EasyOwn_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.terminal_qt_fee stringValue]]];
                cell2.M_Zone_NumLabel.text = [NSString stringWithFormat:@"%@", entity.terminal_ls_num];
                cell2.M_Zone_GSM_RemunerationLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.terminal_ls_fee stringValue]]];
                
                return cell2;
                break;
            case 9:
                
                cell3.total_free_NumLabel.text = [NSString stringWithFormat:@"%@", entity.other_num];
                cell3.total_Remuneration_NumLabel.text = [NSString stringWithFormat:@"%@", [dateChange NsstringChangeYuan:[entity.other_fee stringValue]]];
                
                return cell3;
                break;
                
            default:
                break;
        }
    }else{
        [self setTabelViewCell:indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                
                return cell1;
                break;
            case 1:
                
                
                return cell2;
                break;
            case 2:
                
                
                return cell3;
                break;
            case 3:

                return cell4;
                break;
            case 4:
                
      
                return cell3;
                break;
            case 5:
                

                return cell2;
                break;
            case 6:
                

                return cell3;
                break;
            case 7:
                

                return cell2;
                break;
            case 8:
                
                return cell2;
                break;
            case 9:
                
                return cell3;
                break;
                
            default:
                break;
        }
    }
   
    
    return nil;
}

- (void)setTabelViewCell:(int)indexRow{
    
    switch (indexRow) {
        case 0:
            
            cell1.nameLabel.text = @"名称：";
            cell1.codeLabel.text = @"编码：";
            cell1.Payment_timeLabel.text = @"酬金时间：";
            cell1.Fee_deductionLabel.text = @"酬金扣减金额";
            cell1.Total_remunerationLabel.text = @"酬金总计：";

            break;
        case 1:
            
            
            cell2.title_OneLabel.text = @"全球通";
            cell2.title_twoLabel.text = @"神州行";
            cell2.title_ThreeLabel.text = @"动感地带";
            cell2.num_oneLabel.text = @"数量";
            cell2.Remuneration_oneLabel.text = @"酬金";
            cell2.num_twoLabel.text = @"数量";
            cell2.Remuneration_twoLabel.text = @"酬金";
            cell2.num_threeLabel.text = @"数量";
            cell2.Remuneration_threeLabel.text = @"酬金";
            break;
        case 2:
            
            cell3.titleLabel.text = @"充值卡";
            cell3.title_total_freeLabel.text = @"总金额";
            cell3.title_Total_remunerationLabel.text = @"总酬金";

            break;
        case 3:
            
            cell4.Remuneration_totalLabel.text = @"增值业务总计：";
            cell4.title_OneLabel.text = @"数信业务";
            cell4.title_twoLabel.text = @"宽带业务";
            cell4.num_oneLabel.text = @"数量";
            cell4.Remuneration_oneLabel.text = @"酬金";
            cell4.num_twoLabel.text = @"数量";
            cell4.Remuneration_twoLabel.text = @"酬金";
   
            break;
        case 4:
            
            cell3.titleLabel.text = @"其他业务";
            cell3.title_total_freeLabel.text = @"数量";
            cell3.title_Total_remunerationLabel.text = @"酬金";

            break;
        case 5:
            
            cell2.Remuneration_totalLabel.text = @"话费服务酬金总金额：";
            cell2.title_OneLabel.text = @"话费套餐服务";
            cell2.title_twoLabel.text = @"代收话费服务";
            cell2.title_ThreeLabel.text = @"空中充值服务";
            cell2.num_oneLabel.text = @"数量";
            cell2.Remuneration_oneLabel.text = @"酬金";
            cell2.num_twoLabel.text = @"总金额";
            cell2.Remuneration_twoLabel.text = @"酬金";
            cell2.num_threeLabel.text = @"总金额";
            cell2.Remuneration_threeLabel.text = @"酬金";

            break;
        case 6:
            
            cell3.titleLabel.text = @"合作计划服务业务";
            cell3.title_total_freeLabel.text = @"数量";
            cell3.title_Total_remunerationLabel.text = @"酬金";

            break;
        case 7:
            
            cell2.Remuneration_totalLabel.text = @"激励酬金总计：";
            cell2.title_OneLabel.text = @"合作激励";
            cell2.title_twoLabel.text = @"其他激励";
            cell2.title_ThreeLabel.text = @"TD加盟店激励";
            cell2.num_oneLabel.text = @"数量";
            cell2.Remuneration_oneLabel.text = @"酬金";
            cell2.num_twoLabel.text = @"数量";
            cell2.Remuneration_twoLabel.text = @"酬金";
            cell2.num_threeLabel.text = @"数量";
            cell2.Remuneration_threeLabel.text = @"酬金";
            
            break;
        case 8:
            
            cell2.Remuneration_totalLabel.text = @"终端服务酬金总计：";
            cell2.title_OneLabel.text = @"4G终端";
            cell2.title_twoLabel.text = @"其他终端";
            cell2.title_ThreeLabel.text = @"连锁渠道终端";
            cell2.num_oneLabel.text = @"数量";
            cell2.Remuneration_oneLabel.text = @"酬金";
            cell2.num_twoLabel.text = @"数量";
            cell2.Remuneration_twoLabel.text = @"酬金";
            cell2.num_threeLabel.text = @"数量";
            cell2.Remuneration_threeLabel.text = @"酬金";
            
            break;
        case 9:
            
            cell3.titleLabel.text = @"其他扣减";
            cell3.title_total_freeLabel.text = @"数量";
            cell3.title_Total_remunerationLabel.text = @"酬金";
            
            break;
            
        default:
            break;
    }
}

- (void)getData{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"reward_detail",@"a",
                           userEntity.sn,@"sn",
                           self.channel_id,@"id",
                           self.startDate,@"from_time",
                           self.endDate,@"to_time",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSDictionary *attributes = [entity objectForKey:@"data"];
            
            [self.arrayContact removeAllObjects];
            
            Remuneration_DetailEntity *entity = [[Remuneration_DetailEntity alloc] init];
            entity = [entity initWithAttributes:attributes];
            [self.arrayContact addObject:entity];
            
            [self.tabelView reloadData];
            
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
