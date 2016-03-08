//
//  MyViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/2.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "MyDetailInformationViewController.h"
#import "MyFeedbackViewController.h"
#import "MyIntroduceViewController.h"
#import "MyMethod.h"
#import "MyNoticeViewController.h"


@interface MyViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (strong , nonatomic) UITableView *myTable;
@property (strong , nonatomic) NSMutableArray *dataArr,*imgArr;
@property (strong , nonatomic) MyMethod *method;

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
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
    BOOL ret = YES;
    UserEntity *userEntity = [UserEntity sharedInstance];
    if ([userEntity.roles isEqualToString:@"13"]) {
        ret = NO;
    }
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
            CommonService *service = [[CommonService alloc] init];
            UserEntity *userEntity = [UserEntity sharedInstance];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"notification",@"m",
                                   @"new_num",@"a",
                                   userEntity.sn,@"sn",
                                   nil
                                   ];
            [service getNetWorkData:param Successed:^(id entity) {
                NSNumber *state = [entity valueForKeyPath:@"success"];
                NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
                if ([strState isEqualToString:@"1"]) {
                    NSNumber *str= [[entity objectForKey:@"data"]objectForKey:@"num"];
                    NSString *str1 = [NSString stringWithFormat:@"%d", [str intValue]];
                    if(![str1 isEqualToString:@"0"]){
                        cell.informLabel.text = str1;//具体通知数由接口返回
                        cell.imgView.image = [UIImage imageNamed:@"ico_inform"];
                        self.tabBarItem.badgeValue = str1;
                    }
                }
            }Failed:^(int errorCode, NSString *message) {
                
            }];
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
            NSArray *paths= NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString*path = [paths lastObject];
            cell.cacheLabel.text = [NSString stringWithFormat:@"%.1fKB", [self.method folderSizeAtPath:path]];//具体数值，通过method的方法计算
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //处理各个位置的点击事件
    if(indexPath.section==0){
        if([self showLearningClub]){
            if (indexPath.row==0) {
                //个人中心
                MyDetailInformationViewController *mvc = [[MyDetailInformationViewController alloc]init];
                mvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mvc animated:YES];
            }
            else if(indexPath.row==1){
                //学习园地
                 NSLog(@"111");
                
            }
            else{
                //通知
                MyNoticeViewController *mnvc = [[MyNoticeViewController alloc]init];
                mnvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mnvc animated:YES];
            }
        }else{
            if (indexPath.row==0) {
                //个人中心
                MyDetailInformationViewController *mvc = [[MyDetailInformationViewController alloc]init];
                mvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mvc animated:YES];
            }else{
                //通知
                MyNoticeViewController *mnvc = [[MyNoticeViewController alloc]init];
                mnvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mnvc animated:YES];
                
            }
        }
    }
    else if (indexPath.section==1){
        if (indexPath.row==0) {
            //版本更新
            CommonService *service = [[CommonService alloc]init];
            UserEntity *userEntity = [UserEntity sharedInstance];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"version",@"m",
                                   @"check",@"a",
                                   userEntity.sn,@"sn",
                                   nil
                                   ];
            [service getNetWorkData:param Successed:^(id entity) {
                //取最新版本号，若与本地的版本一致，弹出已是最新版本。否则跳转下载页面
                //当前版本
                NSNumber *state = [entity valueForKeyPath:@"success"];
                NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
                if ([strState isEqualToString:@"1"]) {
                    NSDictionary *clientInfoDict =[[NSBundle mainBundle] infoDictionary];
                    NSString *clientVersion = clientInfoDict[@"CFBundleVersion"]; //build
                    NSNumber *Version = [[entity objectForKey:@"data"] objectForKey:@"version_code"];
                    NSString *str = [NSString stringWithFormat:@"%d", [Version intValue]];
                    if([clientVersion isEqualToString:str]){
                        //弹出提示框
                        ALERT_ERR_MSG(@"已是最新版本");
                    }else{
                        //
                         NSDictionary *info = entity[@"data"];
                        NSString *content = info[@"desc"];
                        NSString *urlStr = info[@"download_url"];
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示"
                                                                        message:content
                                                                       delegate:nil
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"确定", nil];
                        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                            NSURL *url = [NSURL URLWithString:urlStr];
                            [[UIApplication sharedApplication] openURL:url];
                        }];

                    }
                }
                
                
                
            } Failed:^(int errorCode, NSString *message) {
                
            }];
           
            
        }else{
            //清除缓存
            [self.method clearCache];
        }
    }else{
        if (indexPath.row==0) {
            //意见反馈
            MyFeedbackViewController *mfvc = [[MyFeedbackViewController alloc]init];
            mfvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mfvc animated:YES];
        }else{
            //关于助手
            MyIntroduceViewController *mivc = [[MyIntroduceViewController alloc]init];
            mivc.hidesBottomBarWhenPushed = YES;
            [self presentViewController:mivc animated:YES completion:nil];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
