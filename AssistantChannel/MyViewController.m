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
    self.title = @"我的";
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
    _myTable.scrollEnabled = NO;
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
    [arr addObject:@"清除缓存"];
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
    ret = YES;
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
    return SCREEN_HEIGHT/15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 120;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *view = [[UIImageView alloc]init];
    if(section == 0){
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
        view.image = [UIImage imageNamed:@"img_setting_image.jpg"];
    }
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"tab1";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    if(indexPath.section == 0){
        cell.imgView.image = [UIImage imageNamed:_imgArr[indexPath.row]];
        cell.nameLabel.text = _dataArr[indexPath.row];
        if([cell.nameLabel.text isEqualToString:@"通知"]){
//            if(有通知){通过接口请求
//            cell.informLabel.text = @"0";//具体通知数由接口返回
//            cell.imgView.image = [UIImage imageNamed:@"ico_inform"];
//            }
           
        }
        
    }
    else if (indexPath.section == 1){
        NSInteger actualIndex = indexPath.row+2;
        if([self showLearningClub]){
            actualIndex = actualIndex+1;
        }
        cell.imgView.image = [UIImage imageNamed:_imgArr[actualIndex]];
        cell.nameLabel.text = _dataArr[actualIndex];
        if(indexPath.row==1){
            cell.cacheLabel.text = @"200B";//具体数值，通过method的方法计算
        }
    }
    else{
        NSInteger index = indexPath.row+4;
        if([self showLearningClub]){
            index = index+1;
        }
        cell.imgView.image = [UIImage imageNamed:_imgArr[index]];
        cell.nameLabel.text = _dataArr[index];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //处理各个位置的点击事件
    if(indexPath.section==0){
        if([self showLearningClub]){
            if (indexPath.row==0) {
                //个人中心
            }
            else if(indexPath.row==1){
                //学习园地
                
            }else{
                //通知
                
            }
        }else{
            if (indexPath.row==0) {
                //个人中心
                
            }else {
                //通知
                
            }
        }
    }
    else if (indexPath.section==1){
        if (indexPath.row==0) {
            //版本更新
        }else{
            //清除缓存
        }
    }else{
        if (indexPath.row==0) {
            //意见反馈
        }else{
            //关于助手
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
