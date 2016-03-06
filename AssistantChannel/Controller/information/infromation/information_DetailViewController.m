//
//  information_DetailViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/1.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "information_DetailViewController.h"
#import "Infortiong_Detail_1TableViewCell.h"
#import "Infortiong_Detail_2TableViewCell.h"
#import "Infortiong_Detail_3TableViewCell.h"
#import "Infortion_DetailEntity.h"

@interface information_DetailViewController ()
{
    Infortiong_Detail_1TableViewCell *cell1;
    Infortiong_Detail_2TableViewCell *cell2;
    Infortiong_Detail_3TableViewCell *cell3;
}

@end

@implementation information_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:NO animated:YES];
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"渠道信息详情";
    
    self.arrayContact = [[NSMutableArray alloc]init];
    
    [self getData:self.infomationID];
}

#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    if (self.type == MANAGERNEXT) {
        
    }else{
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.hVC setNavigationBarHidden:YES animated:NO];

    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CGFloat cellheight;
        cellheight = cell1.addressLabel.layer.frame.size.height;
        CGSize size = [cell1.addressLabel sizeThatFits:CGSizeMake(cell1.addressLabel.frame
                                                                  .size.width, MAXFLOAT)];
        if (size.height == 0) {
            return 158;
        }
        return size.height + 135;
    }else if(indexPath.row == 1){
        return 67;
    }else if(indexPath.row == 2){
        return 230;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"Infortiong_Detail_1TableViewCell";
    static NSString *identifier2 = @"Infortiong_Detail_2TableViewCell";
    static NSString *identifier3 = @"Infortiong_Detail_3TableViewCell";
    cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
    cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    cell3 = [tableView dequeueReusableCellWithIdentifier:identifier3];
    
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
    
    cell1.bgView.layer.borderWidth = 1.0;
    cell1.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    cell2.bgView.layer.borderWidth = 1.0;
    cell2.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    cell3.bgView.layer.borderWidth = 1.0;
    cell3.bgView.layer.borderColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
    
    if ([self.arrayContact count] == 1) {
        Infortion_DetailEntity *entity = [self.arrayContact objectAtIndex:0];
        
        switch (indexPath.row) {
            case 0:
                
                cell1.nameLabel.text = entity.name;
                cell1.codeLabel.text = entity.code;
                cell1.personLabel.text = entity.nickname;
                cell1.telLabel.text = entity.mobile;
                cell1.addressLabel.text = entity.address;
                
                return cell1;
                break;
            case 1:
                
                cell2.managerLabel.text = entity.manager_nickname;
                cell2.telLabel.text = entity.manager_mobile;
                
                return cell2;
                break;
            case 2:
                
                cell3.categoryLabel.text = entity.ctype_desc;
                cell3.levelLabel.text = entity.clevel;
                cell3.StarLabel.text = entity.cstar_desc;
                cell3.Business_typeLabel.text = entity.service;
                if ([entity.is_store isEqualToString:@"0"]) {
                    cell3.phone_storesLabel.text = @"否";
                }else if ([entity.is_store isEqualToString:@"1"]){
                    cell3.phone_storesLabel.text = @"是";
                }
                
                cell3.time_signingLabel.text = [dateChange NsstringChangeDate:entity.signed_time];
                cell3.time_expiresLabel.text = [dateChange NsstringChangeDate:entity.invalid_time];
                
                return cell3;
                break;
            default:
                break;
        }
    }else{
        
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
            default:
                break;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    Infortion_DetailEntity *entity = [self.arrayContact objectAtIndex:0];
    NSString *strTel;
    if (indexPath.row == 0) {
        strTel = [NSString stringWithFormat:@"tel://%@", entity.mobile];
        
    }else if (indexPath.row == 1){
        strTel = [NSString stringWithFormat:@"tel://%@", entity.manager_mobile];
     
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strTel]];
}

- (void)getData:(NSString *)infomationID{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"channel",@"m",
                           @"detail",@"a",
                           userEntity.sn,@"sn",
                           infomationID,@"id",
                           nil
                           ];
    
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            NSDictionary *typesArr = [entity objectForKey:@"data"];
            
            Infortion_DetailEntity *entity = [[Infortion_DetailEntity alloc] init];
            entity = [entity initWithAttributes:typesArr];
            [self.arrayContact addObject:entity];

            [self.titleImage sd_setImageWithURL:[NSURL URLWithString:[BASEURL stringByAppendingString:entity.img]] placeholderImage:[UIImage imageNamed:@"img_setting_image"]];
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
