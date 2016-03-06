//
//  MyInformationTableViewCell.m
//  AssistantChannel
//
//  Created by 胡礼节 on 16/3/5.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyInformationTableViewCell.h"

@implementation MyInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _leftLabel = [[UILabel alloc]init];
    _leftLabel.font = [UIFont fontWithName:@"Arial" size:15];
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    _leftLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _leftLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc]init];
    _rightLabel.font = [UIFont fontWithName:@"Arial" size:15];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _rightLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_rightLabel];
    
}

- (void)layoutSubviews {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _leftLabel.frame = CGRectMake(15, height/3, (width-30)/2, height/3);
    _rightLabel.frame = CGRectMake((width-30)/2+15, height/3, (width-30)/2, height/3);
}

@end
