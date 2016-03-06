//
//  MyDetailInformationViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/3.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyDetailInformationViewController.h"
#import "MyInformationTableViewCell.h"
#import "MyResetViewController.h"

@interface MyDetailInformationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic)UITableView *table;
@property (strong , nonatomic) NSMutableArray *dataArr,*informationArr;
@property (strong,nonatomic)UIButton *button;
@end

@implementation MyDetailInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    _informationArr = [[NSMutableArray alloc]initWithCapacity:10];//初始化信息数组，请求获取
    [self InitData];
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width,height) style:UITableViewStyleGrouped];
    _table.dataSource=self;
    _table.delegate=self;
    _table.scrollEnabled = NO;
    _table.separatorStyle = NO;
    [self.view addSubview:_table];
    
}

- (void)InitData {
    _dataArr = [[NSMutableArray alloc]init];
    [_dataArr addObject:@"登陆账户"];
    [_dataArr addObject:@"昵称"];
    [_dataArr addObject:@"性别"];
    [_dataArr addObject:@"部门"];
    [_dataArr addObject:@"用户身份"];
    [_dataArr addObject:@"修改密码"];
}

#pragma mark - tableView设置
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT/10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*50/667)];
    self.button=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, view.frame.size.width, view.frame.size.height-10)];
    [self.button setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
    [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.button.tag=2;
    [view addSubview:self.button];
    return view;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"kanglv";
    MyInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[MyInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.leftLabel.text = _dataArr[indexPath.row];
    if(indexPath.row ==([_dataArr count]-1)){
        cell.leftLabel.textColor = [UIColor blueColor];
        cell.rightLabel.text = @"";
    }else{
        cell.rightLabel.text = @"21";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==([_dataArr count]-1)) {
        MyResetViewController *mrvc = [[MyResetViewController alloc]init];
        [self.navigationController pushViewController:mrvc animated:YES];
        
    }
}

//点击退出登录按钮
- (void)click:(UIButton *)sender{
    UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //退出登录，清空本地数据库User表信息
//        OperateDatabase *operate=[[OperateDatabase alloc]init];
//        [operate deleteData];
//        [self back];
        
    }];
    [contoller addAction:cancelAction];
    [contoller addAction:otherAction];
    [self presentViewController:contoller animated:YES completion:nil];//弹出提醒框
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
