//
//  RegistViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//
#import "XieYiViewController.h"
#import "RegistViewController.h"
#import "AFNetworking.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>

#import "GuideViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController{

    NSString * deviceType ;// 设备类型

    NSString * deviceSpec;//机型

    

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // [self makeBackItem];
    [Utile makeCorner:5 view:self.imageView];
 self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.viewa.layer.masksToBounds = YES;
    self.viewa.layer.cornerRadius = 5;
    self.viewa.layer.borderWidth = 1;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 192/255.0, 192/255.0, 192/255.0, 1 });
    self.viewa.layer.borderColor = borderColorRef;
    
    self.imageView.userInteractionEnabled = YES;
    self.viewa.userInteractionEnabled = YES;
    self.viewasd.userInteractionEnabled = YES;
    self.totalTime = 60;
    self.ReadBtn.selected = YES;
    
    self.yzmBtn.layer.masksToBounds = YES;
    self.yzmBtn.layer.cornerRadius = 3;

    
    self.entBtn.layer.masksToBounds = YES;
    self.entBtn.layer.cornerRadius = 4;
    
    self.view.backgroundColor = MainBackColor;
    
//    self.PhoneBackView.layer.borderWidth = 1;
//    self.PhoneBackView.layer.masksToBounds  = YES;
//    self.PhoneBackView.layer.cornerRadius = 3;
//    self.PhoneBackView.layer.borderColor = LINECOLOR.CGColor;
//
    self.PhoneBackView.userInteractionEnabled = YES;
    
//    
//    self.NametextFieldBack.layer.borderWidth = 1;
//    self.NametextFieldBack.layer.masksToBounds  = YES;
//    self.NametextFieldBack.layer.cornerRadius = 3;
//    self.NametextFieldBack.layer.borderColor = LINECOLOR.CGColor;
//
    self.NametextFieldBack.userInteractionEnabled = YES;
//    
//    self.YzBackView.layer.borderWidth = 1;
//    self.YzBackView.layer.masksToBounds  = YES;
//    self.YzBackView.layer.cornerRadius = 3;
//    self.YzBackView.layer.borderColor = LINECOLOR.CGColor;
//
    self.YzBackView.userInteractionEnabled = YES;
//    
//    self.passworldBackView.layer.borderWidth = 1;
//    self.passworldBackView.layer.masksToBounds  = YES;
//    self.passworldBackView.layer.cornerRadius = 3;
//    self.passworldBackView.layer.borderColor = LINECOLOR.CGColor;
//

    self.passworldBackView.userInteractionEnabled = YES;
    
    

    
    
    
    self.YanZhengTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.PhoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.MImatextField.secureTextEntry = YES;
   
    if ([self.typeStr isEqualToString:@"1"]) {
        self.navigationItem.title= @"完善资料";
        [self.entBtn setTitle:@"完善资料" forState:normal];
    }else{
        self.navigationItem.title= @"注册";
        [self.entBtn setTitle:@"注册" forState:normal];
    }
    
    
    

    self.PhoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    
//    [self makemessage];
}
-(void)makemessage{
    deviceType  = @"1";
      deviceSpec =[self platform];

}


