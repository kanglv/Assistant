//
//  MyStudyViewController.h
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningViewController.h"
#import "PracticeViewController.h"
#import "TestViewController.h"

@interface MyStudyViewController : ZXYBaseViewController
@property (strong, nonatomic)  UIScrollView *titleScrollView;

@property (strong, nonatomic)  UIScrollView *mainScrollView;

@property (nonatomic,strong) UILabel *lineLabel;

@property (nonatomic,assign) CGFloat x ;

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;

@property (nonatomic,strong) UIView *learnview;
@property (nonatomic,strong) UIView *practiceview;
@property (nonatomic,strong) UIView *testView;

@property (nonatomic,strong) LearningViewController *learnTableView;
@property (nonatomic,strong) PracticeViewController *practiceTableView;
@property (nonatomic,strong) TestViewController *testTableView;

@end
