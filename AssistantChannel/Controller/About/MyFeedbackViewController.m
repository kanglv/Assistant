//
//  MyFeedbackViewController.m
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/8.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyFeedbackViewController.h"

@interface MyFeedbackViewController ()<UITextViewDelegate>

@end

@implementation MyFeedbackViewController

@synthesize TextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    
    UIButton *backBtn = [self setNaviCommonBackBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.TextView.returnKeyType = UIReturnKeyDone;
    
    self.TextView.layer.masksToBounds = YES;
    self.TextView.layer.cornerRadius = 8;
    
    self.doSendbtn.layer.cornerRadius = 8;
    self.doSendbtn.layer.masksToBounds = YES;
    
}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([TextView.text length] == 0) {
        [self.textFileLabel setHidden:NO];
    }else{
        [self.textFileLabel setHidden:YES];
        
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.suggestMessage = textView.text;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (IBAction)doSendFeedback:(UIButton *)sender {

    if (self.suggestMessage.length == 0) {
        ALERT_ERR_MSG(@"请先填写您宝贵的意见");
        return;
    }
    
    
    [self sendData];
}

- (void) sendData
{
    
    CommonService *service = [[CommonService alloc] init];
    UserEntity *userEntity = [UserEntity sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"user",@"m",
                           @"feedback",@"a",
                           userEntity.sn,@"sn",
                           self.suggestMessage,@"content",
                           nil
                           ];
    
    [service getNetWorkData:param Successed:^(id entity) {
        
        NSNumber *state = [entity valueForKeyPath:@"success"];
        NSString *strState = [NSString stringWithFormat:@"%d", [state intValue]];
        
        
        if ([strState isEqualToString:@"1"]) {

            
        }else{
            
        }
        
    } Failed:^(int errorCode, NSString *message) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
