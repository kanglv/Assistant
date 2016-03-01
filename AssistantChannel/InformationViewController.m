//
//  InformationViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "InformationViewController.h"
#define MAINSCROLLHEIGHT self.view.bounds.size.height - 156

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"渠道信息";
    
    ////////////////////////////定义主页面//////////////////////////
    _mainScrollView.contentSize = CGSizeMake(WIDTH * 3, 0);
    
    //横向分割线
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, WIDTH/3, 2)];
    self.lineLabel.backgroundColor = [UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1];
    
    [self addMyButtons];
    [self addMyViews];
    [self.view addSubview:self.lineLabel];
}

- (void)addMyViews
{
    _Informationview = [[Information_baseView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, MAINSCROLLHEIGHT)];
    _Operateview = [[Operate_listView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, MAINSCROLLHEIGHT)];
    _RemunerationView = [[Remuneration_listView alloc]initWithFrame:CGRectMake(WIDTH * 2, 0, WIDTH, MAINSCROLLHEIGHT)];

    [_mainScrollView addSubview:_Informationview];
    [_mainScrollView addSubview:_Operateview];
    [_mainScrollView addSubview:_RemunerationView];
    
}

- (void)addMyButtons
{
    _button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH/3, 40)];
    [_button1 setTitle:@"基本信息" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
    
    _button2 = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/3, 0, WIDTH/3, 40)];
    [_button2 setTitle:@"运营状况" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1] forState:UIControlStateNormal];
    
    _button3 = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH/3)*2, 0, WIDTH /3, 40)];
    [_button3 setTitle:@"酬金数据" forState:UIControlStateNormal];
    [_button3 setTitleColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1] forState:UIControlStateNormal];

    
    _button1.titleLabel.font = [UIFont systemFontOfSize:13];
    _button2.titleLabel.font = [UIFont systemFontOfSize:13];
    _button3.titleLabel.font = [UIFont systemFontOfSize:13];

    
    
    _button1.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    _button2.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    _button3.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    
    _button1.tag = 1;
    _button2.tag = 2;
    _button3.tag = 3;
    
    
    [_button1 addTarget:self action:@selector(turn:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(turn:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(turn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [_titleScrollView addSubview:_button1];
    [_titleScrollView addSubview:_button2];
    [_titleScrollView addSubview:_button3];
    
    
}

#pragma mark ------- scrollView的滚动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self buttonBackgroundColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        _x = _mainScrollView.contentOffset.x;
        if(_x <= 0 )
        {
            
            [_button1 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
            
        }else if(_x > 0 && _x <= WIDTH)
        {

            [_button2 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];

        }
        else if((_x > WIDTH && _x <= 2 * WIDTH )|| _x > 2 * WIDTH)
        {
            [_button3 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
        }
        self.lineLabel.frame = CGRectMake( _x/self.mainScrollView.contentSize.width*WIDTH, 40, WIDTH/3, 2);
    }];

}

- (void)turn:(UIButton*)sender{

    [self buttonBackgroundColor];
    
    NSInteger i = sender.tag - 1;
    
    [_mainScrollView setContentOffset:CGPointMake(i * WIDTH, 0) animated:YES];
    
    _x = _mainScrollView.contentOffset.x;
    self.lineLabel.frame = CGRectMake( _x/self.mainScrollView.contentSize.width*WIDTH, 40, WIDTH/3, 2);

    switch (sender.tag) {
        case 1:
            [_button1 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
            break;
        case 2:
            [_button2 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
            break;
        case 3:
            [_button3 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)buttonBackgroundColor{
    
    [_button1 setTitleColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1] forState:UIControlStateNormal];
    [_button3 setTitleColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