-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 获取验证码
- (IBAction)YZBtnAction:(id)sender {
    if (![self isForPhoneTextFile]) {
        [self showHint:@"请输入正确的手机号"];
        return ;
   }
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    GETCODE
    NSDictionary * valueDic  = @{@"phone":self.PhoneTextField.text};
//    NSArray * Array  = @[@{@"phone":self.PhoneTextField.text}];
 
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
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


#pragma mark --60秒内只能点击一次---
-(void)createTimer
{
    self.yzmBtn.userInteractionEnabled=NO;
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
    [self.yzmBtn setTitle:text forState:UIControlStateNormal];
    if(_totalTime == 0)
    {
        [timer invalidate];
        timer = nil;
        self.yzmBtn.userInteractionEnabled = YES;
        _totalTime = 60;
        [self.yzmBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
         return;
    }
}

//#pragma mark 协议
- (IBAction)TreatyAction:(id)sender {
//
//
//    XieYiViewController * Xvc =[[XieYiViewController alloc]init];
//    [self.navigationController pushViewController:Xvc animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)BeginREgistAction:(id)sender {
    
//判断手机格式   返回 yes 或者 no
    if ([self isForPhoneTextFile]) {
        // 判断密码格式
        if( [self checkPassWord]){
        // 是否阅读协议
            if ( self.ReadBtn.selected) {
                
                if ([self.typeStr isEqualToString:@"1"]) {
                    [self makeWanShang];
                }else{
                    [self regisetAction];
                }
                
            }else{
                }
        }else{
        [self showHint:@"密码至少6位且包含字母和数字！"];
        }
        
    }else{
    [self showHint:@"手机格式不正确,请重新输入"];
     
    }
}

- (IBAction)yueduActions:(id)sender {
    self.ReadBtn.selected =!self.ReadBtn.selected;
//    if (self.ReadBtn.selected) {
//        self.ReadBtn.imageView.image = [UIImage imageNamed:@"register-2.png"];
//    }else{
//        self.ReadBtn.imageView.image = [UIImage imageNamed:@"register-1.png"];
//    }
    
}

//判断手机号
-(BOOL)isForPhoneTextFile{
    

    if (self.PhoneTextField.text.length == 11 && [self.PhoneTextField.text hasPrefix:@"1"]) {
        return  YES;
    }else{
        
        return  NO;
    }
}

-(NSString *)platform{
    // 需要#import "sys/utsname.h"
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //CLog(@"%@",deviceString);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}


//- (IBAction)btnClick:(id)sender {
//    
//    
//    if (self.MImatextField.secureTextEntry ) {
//        self.MImatextField.secureTextEntry = NO;
//    }else{
//        self.MImatextField.secureTextEntry = YES;
//    }
//}

-(void)regisetAction{

    if ([Utile stringIsNil:self.NameTextField.text]) {
        [self showHint:@"请填写用户名！"];
        return;
    }
    if ([Utile stringIsNil:self.PhoneTextField.text]) {
        [self showHint:@"请填写手机号！"];
        return;
    }
    
    if ([Utile stringIsNil:self.YanZhengTextField.text]) {
        [self showHint:@"请填写验证码！"];
        return;
    }
    
    if ([Utile stringIsNil:self.MImatextField.text]) {
        [self showHint:@"请填写密码！"];
        return;
    }
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    REGIST
    NSDictionary * valudic  = @{@"username":self.NameTextField.text,@"phone":self.PhoneTextField.text,@"code":self.YanZhengTextField.text,@"password":self.MImatextField.text};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self showHint:@"注册成功！"];
            [self.navigationController popViewControllerAnimated:YES];
 //            18703993959
          }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"注册失败，请稍后重试！"];
        NSLog(@"%@",error);
    }];

    
    
}
- (void)makeWanShang{
    
    if ([Utile stringIsNil:self.NameTextField.text]) {
        [self showHint:@"请填写用户名！"];
        return;
    }
    if ([Utile stringIsNil:self.PhoneTextField.text]) {
        [self showHint:@"请填写手机号！"];
        return;
    }
    
    if ([Utile stringIsNil:self.YanZhengTextField.text]) {
        [self showHint:@"请填写验证码！"];
        return;
    }
    
    if ([Utile stringIsNil:self.MImatextField.text]) {
        [self showHint:@"请填写密码！"];
        return;
    }
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UserbindThree
    NSDictionary * valudic  = @{@"type":self.loginType,@"openid":self.openID,@"username":self.NameTextField.text,@"avatar":self.imagePath,@"sex":self.xingbeiStr,@"phone":self.PhoneTextField.text,@"password":self.MImatextField.text,@"code":self.YanZhengTextField.text};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString *status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if ([status isEqualToString:@"0"]) {
            
            
            NSUserDefaults * userdefa =[NSUserDefaults standardUserDefaults];
            [userdefa setValue:data[@"data"][@"id"] forKey:@"id"];
            [userdefa setValue:data[@"data"][@"phone"] forKey:@"phone"];
            [userdefa setValue:data[@"data"][@"avatar"] forKey:@"avatar"];
            [userdefa setValue:data[@"data"][@"id"] forKey:@"useid"];
            [userdefa synchronize];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];
            
        }else{
            [self showHint:data[@"msg"]];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
}



- (IBAction)agreeXieyi:(id)sender {
    
    XieYiViewController * Xvc =[[XieYiViewController alloc]init];
    [self.navigationController pushViewController:Xvc animated:YES];
}
@end
