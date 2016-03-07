//
//  EfficiencyTableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfficiencyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *net_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *Terminal_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *Payment_amountLebel;
@property (weak, nonatomic) IBOutlet UILabel *Card_rateLabel;

@property (weak, nonatomic) IBOutlet UILabel *net_total_numLabel;
@property (weak, nonatomic) IBOutlet UILabel *Terminal__numtotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *Payment_amount_numLebel;
@property (weak, nonatomic) IBOutlet UILabel *Card_rate_numLabel;

@end
