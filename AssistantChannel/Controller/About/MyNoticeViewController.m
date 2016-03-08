//
//  MyNoticeViewController.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/7.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "MyNoticeViewController.h"
#import "MyNoticeTableViewCell.h"
@interface MyNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    MyNoticeTableViewCell *cell;
}
@property (strong , nonatomic)UITableView *myTable;
@property (strong , nonatomic)NSMutableArray *dataArr;
@property NSInteger numberOfNotice;
@end

@implementation MyNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"通知";
    
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
            _dataArr = [[entity objectForKey:@"data"] objectForKey:@"ls"];
            
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
    
    CGFloat cellheight;
    cellheight = cell.inforLabel.layer.frame.size.height;
    CGSize size = [cell.inforLabel sizeThatFits:CGSizeMake(cell.inforLabel.frame
                                                              .size.width, MAXFLOAT)];
    if (size.height == 0) {
        return 70;
    }
    return size.height + 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier =@"MyNoticeTableViewCell";
    cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary *information = _dataArr[indexPath.row];
    cell.inforLabel.text =[information objectForKey:@"title"];

    if([[information objectForKey:@"is_read"] isEqualToString:@"1"]){
        cell.stateLabel.text = @"已读";
    }else{
        cell.stateLabel.text = @"未读";
        cell.stateLabel.textColor = [UIColor colorWithRed:31.0/255 green:146.0/255 blue:218.0/255 alpha:1];
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
