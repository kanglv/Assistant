//
//  InformationViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Information_baseViewController.h"
#import "Operate_listViewController.h"
#import "Remuneration_listViewController.h"
#import "Information_detaileViewController.h"
#import "EfficiencyViewController.h"

@interface InformationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic,strong) UILabel *lineLabel;

@property (nonatomic,assign) CGFloat x ;

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;

@property (nonatomic,strong) UIView *Informationview;
@property (nonatomic,strong) UIView *Operateview;
@property (nonatomic,strong) UIView *RemunerationView;

@property (nonatomic,strong) Information_detaileViewController *information_DetailTableView;
@property (nonatomic,strong) Information_baseViewController *InformationTableView;
@property (nonatomic,strong) Operate_listViewController *Operate_listTableView;
@property (nonatomic,strong) EfficiencyViewController *EfficiencyTableView;
@property (nonatomic,strong) Remuneration_listViewController *Remuneration_listTableView;

@end
