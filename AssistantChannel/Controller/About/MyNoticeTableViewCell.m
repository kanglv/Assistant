//
//  MyNoticeTableViewCell.m
//  AssistantChannel
//
//  Created by 胡礼节 on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyNoticeTableViewCell.h"

@implementation MyNoticeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    
    _arrowView = [[UIImageView alloc]init];
    _arrowView.image = [UIImage imageNamed:@"arrows_right"];
    [self.contentView addSubview:_arrowView];
    
    _inforLabel = [[UILabel alloc]init];
    _inforLabel.font = [UIFont fontWithName:@"Arial" size:15];
    _inforLabel.textAlignment = NSTextAlignmentLeft;
    _inforLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _inforLabel.textColor= [UIColor blackColor];
    _inforLabel.lineBreakMode = UILineBreakModeWordWrap;
    _inforLabel.numberOfLines = 0;
    [self.contentView addSubview:_inforLabel];
    
    _stateLabel = [[UILabel alloc]init];
    _stateLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _stateLabel.textAlignment = NSTextAlignmentLeft;
    _stateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _stateLabel.textColor= [UIColor grayColor];
    [self.contentView addSubview:_stateLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _timeLabel.textColor= [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGSize maximumLabelSize = CGSizeMake(100, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_inforLabel sizeThatFits:maximumLabelSize];
    CGSize stateSize = [_stateLabel sizeThatFits:maximumLabelSize];
    CGSize timeExpectSize = [_timeLabel sizeThatFits:maximumLabelSize];
    
//    CGFloat onePixel = 1 / [[UIScreen mainScreen] scale];
   
    _arrowView.frame = CGRectMake(width-30, (height-10)/2, 10, 10);
    
    _inforLabel.frame = CGRectMake(15, height/5, width*5/6,expectSize.height);
    
    _stateLabel.frame = CGRectMake(15, height-height/5-stateSize.height, width/6,stateSize.height);
    
    _timeLabel.frame = CGRectMake(width*5/6-timeExpectSize.width, height-height/5-timeExpectSize.height, width/6,timeExpectSize.height);
    
    
    
}
@end
