//
//  tableViewHeader.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@class tableViewHeader;
@protocol tableViewHeaderDelegate <NSObject>

- (void)tableViewHeaderrDateView:(tableViewHeader *)view didSelectCateIndex:(int)index;

@end

@interface tableViewHeader : UIView

@property (strong, nonatomic) UIButton *cateBtn;
@property (strong, nonatomic) UITextField *searchText;
@property (strong, nonatomic) UIButton *searchBtn;
@property (strong, nonatomic) UIButton *DateBtn;

@property(nonatomic, strong) NSArray *cateArr;
@property (nonatomic, strong)NIDropDown *dropDown;

@property(nonatomic, weak) id<tableViewHeaderDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrameanSearch:(CGRect)frame;

- (id)initWithFrameanDate:(CGRect)frame;

@end
