//
//  MyResetViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/6.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyResetViewController.h"
#import "MyViewController.h"
@interface MyResetViewController ()
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UIView *backgroundView;
@property(strong,nonatomic)UILabel *confirmLabel,*codeLabel,*line1,*line2,*line3,*line4,*orginLabel;
@property (copy,nonatomic)NSString *phoneNumber;
@property(strong,nonatomic)UITextField *confirmText,*codeText,*orginText;
@property(strong,nonatomic)UIButton *submitBtn;
@property (assign,nonatomic)BOOL click;
@end

@implementation MyResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setViewDetail];
}

-(void)initView{
    self.title = @"修改密码";
    self.click = NO;
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.line1=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*50/667 , self.view.frame.size.width,0.5)];
    
    self.orginLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*50/667 , self.view.frame.size.width*5/16,self.view.frame.size.height*50/667 )];
    
    self.orginText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*7/16,self.view.frame.size.height*50/667 , self.view.frame.size.width*7/16,self.view.frame.size.height*50/667 )];
     self.line2=[[UILabel alloc]initWithFrame:CGRectMake(15,self.view.frame.size.height*100/667 , self.view.frame.size.width-30,0.5)];

    self.codeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*100/667 , self.view.frame.size.width*5/16,self.view.frame.size.height*50/667 )];
    
    self.codeText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*7/16,self.view.frame.size.height*100/667 , self.view.frame.size.width*7/16,self.view.frame.size.height*50/667 )];
    
    self.line3=[[UILabel alloc]initWithFrame:CGRectMake(15,self.view.frame.size.height*155/667 , self.view.frame.size.width-30,0.5)];
    
    self.confirmLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*160/667 , self.view.frame.size.width*5/16,self.view.frame.size.height*50/667 )];
    
    self.confirmText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*7/16,self.view.frame.size.height*160/667 , self.view.frame.size.width*7/16,self.view.frame.size.height*50/667 )];
    
    self.line4=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*215/667 , self.view.frame.size.width,0.5)];
    
    self.submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*230/667 , self.view.frame.size.width*12/16,self.view.frame.size.height*50/667)];
    
    
    [self.view addSubview:self.orginLabel];
    [self.view addSubview:self.orginText];
    [self.view addSubview:self.confirmLabel];
    [self.view addSubview:self.confirmText];
    [self.view addSubview:self.codeLabel];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.line4];
    [self.view addSubview:self.submitBtn];
    
    
    
}
-(void)setViewDetail{
    
    self.view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    self.orginLabel.text = @"旧密码";
    [self.orginLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    
    self.codeLabel.text=@"新密码";
    [self.codeLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    self.confirmLabel.text=@"确认新密码";
    [self.confirmLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:0.9]];
    [self.submitBtn.layer setMasksToBounds:YES];
    [self.submitBtn.layer setCornerRadius:3];
    self.submitBtn.tag=2;
    
    self.line1.text=@"";
    self.line1.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line2.text=@"";
    self.line2.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line3.text=@"";
    self.line3.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line4.text=@"";
    self.line4.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    
}
-(void)click:(UIButton *)sender{
    if(self.click ==NO){
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取整型int类型的数据
        if(![self.orginText.text isEqualToString:[userDefaultes objectForKey:@"password"]]){
            ALERT_ERR_MSG(@"旧密码输入错误");
            
        }else{
            //输入为空
            if([self.codeText.text isEqualToString:@" "]){
                ALERT_ERR_MSG(@"密码不能为空");
            }
            //两次相等
            else if([self.codeText.text isEqualToString:self.confirmText.text]){
                self.click=YES;
                //更新网络数据
                CommonService *service = [[CommonService alloc]init];
                UserEntity *userEntity = [UserEntity sharedInstance];
                NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"user",@"m",
                                       @"modify_password",@"a",
                                       userEntity.sn,@"sn",
                                       _orginText.text,@"old_password",
                                       _codeText.text,@"new_password",
                                       nil
                                       ];
                [service getNetWorkData:param Successed:^(id entity) {
                    
                    NSNumber *state = [entity valueForKeyPath:@"success"];
                    NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
                    if ([strState isEqualToString:@"1"]) {
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:self.codeText.text forKey:@"password"];
                        [userDefaults synchronize];
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                        message:@"修改成功"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil, nil];
                        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                    }else{
                        
                        ALERT_ERR_MSG([entity valueForKeyPath:@"msg"]);
                    }

                } Failed:^(int errorCode, NSString *message) {
                    
                }];
                //                    MyViewController *mvc = [[MyViewController alloc]init];
                //
                //
                //                    [self.navigationController popToViewController:mvc animated:NO];
            }
            //两次输入不一致
            else{
                ALERT_ERR_MSG(@"两次输入不一致，请重新输入");
            }
            
        }
    }
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
