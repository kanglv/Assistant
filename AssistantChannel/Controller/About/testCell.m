//
//  testCell.m
//  AssistantChannel
//
//  Created by bqmm-lk on 16/3/14.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "testCell.h"

@implementation testCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height)];
    _btn.backgroundColor = [UIColor whiteColor];
    [_btn setBackgroundImage:[UIImage imageNamed:@"ico_norinform"] forState:UIControlStateNormal];
    [_btn setBackgroundImage:[UIImage imageNamed:@"ico_inform"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_btn];
    
    _answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, self.frame.size.width-55, self.frame.size.height)];
    _answerLabel .textAlignment = NSTextAlignmentLeft;
    _answerLabel.numberOfLines = 0;
    _answerLabel .lineBreakMode = NSLineBreakByWordWrapping;
    [ _answerLabel  setTextColor:[UIColor blackColor]];
    _answerLabel .font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview: _answerLabel];
}

@end
