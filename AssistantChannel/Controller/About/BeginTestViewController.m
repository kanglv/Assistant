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
@property (strong,nonatomic)UILabel *right;
@property (strong,nonatomic)NSMutableDictionary *userAnswerDic,*rightAnswerDic,*userAnswerStringDic;
@property BOOL postAnswer;
@end

@implementation BeginTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = _topTitle;
    _userAnswerDic = [[NSMutableDictionary alloc]init];
    _rightAnswerDic = [[NSMutableDictionary alloc]init];
    _userAnswerStringDic = [[NSMutableDictionary alloc]init];
    userEntity = [UserEntity sharedInstance];
    _postAnswer = NO;
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
            if(_postAnswer){
                [_bottomView.nextBtn setTitle:@"结束" forState:UIControlStateNormal];
            }
        }
        [self.view addSubview:_bottomView];
    }
}


- (void)reloadData:(int)indexpage{
    [_table reloadData];
    [self initBottomView:_currentPage];
}
- (void)lastClick{
    if(_currentPage>0){
        _currentPage--;
        [self reloadData:_currentPage];
    }
    
}
- (void)nextClick:(UIButton *)sender{
    //点击page＋1
    if(_currentPage<_numberOfPages){
        _currentPage++;
        //数据刷新
        [self reloadData:_currentPage];
        
    }else if(_currentPage == _numberOfPages){
        //拼接答案
        if([sender.titleLabel.text isEqualToString: @"提交答案" ]){
            NSString *answerStr = @"";
            NSArray *arr = [_userAnswerDic allKeys];
            NSLog(@"%@",_userAnswerDic);
            for(int i=0;i<arr.count;i++){
                NSString *str1 = [NSString stringWithFormat:@"%i",i];
                NSString *str2 = [_userAnswerDic objectForKey:str1];
                int j = [str2 intValue];
                switch (j) {
                    case 1:str2= @"A";
                        break;
                    case 2:str2= @"B";
                        break;
                    case 3:str2= @"C";
                        break;
                    case 4:str2= @"D";
                        break;
                    default:
                        break;
                }
                [_userAnswerStringDic setObject:str2 forKey:[NSString stringWithFormat:@"%i",i]];
                answerStr = [answerStr stringByAppendingString:str2];
                if(i!=(arr.count-1)){
                    answerStr = [answerStr stringByAppendingString:@";"];
                }
            }
            NSLog(@"%@",_userAnswerStringDic);
            _postAnswer = YES;
            [self reloadData:_currentPage];

        }
        
        if([sender.titleLabel.text isEqualToString:@"结束"]){
            //弹出提示框
            UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
                }];
            [contoller addAction:cancelAction];
            [contoller addAction:otherAction];
            [self presentViewController:contoller animated:YES completion:nil];

        }
        //提交考试结果
//        [self postAnswer:[NSString stringWithFormat:@"%i",_testId] andAnswer:answerStr];
//        [self getScore:[NSString stringWithFormat:@"%i",_testId]];
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
//    NSInteger actualSection = (_currentPage-1)*5+section;
//    _right.text=[NSString stringWithFormat:@"%@", [_dataArr[actualSection] objectForKey:@"title"]];
//    CGSize size = [_right sizeThatFits:CGSizeMake(self.view.frame.size.width-90, MAXFLOAT)];
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     NSInteger actualSection = (_currentPage-1)*5+section;
    NSLog(@"actualSection: %ld",(long)actualSection);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 120)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(10,10 ,70, 30)];
    left .textAlignment = NSTextAlignmentLeft;
    left .lineBreakMode = NSLineBreakByTruncatingTail;
    [ left  setTextColor:[UIColor blackColor]];
    left .font = [UIFont fontWithName:@"Arial" size:18];
    left.text = [NSString stringWithFormat:@"第%ld题 :",(long)actualSection+1];
    [view addSubview: left];
    
    _right = [[UILabel alloc]init];
    _right .textAlignment = NSTextAlignmentLeft;
    _right.numberOfLines = 0;
    _right .lineBreakMode = NSLineBreakByWordWrapping;
    [ _right  setTextColor:[UIColor blackColor]];
    _right .font = [UIFont fontWithName:@"Arial" size:18];
    _right.text = [NSString stringWithFormat:@"%@", [_dataArr[actualSection] objectForKey:@"title"]];
    CGSize size = [_right sizeThatFits:CGSizeMake(view.frame.size.width-100, MAXFLOAT)];
    _right.frame = CGRectMake(90, 15, size.width, size.height);
    [view addSubview: _right];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
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
    if(_postAnswer){
        NSString *strSection = [NSString stringWithFormat:@"%ld",actualsection];
        NSString *ans;
        switch (indexPath.row) {
            case 0:
                ans = @"A";
                break;
            case 1:
                ans = @"B";
                break;
            case 2:
                ans = @"C";
                break;
            case 3:
                ans = @"D";
                break;
            default:
                break;
        }
        if([ans isEqualToString:[_rightAnswerDic objectForKey:strSection]]){
            cell.answerLabel.textColor = [UIColor greenColor];
        }else if ([ans isEqualToString:[_userAnswerStringDic objectForKey:strSection]]){
            cell.answerLabel.textColor = [UIColor redColor];
        }else if ([ans isEqualToString:[_rightAnswerDic objectForKey:strSection]]&&[ans isEqualToString:[_userAnswerStringDic objectForKey:strSection]]){
            cell.answerLabel.textColor = [UIColor greenColor];
        }else{
            cell.answerLabel.textColor = [UIColor blackColor];
        }
    }
    [cell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn.tag = indexPath.row;
    cell.btn.titleLabel.text = [NSString stringWithFormat:@"%ld",actualsection];
    NSString *string = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSString *answerString = [_userAnswerDic objectForKey:cell.btn.titleLabel.text];
    if([string isEqualToString:answerString]){
        cell.btn.backgroundColor = [UIColor blueColor];
    }else{
        cell.btn.backgroundColor = [UIColor whiteColor];
    }
    
    
    return cell;
}

- (void)click:(UIButton *)sender{
    NSString *answer;
    switch (sender.tag) {
        case 0:
            answer = @"1";
            break;
        case 1:
            answer = @"2";
             break;
        case 2:
            answer = @"3";
            break;
        case 3:
            answer = @"4";
        default:
            break;
    }
    //将答案存储到dic，对应题目
    [_userAnswerDic setObject:answer forKey:sender.titleLabel.text];
    [_table reloadData];
    
}

//获取考试结果
- (void)getScore:(NSString *)testId{
    CommonService *service = [[CommonService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"study",@"m",
                           @"exam_grade",@"a",
                           userEntity.sn,@"sn",
                           @(_testId),@"id",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSLog(@"%@",dic);
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
                           @(_testId) ,@"id",
                           answer,@"answer",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        if ([strState isEqualToString:@"1"]) {
            NSMutableDictionary *dic = [entity objectForKey:@"data"];
            NSLog(@"%@",dic);
        }
    } Failed:^(int errorCode, NSString *message) {
        NSLog(@"%@",message);
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
            for (int i=0; i<_dataArr.count; i++) {
                NSDictionary *andic = _dataArr[i];
                NSString *ans = [andic objectForKey:@"answer"];
                [_rightAnswerDic setObject:ans forKey:[NSString stringWithFormat:@"%i",i]];
            }
            NSLog(@"%@",_rightAnswerDic);
            
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
