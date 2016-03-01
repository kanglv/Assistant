//
//  ZXYBaseViewController.h
//  AssistantChannel
//
//  Created by 张晓烨 on 16/2/29.
//  Copyright © 2016年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYBaseViewController : UIViewController


- (UIButton *)setNaviCommonBackBtn;
- (UIButton *)setNaviRightBtnWithTitle:(NSString *)title;

- (void)setNaviBackBtn:(UIButton *__strong*)backBtn andCloseBtn:(UIButton *__strong*)closeBtn;
- (void)setNaviBarLeftView:(UIView *)view;
- (void)setNaviBarRightView:(UIView *)view;

@end
