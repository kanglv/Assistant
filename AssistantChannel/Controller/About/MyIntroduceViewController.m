//
//  MyIntroduceViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/8.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyIntroduceViewController.h"

@interface MyIntroduceViewController ()

@end

@implementation MyIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backbutton addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *clientInfoDict =[[NSBundle mainBundle] infoDictionary];
    NSString *clientVersion = clientInfoDict[@"CFBundleShortVersionString"];
    self.visson.text = [NSString stringWithFormat:@"当前版本：%@",clientVersion];
    
    self.titleLabel.text = @"      渠道助手是一款关联渠道经理与渠道商之间工作的软件，主要功能有渠道信息／渠道运营状况／酬金数据的展示和管理，巡检走访活动的管理、物料支撑和公告通知。\n      通过使用本软件，可以使得渠道经理和渠道商的沟通更加方便快捷，有效的提高渠道管理的效率，也更加方便于主管对渠道经理和渠道商的工作绩效管理。\n      V1.1版本新增“学习园地”模块，主管可以在后台发布各种学习资料，并可以组织考试，包括发布考题、规定考试时间等，渠道经理在规定的时间内作答，完成后提交，可立刻看到考试成绩。";
    
}

- (void)backBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
