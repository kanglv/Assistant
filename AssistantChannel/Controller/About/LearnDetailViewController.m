//
//  LearnDetailViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/10.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "LearnDetailViewController.h"

@interface LearnDetailViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
{
    
    MBProgressHUD *HUD;
}
@property (nonatomic , strong) UIWebView *webView;

@end

@implementation LearnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",_url);
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:NO animated:YES];
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"信息详情";


    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.scalesPageToFit = YES; //自动对页面进行缩放
    _webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber; //自动检测网页上的电话号码，单击可以拨打
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [self loadWeb:_url];

    
}
- (void)loadWeb:(NSString *)urlStr{
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    HUD.hidden = YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}
- (void)backBtnClicked:(id)sender
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.hVC setNavigationBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
