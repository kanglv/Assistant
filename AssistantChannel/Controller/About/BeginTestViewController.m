//
//  BeginTestViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/12.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "BeginTestViewController.h"
#import "BottomView.h"
#import "testCell.h"
@interface BeginTestViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UserEntity *userEntity;
   
}

@property (strong,nonatomic)UITableView *table;
@property (strong,nonatomic)UILabel *titleLabel,*informLabel,*timeLabel;
@property  int currentPage,numberOfPages;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)BottomView *bottomView;
@end

@implementation BeginTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = _topTitle;
    
    userEntity = [UserEntity sharedInstance];
    //获取练习信息
    NSString * str = [NSString stringWithFormat:@"%i",_testId];
    [self getTestQuestions:str];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30) ];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = _hastitle;
    _titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [self.view addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 20)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    [self.view addSubview:_timeLabel];
    
    [self reflashGetKeyBt:@"3600"];
    
    

}

- (void)initSubviews{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-90) style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = NO;
    [self.view addSubview:_table];
    
}

- (void)initBottomView :(int)indexpage{
    if(_bottomView){
        [_bottomView removeFromSuperview];
    }
    if(indexpage == 1){
        _bottomView = [[BottomView alloc]initViewWithOneBtn:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
        [_bottomView.nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
        _bottomView.totalLabel.text = [NSString stringWithFormat:@"%i",_numberOfPages];
        [self.view addSubview:_bottomView];
    }else{
        _bottomView = [[BottomView alloc]initViewWithTwoBtn:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
        _bottomView.indexLabel.text = [NSString stringWithFormat:@"%i",_currentPage];
        _bottomView.totalLabel.text = [NSString stringWithFormat:@"%i",_numberOfPages];
        [_bottomView.lastBtn addTarget:self action:@selector(lastClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
        if(_currentPage == _numberOfPages){
            [_bottomView.nextBtn setTitle:@"提交答案" forState:UIControlStateNormal];
        }
        [self.view addSubview:_bottomView];
    }
}


- (void)relaodData:(int)indexpage{
    [_table reloadData];
    [self initBottomView:_currentPage];
}
- (void)lastClick{
    if(_currentPage>0){
        _currentPage--;
        [self relaodData:_currentPage];
    }
    
}
- (void)nextClick:(UIButton *)sender{
    //点击page＋1
    if(_currentPage<_numberOfPages){
        _currentPage++;
        //数据刷新
        [self relaodData:_currentPage];
        
    }else if(_currentPage == _numberOfPages){
        //提交答案
    }
    
    
}

- (void)reflashGetKeyBt:(NSString *)time{
    if ([time integerValue] == 0){
        //提示时间到，点击确定，提交答卷，退出考试
        
    }
    
    else{
        int min = [time intValue]/60 ;
        int second = [time integerValue]%60;
        self.timeLabel.text = [NSString stringWithFormat:@"距离考试结束还有: %d:%d分钟",min,second];
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:[time intValue]-1] afterDelay:1];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger ret = 5;
    if (_currentPage == _numberOfPages) {
        if(_dataArr.count%5 == 0){
            ret=5;
        }else{
            ret = _dataArr.count%5;
        }
    }
    return ret;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"section:%ld",section);
    NSInteger actualSection = (_currentPage-1)*5+section;
    NSMutableDictionary *dic1 = _dataArr[actualSection];
    NSArray *answer = [dic1 objectForKey:@"content"];
    NSLog(@"rows:%ld",(long)answer.count);
    return answer.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 10)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     NSInteger actualSection = (_currentPage-1)*5+section;
    NSLog(@"actualSection: %ld",(long)actualSection);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 120)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(10,10 ,60, 30)];
    left .textAlignment = NSTextAlignmentLeft;
    left .lineBreakMode = NSLineBreakByTruncatingTail;
    [ left  setTextColor:[UIColor blackColor]];
    left .font = [UIFont fontWithName:@"Arial" size:18];
    left.text = [NSString stringWithFormat:@"第%ld题 :",(long)actualSection+1];
    [view addSubview: left];
    
    UILabel *right = [[UILabel alloc]initWithFrame: CGRectMake(80,10 ,view.frame.size.width-60, 100)];
    right .textAlignment = NSTextAlignmentLeft;
    right.numberOfLines = 0;
    right .lineBreakMode = NSLineBreakByWordWrapping;
    [ right  setTextColor:[UIColor blackColor]];
    right .font = [UIFont fontWithName:@"Arial" size:18];
    right.text = [NSString stringWithFormat:@"%@", [_dataArr[actualSection] objectForKey:@"title"]];
    [view addSubview: right];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"test";
    testCell  *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[testCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NSLog(@"index %ld",(long)indexPath.section);
    NSInteger actualsection = indexPath.section+(_currentPage-1)*5;
    NSMutableDictionary *dic = _dataArr[actualsection];
    NSArray * arr = [dic objectForKey:@"content"];
    cell.answerLabel.text = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:indexPath.row] objectForKey:@"option_title"]] ;
    [cell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)click:(UIButton *)sender{
    NSLog(@"rgaerh");
}

//获取考试结果
- (void)getScore:(NSString *)testId{
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"exam_grade",@"a",
                           userEntity.sn,@"sn",
                           testId ,@"id",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
        }
    } Failed:^(int errorCode, NSString *message) {
        
    }];

}


//提交答案
- (void)postAnswer:(NSString *)testId andAnswer:(NSString *)answer{
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"answer_exam",@"a",
                           userEntity.sn,@"sn",
                           testId ,@"id",
                           answer,@"answer",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
        }
    } Failed:^(int errorCode, NSString *message) {
        
    }];

}

//获取试卷题目
- (void)getTestQuestions:(NSString *)testId{
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"create_exam",@"a",
                           userEntity.sn,@"sn",
                           testId ,@"id",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            _dataArr = [dic objectForKey:@"ls"];
            NSLog(@"----------%@",_dataArr[0]);
            if(_dataArr.count%5==0){
                _numberOfPages = (int)[_dataArr count]/5 ;
            }else{
                _numberOfPages = ceilf(_dataArr.count/5)+1;
            }
            _currentPage = 1;
            [self initSubviews];
            [self initBottomView:_currentPage];
         
        }else{
        }
    } Failed:^(int errorCode, NSString *message) {
        
    }];
}

- (void)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
