//
//  Operate_Detail_1TableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Operate_Detail_1TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statistical_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *Payment_amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *card_rateLabel;

@end
