//
//  LearnCell.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/10.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "LearnCell.h"

@implementation LearnCell

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
    _person.text = @"发  布  人 :";
    [self.contentView addSubview:_person];
    
    _personName = [[UILabel alloc]init];
    _personName.textAlignment = NSTextAlignmentLeft;
    _personName.lineBreakMode = NSLineBreakByTruncatingTail;
    [_personName setTextColor:[UIColor blackColor]];
    _personName.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_personName];
    
    _date = [[UILabel alloc]init];
    _date.textAlignment = NSTextAlignmentLeft;
    _date.lineBreakMode = NSLineBreakByTruncatingTail;
    [_date setTextColor:[UIColor blackColor]];
    _date.font = [UIFont fontWithName:@"Arial" size:15];
    _date.text =   @"发布日期 :";
    [self.contentView addSubview:_date];
    
                  
    _time = [[UILabel alloc]init];
    _time.textAlignment = NSTextAlignmentLeft;
    _time.lineBreakMode = NSLineBreakByTruncatingTail;
    [_time setTextColor:[UIColor blackColor]];
    _time.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_time];
    
    _type = [[UILabel alloc]init];
    _type .textAlignment = NSTextAlignmentLeft;
    _type .lineBreakMode = NSLineBreakByTruncatingTail;
    [_type  setTextColor:[UIColor blackColor]];
    _type .font = [UIFont fontWithName:@"Arial" size:15];
    _type.text =   @"发      布 :";
    [self.contentView addSubview:_type];
    
    _type1 = [[UILabel alloc]init];
    _type1.textAlignment = NSTextAlignmentLeft;
    _type1.lineBreakMode = NSLineBreakByTruncatingTail;
    [_type1 setTextColor:[UIColor blackColor]];
    _type1.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_type1];
    
    _lineLabel = [[UILabel alloc]init];
    _lineLabel.text = @"";
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineLabel];
    
    _arrowView = [[UIImageView alloc]init];
    _arrowView.image = [UIImage imageNamed:@"arrows_right"];
    [self.contentView addSubview:_arrowView];
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat actualHeight = height-10;
    _title.frame = CGRectMake(8, 5, width-16, actualHeight*2/5);
    CGSize maximumLabelSize = CGSizeMake(100, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_person sizeThatFits:maximumLabelSize];
    _person.frame = CGRectMake(8,actualHeight*2/5+5, expectSize.width, actualHeight/5);
    
    _personName.frame =CGRectMake(expectSize.width+13, actualHeight*2/5+5, width-16 - expectSize.width, actualHeight/5);
    
    _date.frame = CGRectMake(8, actualHeight*3/5+5, expectSize.width, actualHeight/5);
    _time.frame = CGRectMake(expectSize.width+13, actualHeight*3/5+5, width-16 - expectSize.width, actualHeight/5);
    
    _type.frame = CGRectMake(8, actualHeight*4/5+5, expectSize.width, actualHeight/5);
    _type1.frame = CGRectMake(expectSize.width+13, actualHeight*4/5+5, width-16 - expectSize.width, actualHeight/5);
    CGFloat onePixel = 1 / [[UIScreen mainScreen] scale];
    _lineLabel.frame = CGRectMake(0, height-onePixel, width, onePixel);
    
     _arrowView.frame = CGRectMake(width-30, (height-10)/2, 10, 10);
    
    
}

@end
