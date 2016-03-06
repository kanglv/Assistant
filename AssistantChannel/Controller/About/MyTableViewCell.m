//
//  MyTableViewCell.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _imgView = [[UIImageView alloc]init];
    [self.contentView addSubview:_imgView];
    
    _arrowView = [[UIImageView alloc]init];
    _arrowView.image = [UIImage imageNamed:@"arrows_right"];
    [self.contentView addSubview:_arrowView];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_nameLabel];
    
    _informLabel = [[UILabel alloc]init];
    _informLabel.textAlignment = NSTextAlignmentNatural;
    _informLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _informLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _informLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_informLabel];
    
    _lineLabel = [[UILabel alloc]init];
    _lineLabel.text = @"";
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineLabel];
    
    _cacheLabel = [[UILabel alloc]init];
    _cacheLabel.textAlignment = NSTextAlignmentRight;
    _cacheLabel.textColor = [UIColor blueColor];
    _cacheLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_cacheLabel];
    
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGSize maximumLabelSize = CGSizeMake(100, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_nameLabel sizeThatFits:maximumLabelSize];
    _imgView.frame = CGRectMake(12,height/3 , height/3, height/3);
    _nameLabel.frame = CGRectMake(22+height/3,height/3 , expectSize.width, expectSize.height);
    _informLabel.frame = CGRectMake(22+height/3+expectSize.width,height/3-10 , 20, 20);
    _lineLabel.frame = CGRectMake(22+height/3, height-1, width-(22+height/3), 1);
    _cacheLabel.frame = CGRectMake(width-100, height/3,40 ,height/3 );
    _arrowView.frame = CGRectMake(width-50, (height-20)/2, 20, 20);

}





@end