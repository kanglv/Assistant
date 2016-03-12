//
//  DetailTableViewCell.m
//  AssistantChannel
//
//  Created by 胡礼节 on 16/3/12.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _left = [[UILabel alloc]init];
    _left .textAlignment = NSTextAlignmentLeft;
    _left .lineBreakMode = NSLineBreakByTruncatingTail;
    [ _left  setTextColor:[UIColor blackColor]];
    _left .font = [UIFont fontWithName:@"Arial" size:18];
    [self.contentView addSubview: _left];
    
    _right = [[UILabel alloc]init];
    _right .textAlignment = NSTextAlignmentLeft;
    _right.numberOfLines = 0;
    _right .lineBreakMode = NSLineBreakByWordWrapping;
    [ _right  setTextColor:[UIColor blackColor]];
    _right .font = [UIFont fontWithName:@"Arial" size:18];
    [self.contentView addSubview: _right];
}

- (void)layoutSubviews{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat actualHeight =height-10;
    
    CGSize maximumLabelSize = CGSizeMake(150, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_left sizeThatFits:maximumLabelSize];
    _left.frame = CGRectMake(8,5, expectSize.width, actualHeight);
    _right.frame = CGRectMake(expectSize.width+13,5,width-16 - expectSize.width, actualHeight);

}

@end
