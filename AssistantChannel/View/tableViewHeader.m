//
//  tableViewHeader.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "tableViewHeader.h"

@interface tableViewHeader ()<NIDropDownDelegate>

@end

@implementation tableViewHeader

@synthesize dropDown;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    if (self) {
  
        self.cateArr = pagesArray;
        self.cateBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 120, 30)];
        self.cateBtn.backgroundColor = [UIColor whiteColor];
        self.cateBtn.layer.cornerRadius = 8;
        self.cateBtn.layer.masksToBounds = YES;
        [self.cateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.cateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cateBtn setTitle:pagesArray[0] forState:UIControlStateNormal];
        [self.cateBtn addTarget:self action:@selector(cateBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cateBtn];
        

        self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(135, 5, frame.size.width - 140, 30)];
        self.searchText.font = [UIFont systemFontOfSize:14];
        self.searchText.placeholder = @"渠道名称";
        self.searchText.layer.cornerRadius = 8;
        self.searchText.layer.masksToBounds = YES;
        self.searchText.backgroundColor = [UIColor whiteColor];
        self.searchText.returnKeyType = UIReturnKeySearch;
        self.searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 24, 30)];
        self.searchText.leftView = paddingView;
        self.searchText.leftViewMode = UITextFieldViewModeAlways;
 
        [self addSubview:self.searchText];
        
        UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 5, 20, 20)];
        
        searchImg.image = [UIImage imageNamed:@"img_group_search"];
    
        [self.searchText addSubview:searchImg];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    if (self) {
        
        self.DateBtn = [[UIButton alloc]initWithFrame:CGRectMake((VIEWWIDTH - 268)/2, 5, 268, 30)];
        self.DateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.DateBtn setImage:[UIImage imageNamed:@"rili"] forState:UIControlStateNormal];
        [self.DateBtn setTitle:@"2016-01-01--2016-02-29" forState:UIControlStateNormal];
        [self addSubview:self.DateBtn];
        
        self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(5, 40, frame.size.width - 10, 30)];
        self.searchText.font = [UIFont systemFontOfSize:14];
        self.searchText.placeholder = @"渠道名称";
        self.searchText.layer.cornerRadius = 8;
        self.searchText.layer.masksToBounds = YES;
        self.searchText.backgroundColor = [UIColor whiteColor];
        self.searchText.returnKeyType = UIReturnKeySearch;
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 24, 30)];
        self.searchText.leftView = paddingView;
        self.searchText.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:self.searchText];
        
        UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 5, 20, 20)];
        
        searchImg.image = [UIImage imageNamed:@"img_group_search"];
        
        [self.searchText addSubview:searchImg];
        
        self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEWWIDTH - 75, 35, 70, 40)];
        [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [self.searchBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
        self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self.searchBtn setHighlighted:YES];
        
        [self addSubview:self.searchBtn];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(VIEWWIDTH - 77, 40, 2, 30)];
        
        line.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
        
        [self addSubview:line];
    }
    return self;
}

- (id)initWithFrameanSearch:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    if (self) {
        
        self.searchText = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, frame.size.width - 10, 30)];
        self.searchText.font = [UIFont systemFontOfSize:14];
        self.searchText.placeholder = @"渠道名称";
        self.searchText.layer.cornerRadius = 8;
        self.searchText.layer.masksToBounds = YES;
        self.searchText.backgroundColor = [UIColor whiteColor];
        self.searchText.returnKeyType = UIReturnKeySearch;
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 24, 30)];
        self.searchText.leftView = paddingView;
        self.searchText.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:self.searchText];
        
        UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 5, 20, 20)];
        
        searchImg.image = [UIImage imageNamed:@"img_group_search"];
        
        [self.searchText addSubview:searchImg];
        
        self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEWWIDTH - 75, 0, 70, 40)];
        [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [self.searchBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
        self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self.searchBtn setHighlighted:YES];
        
        [self addSubview:self.searchBtn];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(VIEWWIDTH - 77, 5, 2, 30)];
        
        line.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
        
        [self addSubview:line];
        
    }
    return  self;
}

- (id)initWithFrameanDate:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1];
    if (self) {
        
        self.DateBtn = [[UIButton alloc]initWithFrame:CGRectMake((VIEWWIDTH - 268)/2, 5, 268, 30)];
        self.DateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.DateBtn setImage:[UIImage imageNamed:@"rili"] forState:UIControlStateNormal];
        [self.DateBtn setTitle:@"2016-01-01--2016-02-29" forState:UIControlStateNormal];
        [self addSubview:self.DateBtn];
        
    }
    return  self;
    
}

- (void)cateBtnClicked:(id)sender
{
    CGFloat height = 40*self.cateArr.count;
    
    if (!dropDown) {
        dropDown = [[NIDropDown alloc] showDropDown:sender height:&height titleArr:self.cateArr imgArr:nil direction:@"down"];
        dropDown.delegate = self;
    }else{
        [dropDown hideDropDown:self.cateBtn];
        dropDown = nil;
    }
}

#pragma mark - NIDropDownDelegate

- (void)niDropDownDelegateMethod:(NIDropDown *)sender didSelectIndex:(int)index
{
    //    [self.cateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cateBtn setTitle:self.cateArr[index] forState:UIControlStateNormal];
    
    [dropDown hideDropDown:self.cateBtn];
    dropDown = nil;
    
    if ([self.delegate respondsToSelector:@selector(tableViewHeaderrDateView:didSelectCateIndex:)]) {
        [self.delegate tableViewHeaderrDateView:self didSelectCateIndex:index];
    }
}

@end
