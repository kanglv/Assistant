//
//  LoginViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/25.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "UserEntity.h"
#import "NewsViewController.h"
#import "InformationViewController.h"
#import "MyViewController.h"

@interface LoginViewController ()<MBProgressHUDDelegate,UITabBarControllerDelegate>
{
    MBProgressHUD *HUD;
    NewsViewController *newsVC;
    InformationViewController *inforVC;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.remberBtn.tag = 1;
    self.navigationItem.title = @"渠道助手";

    //从NSUserDefaults中读取数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取整型int类型的数据
    self.textFieldName.text = [userDefaultes objectForKey:@"name"];
    self.textFieldPassword.text = [userDefaultes objectForKey:@"password"];
    
}

- (IBAction)rememberPwd:(UIButton *)sender {
    if (sender.tag == 1) {
        
        [self.remberBtn setImage:[UIImage imageNamed:@"check_normal.png"] forState:UIControlStateNormal];
        sender.tag =0;
    }
    else if (sender.tag == 0){
        
        [self.remberBtn setImage:[UIImage imageNamed:@"check_pressed.png"] forState:UIControlStateNormal];
        sender.tag = 1;
    }

}

- (IBAction)doLogin:(UIButton *)sender {
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"努力加载中...";
    
    UserService *service = [[UserService alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"user",@"m",
                           @"login",@"a",
                           @"0",@"role",
                           self.textFieldName.text, @"username",
                           self.textFieldPassword.text, @"password",
                           nil
                   ];
    [service loginWithPassword:param Successed:^(UserEntity *entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        if ([strState isEqualToString:@"1"]) {
            [self getInMainView];
            [self remberUserEntity];
            
            
        }else {
            
            ALERT_ERR_MSG(entity.msg);
        }
        
        [HUD hide:YES];
    } Failed:^(int errorCode, NSString *message) {
        [HUD hide:YES];
        
    }];
}

- (void)remberUserEntity{
    
    if (self.remberBtn.tag == 1) {
        NSLog(@"记住密码");
        
        //保存到userdefault
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:self.textFieldName.text forKey:@"name"];
        [userDefaults setObject:self.textFieldPassword.text forKey:@"password"];
        
        [userDefaults synchronize];
        
        
    }else if(self.remberBtn.tag == 0){
        NSLog(@"不记住密码");
        
//        删除：
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

-(void)getInMainView{
    
    
    inforVC = [[InformationViewController alloc]init];
    inforVC.tabBarItem.title = @"渠道信息";
    inforVC.tabBarItem.image =[UIImage imageNamed: @"qudao_normal"];
    
    MainViewController *cvc = [[MainViewController alloc]init];
    cvc.tabBarItem.title = @"巡检走访";
    cvc.tabBarItem.image = [UIImage imageNamed:@"xunjian_normal"];
    
    MainViewController *avc = [[MainViewController alloc]init];
    avc.tabBarItem.title = @"物料支撑";
    avc.tabBarItem.image = [UIImage imageNamed:@"wuliao_normal"];
    
    newsVC = [[NewsViewController alloc]init];
    newsVC.tabBarItem.title = @"公告";
    newsVC.tabBarItem.image = [UIImage imageNamed:@"gonggao_normal"];
    
    MyViewController *mvc = [[MyViewController alloc]init];
    mvc.tabBarItem.title = @"我的";
    mvc.tabBarItem.image = [UIImage imageNamed:@"wode_normal"];
    
    //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    tb.delegate = self;
    //设置控制器为Window的根控制器
//    [tb.tabBar setTintColor:[UIColor colorWithRed:0.28 green:0.51 blue:0.98 alpha:1]];
    tb.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:inforVC];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:cvc];
    
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:avc];
    UINavigationController *newsNvc = [[UINavigationController alloc]initWithRootViewController:newsVC];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:mvc];
    //b.创建子控制器
    tb.viewControllers=@[nvc,nvc1,nvc2,newsNvc,nvc4];
    
    [self.navigationController pushViewController:tb animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger index = tabBarController.selectedIndex;
    
    if(index == 0){
        
        
    }else if(index == 1){
        
        
    }else if(index == 2){
        
        
    }else if(index == 3){
        
        [newsVC loadData];
        
    }else if(index == 4){
        
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
