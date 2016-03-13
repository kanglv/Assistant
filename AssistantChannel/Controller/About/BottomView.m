//
//  BottomView.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/12.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "BottomView.h"
@interface BottomView ()

@end
@implementation BottomView
- (instancetype)initViewWithOneBtn:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        _indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 10, self.frame.size.height-10)];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.text= @"1";
        _indexLabel.textColor = [UIColor blackColor];
        _indexLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_indexLabel];
        
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 5, self.frame.size.height-10)];
        _lineLabel.text = @"/";
        _lineLabel.textAlignment = NSTextAlignmentCenter;
        _lineLabel.textColor = [UIColor blackColor];
        _lineLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_lineLabel];
        
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 10, self.frame.size.height-10)];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.textColor = [UIColor blackColor];
        _totalLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_totalLabel];

        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 5, self.frame.size.width-60, self.frame.size.height-10)];
        _nextBtn.backgroundColor= [UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1];
        [_nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_nextBtn];
    }
    return self;

    
}

- (instancetype)initViewWithTwoBtn:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self){
        _lastBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, (self.frame.size.width-65)/2, self.frame.size.height-10)];
        _lastBtn.backgroundColor= [UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1];
        [_lastBtn setTitle:@"上一页" forState:UIControlStateNormal];
        _lastBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_lastBtn];

        
        _indexLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-65)/2+20, 5, 10, self.frame.size.height-10)];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.textColor = [UIColor blackColor];
        _indexLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_indexLabel];
        
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-65)/2+30, 5, 5, self.frame.size.height-10)];
        _lineLabel.text = @"/";
        _lineLabel.textAlignment = NSTextAlignmentCenter;
        _lineLabel.textColor = [UIColor blackColor];
        _lineLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_lineLabel];
        
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-65)/2+35, 5, 10, self.frame.size.height-10)];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.textColor = [UIColor blackColor];
        _totalLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_totalLabel];
        
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width-65)/2-10,5, (self.frame.size.width-65)/2, self.frame.size.height-10)];
        _nextBtn.backgroundColor= [UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1];
        [_nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        [self addSubview:_nextBtn];
    }
    return self;

    
}
@end
