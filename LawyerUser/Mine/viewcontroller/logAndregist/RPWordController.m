//
//  RPWordController.m
//  肝胆相照
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 sy. All rights reserved.
//

#import "RPWordController.h"
#import "XieYiViewController.h"
#import "AFNetworking.h"
#import <sys/sysctl.h>

@interface RPWordController ()
{
    NSString * deviceType ;// 设备类型
    
    NSString * deviceSpec;//机型
}

@end

@implementation RPWordController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self makeBackItem];

     self.totalTime = 60;
    [Utile makeCorner:5 view:self.BavkImageView];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = MainBackColor;
    
    self.entBttn.layer.masksToBounds = YES;
    self.entBttn.layer.cornerRadius= 4;
    
//    self.passWordBakView.layer.borderWidth = 1;
//    self.passWordBakView.layer.masksToBounds  = YES;
//    self.passWordBakView.layer.cornerRadius = 3;
//    self.passWordBakView.layer.borderColor = LINECOLOR.CGColor;
//    
//    
//    self.YzahnBackView.layer.borderWidth = 1;
//    self.YzahnBackView.layer.masksToBounds  = YES;
//    self.YzahnBackView.layer.cornerRadius = 3;
//    self.YzahnBackView.layer.borderColor = LINECOLOR.CGColor;
//
//    
//    self.PhoneBackView.layer.borderWidth = 1;
//    self.PhoneBackView.layer.masksToBounds  = YES;
//    self.PhoneBackView.layer.cornerRadius = 3;
//    self.PhoneBackView.layer.borderColor = LINECOLOR.CGColor;

    self.GetYanZhenBtn.layer.masksToBounds = YES;
    self.GetYanZhenBtn.layer.cornerRadius = 3;
    
    self.viewss.layer.masksToBounds = YES;
    self.viewss.layer.borderWidth = 1;
    self.viewss.layer.cornerRadius = 5;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 192/255.0, 192/255.0, 192/255.0, 1 });
    self.viewss.layer.borderColor = borderColorRef;
    
    
    
    self.ReadBtn.selected = YES;
    self.YanZhengTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.PhoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.MImatextField.secureTextEntry = YES;
    
    self.navigationItem.title= @"忘记密码";
   
     self.navigationController.hidesBottomBarWhenPushed = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)YZBtnAction:(id)sender {
    if (![self isForPhoneTextFile]) {
        [self showHint:@"请输入正确的手机号"];
        return ;
    }
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJFINDCODE
    NSDictionary * valueDic  = @{@"phone":self.PhoneTextField.text};
    //    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data[@"msg"]);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self showHint:@"验证码已发送"];
            //创建定时器
            [self createTimer];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"获取验证码失败"];
        NSLog(@"%@",error);
    }];
}
#pragma mark --60秒内只能点击一次---
-(void)createTimer
{
    self.GetYanZhenBtn.userInteractionEnabled=NO;
    //创建定时器
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

//定时器的循环事件
-(void)time:(NSTimer *)timer
{
    _totalTime = _totalTime - 1;
    NSNumber *number = [NSNumber numberWithInteger:_totalTime];
    NSString *text = [NSString stringWithFormat:@"%@",number];
    [self.GetYanZhenBtn setTitle:text forState:UIControlStateNormal];
    if(_totalTime == 0)
    {
        [timer invalidate];
        timer = nil;
        self.GetYanZhenBtn.userInteractionEnabled = YES;
        _totalTime = 60;
        [self.GetYanZhenBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
         //        [self.yzmBtn setTitleColor:[UIColor colorWithRed:0.0f/255 green:54.0f/255 blue:116.0f/255 alpha:0.5] forState:UIControlStateHighlighted];
        return;
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)BeginREgistAction:(id)sender
{
    //判断手机格式   返回 yes 或者 no
    if ([self isForPhoneTextFile])
    {
        // 判断密码格式
        if( [self checkPassWord])
        {
            NSDictionary * dic  =[[NSMutableDictionary alloc]init];
            QJFINDPASS
            NSDictionary * valudic  = @{ @"phone":self.PhoneTextField.text,@"code":self.YanZhengTextField.text,@"password":self.MImatextField.text,@"repass":self.querenmima.text};
            
            NSString * baseStr = [NSString getBase64StringWithArray:valudic];
            [dic setValue:baseStr forKey:@"value"];
            
            [self showHudInView:self.view hint:nil];
            [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
                NSLog(@"%@",data);
                NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
                if ([str isEqualToString:@"0"]) {
                    [self showHint:@"重置密码成功！"];
                    [self.navigationController popViewControllerAnimated:YES];
                    //            18703993959
                }else{
                    NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
                    [self showHint:msg];
                }
                [self hideHud];
            } failure:^(NSError *error) {
                [self hideHud];
                [self showHint:@"重置密码，请稍后重试！"];
                NSLog(@"%@",error);
            }];
            
            }
        else{
            [self showHint:@"密码至少6位且包含字母和数字！"];
        }
    }else
    {
    [self showHint:@"手机格式不正确,请重新输入"];
    }
}

//判断手机号
//判断手机号
-(BOOL)isForPhoneTextFile{
    if (self.PhoneTextField.text.length == 11 && [self.PhoneTextField.text hasPrefix:@"1"]) {
        return  YES;
    }else{
        return  NO;
    }
}



// 判断密码
-(BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *regex = @"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self.MImatextField.text]) {
        return YES ;
    }else
        return NO;
}



- (IBAction)yueduActions:(id)sender {
    
    self.ReadBtn.selected =!self.ReadBtn.selected;
    
}


@end
