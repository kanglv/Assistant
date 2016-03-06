//
//  NewsContentViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "NewsContentViewController.h"
#import "MBProgressHUD.h"

@interface NewsContentViewController ()<MBProgressHUDDelegate,UIWebViewDelegate>
{
    MBProgressHUD *HUD;
}

@end

@implementation NewsContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"公告详情";
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    NSString *url = [NSString stringWithFormat:@"%@",self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    _webView.delegate = self;
    
    [_webView loadRequest:request];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [HUD hide:YES];
}
#pragma mark - ButtonMethod
- (void)backBtnClicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
