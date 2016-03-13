//
//  BottomView.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/12.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

@property (strong , nonatomic)UIButton *lastBtn,*nextBtn;
@property (strong , nonatomic)UILabel *indexLabel,*totalLabel,*lineLabel;
- (instancetype)initViewWithOneBtn:(CGRect)frame;
- (instancetype)initViewWithTwoBtn:(CGRect)frame;
@end
