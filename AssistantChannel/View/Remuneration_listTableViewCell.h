//
//  Remuneration_listTableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Remuneration_listTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fh_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *zz_sx_feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *zz_kd_feeLebel;
@property (weak, nonatomic) IBOutlet UILabel *reduce_feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminal_4g_feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *jl_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *other_feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *total_feeLabel;


@end
