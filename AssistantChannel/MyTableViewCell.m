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
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [self.contentView addSubview:_nameLabel];
    
    _informLabel = [[UILabel alloc]init];
    _informLabel.textAlignment = NSTextAlignmentNatural;
    _informLabel.font = [UIFont fontWithName:@"Arial" size:12];
    _informLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_informLabel];
    
    _lineLabel = [[UILabel alloc]init];
    _lineLabel.text = @"";
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineLabel];
    
    _cacheLabel = [[UILabel alloc]init];
    _cacheLabel.textAlignment = NSTextAlignmentRight;
    _cacheLabel.textColor = [UIColor grayColor];
    _cacheLabel.font = [UIFont fontWithName:@"Arial" size:15];
    
}

- (void)layoutSubviews {
    
}


@end
