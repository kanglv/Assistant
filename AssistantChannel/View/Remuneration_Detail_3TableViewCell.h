//
//  Remuneration_Detail_3TableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Remuneration_Detail_3TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_total_freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_Total_remunerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *total_free_NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *total_Remuneration_NumLabel;


@end
