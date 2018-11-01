//
//  RegistViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface RegistViewController : BaseViewController<UIWebViewDelegate,UIAlertViewDelegate>{
    UIWebView *WebView;
    // 短信验证码；
    NSString * YanZhenStr;
}

@property (weak, nonatomic) IBOutlet UIButton *entBtn;



@property (weak, nonatomic) IBOutlet UIView *PhoneBackView;


@property (weak, nonatomic) IBOutlet UIView *YzBackView;

@property (weak, nonatomic) IBOutlet UIView *passworldBackView;

@property (weak, nonatomic) IBOutlet UIButton *yzmBtn;

@property (weak, nonatomic) IBOutlet UIView *NametextFieldBack;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UIView *viewa;

@property (weak, nonatomic) IBOutlet UIView *viewasd;
- (IBAction)agreeXieyi:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *YanZhengTextField;
@property (weak, nonatomic) IBOutlet UITextField *MImatextField;
- (IBAction)YZBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ReadBtn;  //  是否阅读 协议

- (IBAction)BeginREgistAction:(id)sender;
- (IBAction)yueduActions:(id)sender;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger  totalTime;

@property (nonatomic,strong)NSString *typeStr;// 1 完善资料
@property (nonatomic,strong)NSString *openID;//openid
@property (nonatomic,strong)NSString *imagePath;//图像
@property (nonatomic,strong)NSString *loginType;//登录类型
@property (nonatomic,strong)NSString *xingbeiStr;//性别
@end
