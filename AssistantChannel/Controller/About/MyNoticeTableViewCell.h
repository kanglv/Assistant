//
//  MyNoticeTableViewCell.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/8.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNoticeTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *arrowView;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
