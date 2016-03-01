//
//  InformationViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Information_baseView.h"
#import "Operate_listView.h"
#import "Remuneration_listView.h"

@interface InformationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic,strong) UILabel *lineLabel;

@property (nonatomic,assign) CGFloat x ;

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;

@property (nonatomic,strong) Information_baseView *Informationview;
@property (nonatomic,strong) Operate_listView *Operateview;
@property (nonatomic,strong) Remuneration_listView *RemunerationView;

@end
