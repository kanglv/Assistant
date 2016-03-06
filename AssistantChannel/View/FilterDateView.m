//
//  FilterDateView.m
//  GH
//
//  Created by xy on 15/10/26.
//  Copyright © 2015年 dxw. All rights reserved.
//

#import "FilterDateView.h"

@interface FilterDateView ()<NIDropDownDelegate>
{
    NIDropDown *_dropDown;
}
@property(nonatomic, strong) NSArray *cateArr;
@end


@implementation FilterDateView

- (instancetype)initWithCategory:(NSArray *)cateArr startDate:(NSString *)startDate endDate:(NSString *)endDate
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        if (cateArr.count > 0) {
            
            self.cateArr = cateArr;
            
            self.cateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cateBtn.backgroundColor = [UIColor whiteColor];
            [self.cateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.cateBtn.layer.cornerRadius = 4;
            self.cateBtn.layer.masksToBounds = YES;
            self.cateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.cateBtn setTitle:cateArr[1] forState:UIControlStateNormal];
            [self.cateBtn addTarget:self action:@selector(cateBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.cateBtn];
            
//            [self.cateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.leading.mas_equalTo(self).offset(5);
//                make.size.mas_equalTo(CGSizeMake(70, 30));
//                make.centerY.mas_equalTo(self.mas_centerY);
//            }];
            
            
//            self.seachTextField = [[UITextField alloc]init];;
//            self.seachTextField.titleLabel.font = [UIFont systemFontOfSize:15];
//            [self.seachBtn setImage:[UIImage imageNamed:@"rili"] forState:UIControlStateNormal];
//            [self.seachBtn setTitle:@" 工单时间" forState:UIControlStateNormal];
//            [self addSubview:self.seachBtn];
//            
//            [self.seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.leading.mas_equalTo(self.cateBtn.mas_trailing).offset(5);
//                make.top.mas_equalTo(self.mas_top);
//                make.bottom.mas_equalTo(self.mas_bottom);
//                make.trailing.mas_equalTo(self.mas_trailing);
//            }];
        }else{
//            self.seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.seachBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//            [self.seachBtn setImage:[UIImage imageNamed:@"rili"] forState:UIControlStateNormal];
//            [self.seachBtn setTitle:@" 工单时间" forState:UIControlStateNormal];
//            [self addSubview:self.seachBtn];
//            
//            [self.seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.leading.mas_equalTo(self);
//                make.top.mas_equalTo(self);
//                make.bottom.mas_equalTo(self);
//                make.trailing.mas_equalTo(self);
//            }];
        }
    }
    
    return self;
}

- (void)cateBtnClicked:(id)sender
{
    CGFloat height = 40*self.cateArr.count;
    
    if (!_dropDown) {
        _dropDown = [[NIDropDown alloc] showDropDown:sender height:&height titleArr:self.cateArr imgArr:nil direction:@"down"];
        _dropDown.delegate = self;
    }else{
        [_dropDown hideDropDown:self.cateBtn];
        _dropDown = nil;
    }
}

#pragma mark - NIDropDownDelegate

- (void)niDropDownDelegateMethod:(NIDropDown *)sender didSelectIndex:(int)index
{
//    [self.cateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cateBtn setTitle:self.cateArr[index] forState:UIControlStateNormal];
    
    [_dropDown hideDropDown:self.cateBtn];
    _dropDown = nil;
    
    if ([self.delegate respondsToSelector:@selector(filterDateView:didSelectCateIndex:)]) {
        [self.delegate filterDateView:self didSelectCateIndex:index];
    }
}

@end
