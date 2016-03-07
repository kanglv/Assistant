//
//  MyNoticeViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyNoticeViewController.h"
#import "MyNoticeTableViewCell.h"
@interface MyNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong , nonatomic)UITableView *myTable;
@property (strong , nonatomic)NSArray *dataArr;
@property NSInteger numberOfNotice;
@end

@implementation MyNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self getData];
    
}

- (void)getData{
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"notification",@"m",
                           @"list",@"a",
                           userEntity.sn,@"sn",
                           nil
                           ];
    [service getNetWorkData:param Successed:^(id entity) {
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        if ([strState isEqualToString:@"1"]) {
            NSNumber *num = [[entity objectForKey:@"data"] objectForKey:@"total"];
            _numberOfNotice = [num intValue];
            _dataArr = [entity objectForKey:@"ls"];
            _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
            _myTable.dataSource=self;
            _myTable.delegate=self;
            [self.view addSubview:_myTable];

        }
    }Failed:^(int errorCode, NSString *message) {
        
    }];
}

#pragma mark - tableView设置
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _numberOfNotice;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height/7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str =@"lvkang";
    MyNoticeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[MyNoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    NSDictionary *information = _dataArr[indexPath.row];
    cell.inforLabel.text =[information objectForKey:@"title"];
    if([[information objectForKey:@"1"] isEqualToString:@"1"]){
        cell.stateLabel.text = @"已读";
    }else{
        cell.stateLabel.text = @"未读";
    }
    NSString *time = [information objectForKey:@"create_time"];
    NSString *actualtime =[dateChange NsstringChangeDate:time];
    cell.timeLabel.text = actualtime;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
