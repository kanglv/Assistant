//
//  MyFeedbackViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/3/8.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "ZXYBaseViewController.h"

@interface MyFeedbackViewController : ZXYBaseViewController

@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (weak, nonatomic) IBOutlet UILabel *textFileLabel;
@property (strong, nonatomic) NSString *suggestMessage;
@property (weak, nonatomic) IBOutlet UIButton *doSendbtn;

@end
