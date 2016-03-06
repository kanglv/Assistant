//
//  Infortiong_Detail_3TableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Infortiong_Detail_3TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *StarLabel;
@property (weak, nonatomic) IBOutlet UILabel *Business_typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone_storesLabel;
@property (weak, nonatomic) IBOutlet UILabel *time_signingLabel;
@property (weak, nonatomic) IBOutlet UILabel *time_expiresLabel;
@end
