//
//  Remuneration_Detail_2TableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Remuneration_Detail_2TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *Remuneration_totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_OneLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_ThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *num_oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *Remuneration_oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *num_twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *Remuneration_twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *num_threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *Remuneration_threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *GSM_NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *GSM_RemunerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *EasyOwn_NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *EasyOwn_GSM_RemunerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *M_Zone_NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *M_Zone_GSM_RemunerationLabel;

@end
