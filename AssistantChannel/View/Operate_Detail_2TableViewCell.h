//
//  Operate_Detail_2TableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Operate_Detail_2TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *net_in_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *net_in_djzfLabel;
@property (weak, nonatomic) IBOutlet UILabel *net_in_tczfLabel;
@property (weak, nonatomic) IBOutlet UILabel *net_in_djzzLabel;
@property (weak, nonatomic) IBOutlet UILabel *net_in_qyLabel;
@property (weak, nonatomic) IBOutlet UILabel *net_in_tkkkLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminal_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminal_hyjLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminal_ljLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminal_yhLabel;

@end
