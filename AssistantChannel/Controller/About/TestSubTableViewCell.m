//
//  TestSubTableViewCell.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/13.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "TestSubTableViewCell.h"

@implementation TestSubTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(15, (self.frame.size.height-16)/2, 16, 16)];
    _btn.backgroundColor = [UIColor whiteColor];
    _btn.layer.masksToBounds = YES;
    _btn.layer.borderWidth = 1;
    _btn.layer.borderColor = [UIColor blackColor].CGColor;
    _btn.layer.cornerRadius = 8;
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
