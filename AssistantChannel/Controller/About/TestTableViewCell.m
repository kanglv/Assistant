//
//  TestTableViewCell.m
//  AssistantChannel
//
//  Created by lvkang on 16/3/13.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestSubTableViewCell.h"
#import "DetailTableViewCell.h"
@interface TestTableViewCell()
{
    DetailTableViewCell *dcell;
    TestSubTableViewCell *tcell;
    NSInteger num;
    
}
@end
@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _table = [[UITableView alloc]init];
    _table.separatorStyle =NO;
    _table.delegate = self;
    _table.dataSource = self;
    _table.scrollEnabled = NO;
    [self.contentView addSubview:_table];
}

- (void)layoutSubviews {
    _table.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [_dic objectForKey:@"content"];
    return arr.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 120;
    }else{
        return 25;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str1 = @"tab1";
    static NSString *str2 = @"tab2";
    if(indexPath.row == 0){
        dcell= [tableView dequeueReusableCellWithIdentifier:str1];
        if(dcell == nil){
            dcell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str1];
        }
        dcell.left.text = [NSString stringWithFormat:@"第%i题 :",_index+1];
        dcell.right.text = [_dic objectForKey:@"title"];
        dcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return dcell;

    }
    tcell = [tableView dequeueReusableCellWithIdentifier:str2];
    if(tcell == nil){
        tcell = [[TestSubTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str2];
    }
    tcell.answerLabel.text  = [[_dic objectForKey:@"content"][indexPath.row-1] objectForKey:@"option_title"];
    tcell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tcell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];;
    return tcell;
}

- (void)click:(UIButton *)sender{
    if(sender.selected == YES){
        sender.backgroundColor = [UIColor whiteColor];
        sender.selected = NO;
    }else{
        sender.backgroundColor = [UIColor blueColor];
        sender.selected = YES;
    }
}


@end
