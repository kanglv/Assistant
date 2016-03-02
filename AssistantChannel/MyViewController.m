//
//  MyViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"

@interface MyViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (strong , nonatomic) UITableView *myTable;
@property (strong , nonatomic) NSMutableArray *dataArr,*imgArr;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [self setDataObject];
    _imgArr = [self setImgObject];
    [self initView];
    
}

- (void)initView {
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width,height) style:UITableViewStyleGrouped];
    _myTable.dataSource=self;
    _myTable.delegate=self;
    _myTable.separatorStyle = NO;
    [self.view addSubview:_myTable];
    
}

//初始化描述文字
- (NSMutableArray *)setDataObject{
     NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObject:@"个人中心"];
    if([self showLearningClub]){
        [arr addObject:@"学习园地"];
    }
    [arr addObject:@"通知"];
    [arr addObject:@"版本更新"];
    [arr addObject:@"清楚缓存"];
    [arr addObject:@"意见反馈"];
    [arr addObject:@"关于渠道助手"];
    return  arr;
}

//初始化图片数组
- (NSMutableArray *)setImgObject{
    NSMutableArray *imgArr = [[NSMutableArray alloc]init];
    [imgArr addObject:@"ico_personalcenter"];
    if([self showLearningClub]){
        [imgArr addObject:@"img_school"];
    }
    [imgArr addObject:@"icon_norinform"];
    [imgArr addObject:@"img_setting_update"];
    [imgArr addObject:@"img_setting_clear"];
    [imgArr addObject:@"feedback"];
    [imgArr addObject:@"img_setting_about"];
    return imgArr;
}


//是否需要展示学习园地
- (BOOL)showLearningClub{
    BOOL ret = NO;
    //需要判断是否有显示学习园地的需求
//    if(''''){
//        ret = YES;
//    }
    return ret;
}

#pragma mark - tableView设置
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        if([self showLearningClub]){
            return 3;
        }else{
            return 2;
        }
    }
    else {
        return 2;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT/9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 10;
    }
    else {
        return 100;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"tab1";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
