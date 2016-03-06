//
//  MyIntroduceViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyIntroduceViewController.h"

@interface MyIntroduceViewController ()

@end

@implementation MyIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}
- (void)initView{
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextView *aboutMe = [[UITextView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/5+40, self.view.frame.size.width-40, self.view.frame.size.height*2/5+10)];
    aboutMe.text = @"内容来源最丰富，涵盖微博，新闻，热点,建立最人性化的推送机制。ForU基于“今日头条”模式，涵盖微博，新闻，知乎日报精选等多个热门门户的内容，用户不必去多个APP查看今日热点事件，只需ForU一个APP即可查看所有热门新闻，打造史上内容最丰富的APP。ForU的最大功能是根据用户的阅读习惯，慢慢为用户精选出用户最喜欢的新闻内容，为用户建立一个模型，让用户对此APP爱不释。";
    aboutMe.textColor = [UIColor grayColor];
    aboutMe.font = [UIFont systemFontOfSize:15];
    aboutMe.editable = NO;//不可编辑
    aboutMe.scrollEnabled = NO;//不可滑动
    aboutMe.userInteractionEnabled = NO;//用户不能交互
    [self.view addSubview:aboutMe];
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
