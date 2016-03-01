//
//  FilterDateView.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/26.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "NIDropDown.h"

@class FilterDateView;
@protocol FilterDateViewDelegate <NSObject>

@optional
- (void)filterDateView:(FilterDateView *)view didSelectCateIndex:(int)index;

@end

@interface FilterDateView : UIView

@property (strong, nonatomic) UIButton *cateBtn;
@property (strong, nonatomic) UITextField *seachTextField;
@property(nonatomic, weak) id<FilterDateViewDelegate> delegate;

- (instancetype)initWithCategory:(NSArray *)cateArr startDate:(NSString *)startDate endDate:(NSString *)endDate;

@end
