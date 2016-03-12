//
//  PracticeCell.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/10.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "PracticeCell.h"

@implementation PracticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _title = [[UILabel alloc]init];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.lineBreakMode = NSLineBreakByTruncatingTail;
    _title.textColor = [UIColor blackColor];
    _title.numberOfLines = 0;
    _title.font = [UIFont fontWithName:@"Arial" size:18];
    [self.contentView addSubview:_title];
    
    _person = [[UILabel alloc]init];
    _person.textAlignment = NSTextAlignmentLeft;
    _person.lineBreakMode = NSLineBreakByTruncatingTail;
    [_person setTextColor:[UIColor blackColor]];
    _person.font = [UIFont fontWithName:@"Arial" size:15];
    _person.text = @"创  建  者 :";
    [self.contentView addSubview:_person];
    
    _personName = [[UILabel alloc]init];
    _personName.textAlignment = NSTextAlignmentLeft;
    _personName.lineBreakMode = NSLineBreakByTruncatingTail;
    [_personName setTextColor:[UIColor blackColor]];
    _personName.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_personName];
    
    _craetTime = [[UILabel alloc]init];
    _craetTime.textAlignment = NSTextAlignmentLeft;
    _craetTime.lineBreakMode = NSLineBreakByTruncatingTail;
    [_craetTime setTextColor:[UIColor blackColor]];
    _craetTime.font = [UIFont fontWithName:@"Arial" size:15];
    _craetTime.text =   @"开始时间 :";
    [self.contentView addSubview:_craetTime];
    
    
    _time = [[UILabel alloc]init];
    _time.textAlignment = NSTextAlignmentLeft;
    _time.lineBreakMode = NSLineBreakByTruncatingTail;
    [_time setTextColor:[UIColor blackColor]];
    _time.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_time];
    
    _endTime = [[UILabel alloc]init];
    _endTime .textAlignment = NSTextAlignmentLeft;
    _endTime .lineBreakMode = NSLineBreakByTruncatingTail;
    [_endTime  setTextColor:[UIColor blackColor]];
    _endTime .font = [UIFont fontWithName:@"Arial" size:15];
    _endTime.text =   @"结束时间 :";
    [self.contentView addSubview:_endTime];
    
    _eTime = [[UILabel alloc]init];
    _eTime.textAlignment = NSTextAlignmentLeft;
    _eTime.lineBreakMode = NSLineBreakByTruncatingTail;
    [_eTime setTextColor:[UIColor blackColor]];
    _eTime.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_eTime];
    
    _lineLabel = [[UILabel alloc]init];
    _lineLabel.text = @"";
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineLabel];
    
    _arrowView = [[UIImageView alloc]init];
    _arrowView.image = [UIImage imageNamed:@"arrows_right"];
    [self.contentView addSubview:_arrowView];
    
    _scorelabel = [[UILabel alloc]init];
    _scorelabel.textAlignment = NSTextAlignmentCenter;
    _scorelabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_scorelabel setTextColor:[UIColor blackColor]];
    _scorelabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_scorelabel];

    _score = [[UILabel alloc]init];
    _score.textAlignment = NSTextAlignmentCenter;
    _score.lineBreakMode = NSLineBreakByTruncatingTail;
    [_score setTextColor:[UIColor blackColor]];
    _score.font = [UIFont fontWithName:@"Arial" size:18];
    [self.contentView addSubview:_score];
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat actualHeight = height-10;
    _title.frame = CGRectMake(8, 5, width-16, actualHeight*2/5);
    CGSize maximumLabelSize = CGSizeMake(150, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_person sizeThatFits:maximumLabelSize];
    _person.frame = CGRectMake(8,actualHeight*2/5+5, expectSize.width, actualHeight/5);
    
    _personName.frame =CGRectMake(expectSize.width+13, actualHeight*2/5+5, width-16 - expectSize.width, actualHeight/5);
    
    _craetTime.frame = CGRectMake(8, actualHeight*3/5+5, expectSize.width, actualHeight/5);
    _time.frame = CGRectMake(expectSize.width+13, actualHeight*3/5+5, width-16 - expectSize.width, actualHeight/5);
    
    _endTime.frame = CGRectMake(8, actualHeight*4/5+5, expectSize.width, actualHeight/5);
    _eTime.frame = CGRectMake(expectSize.width+13, actualHeight*4/5+5, width-16 - expectSize.width, actualHeight/5);
    CGFloat onePixel = 1 / [[UIScreen mainScreen] scale];
    _lineLabel.frame = CGRectMake(0, height-onePixel, width, onePixel);
    
    _arrowView.frame = CGRectMake(width-30, (height-10)/2, 10, 10);
    
    _scorelabel.frame = CGRectMake(width-expectSize.width-35, actualHeight*2/5, expectSize.width, actualHeight/5);
    _scorelabel.frame = CGRectMake(width-expectSize.width-35, actualHeight*3/5, expectSize.width, actualHeight*2/5);
    
    
}

@end
