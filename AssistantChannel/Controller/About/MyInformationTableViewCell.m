//
//  MyInformationTableViewCell.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/5.
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
    _topLine = [[UILabel alloc]init];
    _topLine.backgroundColor = [UIColor grayColor];
    _topLine.text = @"";
    [self.contentView addSubview:_topLine];
    
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
    
    _bottomLine = [[UILabel alloc]init];
    _bottomLine.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.8];
    _bottomLine.text = @"";
    [self.contentView addSubview:_bottomLine];
    
}

- (void)layoutSubviews {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat onePixel = 1 / [[UIScreen mainScreen] scale];
    _topLine.frame = CGRectMake(0, 0, width, onePixel);
    _bottomLine.frame = CGRectMake(0, height-onePixel, width, onePixel);
    
    _leftLabel.frame = CGRectMake(15, height/3, (width-30)/2, height/3);
    _rightLabel.frame = CGRectMake((width-30)/2+15, height/3, (width-30)/2, height/3);
}

@end
