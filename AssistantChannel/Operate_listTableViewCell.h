//
//  Operate_listTableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/1.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Operate_listTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *net_amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *Total_salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *Payment_amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *Spreading_rateLabel;
@end
