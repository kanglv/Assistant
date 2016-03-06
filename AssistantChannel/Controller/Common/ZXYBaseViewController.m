//
//  ZXYBaseViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "ZXYBaseViewController.h"

@interface ZXYBaseViewController ()

@end

@implementation ZXYBaseViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (UIButton *)setNaviCommonBackBtn
{
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, self.navigationController.navigationBar.frame.size.height)];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(-10, 0, 57, 44);
    [btnView addSubview:leftBtn];
    
    
    [leftBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    
    
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self setNaviBarLeftView:btnView];
    
    return leftBtn;
}

- (UIButton *)setNaviRightBtnWithTitle:(NSString *)title
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self setNaviBarRightView:rightBtn];
    
    return rightBtn;
}

- (void)setNaviBackBtn:(UIButton *__strong*)backBtn andCloseBtn:(UIButton *__strong*)closeBtn
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 44);
    [backButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];

    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    closeButton.frame = CGRectMake(0, 0, 32, 44);
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:RGBCOLOR(153, 255, 255, 1) forState:UIControlStateHighlighted];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    *backBtn = backButton;
    
    *closeBtn = closeButton;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
}

- (void)setNaviBarLeftView:(UIView *)view;
{
    if (view) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)setNaviBarRightView:(UIView *)view
{
    if (view) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
