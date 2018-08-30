//
//  QJLoginViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJLoginViewController.h"
#import "RegistViewController.h"
#import "RPWordController.h"

@interface QJLoginViewController (){
    NSString *imgUrl;//图像
    NSString *sexString;//性别
    NSString * UUid;
}

@end

@implementation QJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utile makeCorner:5 view:self.BacImageView];
    self.title = @"登录";
   UUid  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
  UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];

    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 1.把返回文字的标题设置为空字符串(A和B都是UIViewController)
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];

    
    self.view.backgroundColor = MainBackColor;
    self.LongionBtn.layer.masksToBounds = YES;
    self.LongionBtn.layer.cornerRadius = 4;
    self.PassWordTextField.secureTextEntry = YES;
     // 登陆成功 记得调用
//    NSLog(@"登陆成功(手机或者第三方的登陆)记得调用");
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];

    
    self.BackView.layer.masksToBounds = YES;
    self.BackView.layer.borderWidth = 1;
    self.BackView.layer.cornerRadius = 5;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 192/255.0, 192/255.0, 192/255.0, 1 });
    
    self.BackView.layer.borderColor =borderColorRef;
    
     // Do any additional setup after loading the view from its nib.
}
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BtnAction:(UIButton *)sender {
    if(sender.tag == 11){//联系客服
    
    }else if (sender.tag ==12){// 忘记密码
        RPWordController * rvc =[[RPWordController alloc]initWithNibName:@"RPWordController" bundle:nil];
        [self.navigationController pushViewController:rvc animated:YES];
        

    }else if (sender.tag == 13){// 注册
        RegistViewController * rvc =[[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
        [self.navigationController pushViewController:rvc animated:YES];
    
    }
    
}

- (IBAction)OtherLoginAction:(UIButton *)sender {
    
    
    if(sender.tag == 21){//QQ
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
            
            if (error) {
                
            }else{
                UMSocialUserInfoResponse *resp = result;
                
                // 授权信息
                NSLog(@"QQ uid: %@", resp.uid);
                NSLog(@"QQ openid: %@", resp.openid);
                NSLog(@"QQ unionid: %@", resp.unionId);
                NSLog(@"QQ accessToken: %@", resp.accessToken);
                NSLog(@"QQ expiration: %@", resp.expiration);
                
                // 用户信息
                NSLog(@"QQ name: %@", resp.name);
                NSLog(@"QQ iconurl: %@", resp.iconurl);
                
                imgUrl = resp.iconurl;
                NSLog(@"QQ gender: %@", resp.unionGender);
                NSString *stringSex = [NSString stringWithFormat:@"%@",resp.unionGender];
                if ([stringSex isEqualToString:@"男"]) {
                    sexString = @"1";
                }else if ([stringSex isEqualToString:@"女"]){
                    sexString = @"2";
                }else{
                    sexString = @"1";
                }
                
                // 第三方平台SDK原始数据
                NSLog(@" originalResponse: %@", resp.originalResponse);
                [self makeThirdLogin:resp.openid typeString:@"2"];
            }

        }];
        
        
    }else if (sender.tag ==22){// 微信
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            
            if (error) {
                
            }else{
                UMSocialUserInfoResponse *resp = result;
                
                // 授权信息
                NSLog(@"Wechat uid: %@", resp.uid);
                NSLog(@"Wechat openid: %@", resp.openid);
                NSLog(@"Wechat unionid: %@", resp.unionId);
                NSLog(@"Wechat accessToken: %@", resp.accessToken);
                NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                NSLog(@"Wechat expiration: %@", resp.expiration);
                
                // 用户信息
                NSLog(@"Wechat name: %@", resp.name);
                NSLog(@"Wechat iconurl: %@", resp.iconurl);
                imgUrl = resp.iconurl;
                NSLog(@"Wechat gender: %@", resp.unionGender);
                NSString *stringSex = [NSString stringWithFormat:@"%@",resp.unionGender];
                if ([stringSex isEqualToString:@"男"]) {
                    sexString = @"1";
                }else if ([stringSex isEqualToString:@"女"]){
                    sexString = @"2";
                }else{
                    sexString = @"1";
                }

                
                // 第三方平台SDK原始数据
                NSLog(@" originalResponse: %@", resp.originalResponse);
                
                [self makeThirdLogin:resp.openid typeString:@"1"];
            }
        }];
        
        
    }else if (sender.tag == 23){// 新浪
        
        
    }
    
    
    
}

- (IBAction)LogionAction:(id)sender {
//    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJLOGION
    NSDictionary * valudic  = @{@"phone":self.PhonetextField.text,@"password":self.PassWordTextField.text,@"uuid":UUid};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];

        if ([str isEqualToString:@"0"]) {
            /*          
             "id":"63",
            "phone":"18503866892",
            "avatar":"/Uploads/Avatar/avatar.jpg",
            "money":"0.00"
            [self showHint:@"登陆成功"];
            18703993959 */
            
            NSUserDefaults * userdefa =[NSUserDefaults standardUserDefaults];
            [userdefa setValue:data[@"data"][@"id"] forKey:@"id"];
            [userdefa setValue:data[@"data"][@"phone"] forKey:@"phone"];
            [userdefa setValue:data[@"data"][@"avatar"] forKey:@"avatar"];
            [userdefa setValue:data[@"data"][@"id"] forKey:@"useid"];
            [userdefa synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];
 
        }else{
            [self showHint:msg];
        }
        [self showHint:msg];

        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"登录失败，请稍后重试！"];
        NSLog(@"%@",error);
    }];
//    
    
}
- (void)makeThirdLogin:(NSString *)openid typeString:(NSString *)typeString{
    
    //图像
    NSURL *imageUrl = [NSURL URLWithString:imgUrl];
    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    NSData *Imagedata = UIImageJPEGRepresentation(images, 0.001);
    
    NSString *imageString = [Imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    
    
    
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UserthreeLogin
    NSDictionary * valudic  = @{@"openid":openid,@"type":typeString,@"uuid":UUid};
    
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
        }else if([status isEqualToString:@"200"]){
            
            RegistViewController * rvc =[[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
            rvc.typeStr = @"1";
            rvc.imagePath = imageString;
            rvc.openID = openid;
            rvc.loginType = typeString;
            rvc.xingbeiStr = sexString;
            [self.navigationController pushViewController:rvc animated:YES];
        }else{
            [self showHint:data[@"msg"]];
            
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
    
}


@end
