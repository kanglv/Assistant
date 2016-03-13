//
//  DetailViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/12.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "BeginTestViewController.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UserEntity *userEntity;
}
@property (strong,nonatomic)UITableView *table;
@property (strong,nonatomic)NSMutableArray *defaultArr,*dataArr;
@property (strong,nonatomic)UIButton *button;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = _hastitle;
//    _dataDic = [[NSMutableDictionary alloc]init];

    [self initData];
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = NO;
    _table.scrollEnabled = NO;
    [self.view addSubview:_table];
}

- (BOOL)hadTest{
    if(_dataDic){
        return YES;
    }
    return NO;
}

- (void)initData{
    _defaultArr = [[NSMutableArray alloc]init];
    [_defaultArr addObject:@"名       称 :"];
    [_defaultArr addObject:@"创  建 者 :"];
    [_defaultArr addObject:@"开始时间 :"];
    [_defaultArr addObject:@"结束时间 :"];
    [_defaultArr addObject:@"考试时长 :"];
    [_defaultArr addObject:@"题       数 :"];
    if(_test){
        [_defaultArr addObject:@"正       确 :"];
        [_defaultArr addObject:@"错       误 :"];
        [_defaultArr addObject:@"得       分 :"];
        [_defaultArr addObject:@"排       名 :"];
    }

    _dataArr = [[NSMutableArray alloc]init];
    [_dataArr addObject:[_dic objectForKey:@"title"]];
    [_dataArr addObject:[_dic objectForKey:@"nickname"]];
    [_dataArr addObject:[self transTime:[_dic objectForKey:@"begin_time"]]];
    [_dataArr addObject:[self transTime:[_dic objectForKey:@"end_time"]]];
    NSString *time = [NSString stringWithFormat:@"%d",[[_dic objectForKey:@"seconds"] intValue]/60];
    [_dataArr addObject:time];
    [_dataArr addObject:[NSString stringWithFormat:@"%@", [_dic objectForKey:@"num"]]];
    if(_test){
        [_dataArr addObject:[NSString stringWithFormat:@"%i",[[_dataDic objectForKey:@"right_num"] intValue]] ];
        [_dataArr addObject:[NSString stringWithFormat:@"%i",[[_dataDic objectForKey:@"error_num"] intValue]]];
        [_dataArr addObject:[NSString stringWithFormat:@"%i",[[_dataDic objectForKey:@"total_grade"] intValue]]];
        if ([[_dataDic objectForKey:@"rank_status"]intValue] == 0) {
            NSString *str1 = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"grade_rank"]];
            NSString * str = [str1 stringByAppendingString:@"[临时排名]"];
            [_dataArr addObject:str];
        }else{
            [_dataArr addObject:[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"grade_rank"]]];
        }
    }
}
- (void)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if([self comparetime:[_dic objectForKey:@"end_time"]]){
//        return 0;
//    }else {
//        return 0;
//    }
//}


//如果可以考试，显示foot
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = nil;
    
    if([self comparetime:[_dic objectForKey:@"end_time"]]&&![self hadTest]){
        view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*50/667)];
        self.button=[[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width/3, 40, view.frame.size.width/3, view.frame.size.height-10)];
        [self.button setTitle:_btnText forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [self.button setBackgroundColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1]];
        [self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        self.button.tag=2;
        [view addSubview:self.button];
    }
    return view;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _defaultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"tab1";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }

    cell.left.text = _defaultArr[indexPath.row];
    cell.right.text = _dataArr[indexPath.row];
    return cell;

}


- (void)click{
    userEntity = [UserEntity sharedInstance];
    if([userEntity.roles isEqualToString:@"12"]){
        BeginTestViewController *btvc = [[BeginTestViewController alloc]init];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        btvc.testId  = [[_dic objectForKey:@"id" ] intValue];
        btvc.hastitle = [_dic objectForKey:@"title" ];
        btvc.topTitle = _topText;
        [app.hVC pushViewController:btvc animated:YES];
    }else {
        ALERT_ERR_MSG(@"不具备考试资格");
    }
}

//时间戳转时间
-(NSString *)transTime:(NSString *)timeStamp{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    NSDate *datea = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSString *dateString = [formatter stringFromDate:datea];
    return dateString;
}

- (BOOL)comparetime:(NSString *)date{
    BOOL ret = NO;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    if([date doubleValue] > a){
        ret = YES;
    }
    return ret;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
