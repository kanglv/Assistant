//
//  MyStudyViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/9.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyStudyViewController.h"

#define MAINSCROLLHEIGHT SCREEN_HEIGHT - 186

@interface MyStudyViewController ()<UIScrollViewDelegate>

@end

@implementation MyStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"学习园地";
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _titleScrollView.delegate=self;
    _titleScrollView.pagingEnabled=YES; //分页效果
    _titleScrollView.showsHorizontalScrollIndicator=NO; //隐藏水平滚动条
    _titleScrollView.contentSize=CGSizeMake(self.view.frame.size.width,self.view.frame.size.height ); //设置滚动范围
    [self.view addSubview:_titleScrollView];
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    _mainScrollView.delegate=self;
    _mainScrollView.pagingEnabled=YES; //分页效果
    _mainScrollView.showsHorizontalScrollIndicator=NO; //隐藏水平滚动条
     _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    [self.view addSubview:_mainScrollView];

    
    //横向分割线
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/3, 2)];
    self.lineLabel.backgroundColor = [UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1];
    
    [self addMyButtons];
    [self addMyViews];
    [self addMyTables];
    [self.view addSubview:self.lineLabel];
}

- (void)addMyViews
{
    
    _learnview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    _practiceview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    _testView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    
    
    [_mainScrollView addSubview:_learnview];
    [_mainScrollView addSubview:_practiceview];
    [_mainScrollView addSubview:_testView];
    
}

- (void)addMyTables
{
    
    
    UserEntity *userEntity = [UserEntity sharedInstance];
    
    NSLog(@"%@",userEntity.roles);
    if ([userEntity.roles isEqualToString:@"13"]) {
        
        
    }
    
    _learnTableView = [[LearningViewController alloc]init];
    [_learnTableView.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    [_learnview addSubview:_learnTableView.view];
    
    
    _practiceTableView = [[PracticeViewController alloc]init];
                          
     [_practiceTableView.view setFrame:  CGRectMake(0, 0, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    [_practiceview addSubview:_practiceTableView.view];
    
    _testTableView = [[TestViewController alloc]init];
    [_testTableView.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAINSCROLLHEIGHT)];
    [_testView addSubview:_testTableView.view];
}


- (void)addMyButtons
{
    _button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 40)];
    [_button1 setTitle:@"知识库" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
    
    _button2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40)];
    [_button2 setTitle:@"练习" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1] forState:UIControlStateNormal];
    
    _button3 = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)*2, 0, SCREEN_WIDTH /3, 40)];
    [_button3 setTitle:@"考试中心" forState:UIControlStateNormal];
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
            
        }else if(_x > 0 && _x <= SCREEN_WIDTH)
        {
            
            [_button2 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
            
        }
        else if((_x > SCREEN_WIDTH && _x <= 2 * SCREEN_WIDTH )|| _x > 2 * SCREEN_WIDTH)
        {
            [_button3 setTitleColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1] forState:UIControlStateNormal];
        }
        self.lineLabel.frame = CGRectMake( _x/self.mainScrollView.contentSize.width*SCREEN_WIDTH, 40, SCREEN_WIDTH/3, 2);
    }];
    
}

- (void)turn:(UIButton*)sender{
    
    [self.view endEditing:YES];
    
    [self buttonBackgroundColor];
    
    NSInteger i = sender.tag - 1;
    
    [_mainScrollView setContentOffset:CGPointMake(i * SCREEN_WIDTH, 0) animated:YES];
    
    _x = _mainScrollView.contentOffset.x;
    self.lineLabel.frame = CGRectMake( _x/self.mainScrollView.contentSize.width*SCREEN_WIDTH, 40, SCREEN_WIDTH/3, 2);
    
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

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
