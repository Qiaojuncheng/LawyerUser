//
//  AppDelegate.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//


#import "AppDelegate.h"
//#import "MtabBatrC.h"
#import "MCTabBarController.h"
#import "IQKeyboardManager.h"
#import "GuideViewController.h"
#import "LawLogionViewController.h"
 

#import <AudioToolbox/AudioServices.h>
#import <AudioToolbox/AudioToolbox.h>
#import "WXApi.h"
#import <StoreKit/StoreKit.h>

// 高德地图
#import "AMapServices.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


static SystemSoundID shake_sound_male_id = 0;

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


 @interface AppDelegate ()<JPUSHRegisterDelegate,AMapLocationManagerDelegate,JPUSHRegisterDelegate,WXApiDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>{
  
     AMapLocationManager * _locationManager;

    
//     BMKLocationService * _locServiece;
     
     NSUserDefaults * UserDefaults;

     MCTabBarController *Tab  ;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    
    [self getPhone];
    [self getlocation];
     UserDefaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"uuid = %@",[[[[UIDevice currentDevice] identifierForVendor] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""]);
    NSString * SoundsStr = [UserDefaults  objectForKey:@"Sounds"];
 
    if(SoundsStr == nil){
        [UserDefaults  setObject:@"YES" forKey:@"Sounds"];
        [UserDefaults  setObject:@"YES" forKey:@"vibration"];

        [UserDefaults synchronize];
    }
    
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    
#pragma mark  极光设置
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"901a44bbf61d062d51ccc913"
                          channel:@"xiazeidi"
                 apsForProduction:YES];//0 (默认值)表示采用的是开发证书，1 表示采用生产证书发布应用。
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
//     登录状态改变， 更新alisa 别名
    [defaultCenter addObserver:self selector:@selector(setalias) name:KNOTIFICATION_LOGINSUCCESS object:nil];

    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"59e58f2ccae7e77537000a8b"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    
    
    
    //关闭设置为NO, 默认值为NO.
     [IQKeyboardManager sharedManager].enable = YES;
    //点击背景收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;

    
 
     //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINSUCCESS
                                               object:nil];

#pragma    mark   判断是不是 第一次登陆
    BOOL  isFirst =  YES;
    isFirst =( BOOL )[[NSUserDefaults standardUserDefaults]  boolForKey:@"MMIsFirst"];
    NSLog(@" ++  %d",isFirst);
    
    if (!isFirst) {
        GuideViewController * gvc =[[GuideViewController alloc]init];
        self.window.rootViewController  = gvc;
    }else{
        if( IsLogin){
            Tab =[[MCTabBarController alloc]init];
            //    UINavigationController *MainNavi =[[UINavigationController alloc]initWithRootViewController:Tab];
            self.window.rootViewController = Tab;

        }else{
            LawLogionViewController *view = [LawLogionViewController new];
            UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
            [UIApplication sharedApplication].delegate.window.rootViewController = na;
        }
 }
    
//  未登录通知监听
    if(!IsLogin){
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(goinglogin) name:KNOTIFICATION_COMEIN object:nil];
     }
        // Override point for customization after application launch.
    return YES;
}
-(void)goinglogin{
    LawLogionViewController *view = [LawLogionViewController new];
    UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
    [UIApplication sharedApplication].delegate.window.rootViewController = na;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"deviceToken = %@",deviceToken);
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark 设置别名
-(void)setalias{
    
    NSString * UUid  =   [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    UUid =  [UUid stringByAppendingString:UserPhone];
    NSString * md5Str = [UUid MD5];
    

    [JPUSHService setAlias:md5Str completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@" 别名 iResCode = %ld, iAlias = %@  seq = %ld",(long)iResCode,iAlias,(long)seq);
    } seq:[UUid integerValue]];
//    [JPUSHService setAlias:UserId completion:nil seq:[UserId integerValue]];
 
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    [self NOtificationWithDic:userInfo];
    // 如果是在应用内收到通知 就在通知栏清除本条通知  避免在导航栏收到通知后在执行一次
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[notification.request.identifier]];

}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    [self NOtificationWithDic:userInfo];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
       NSLog(@"通知进入获取的userInfo = %@",userInfo);
    
    [self NOtificationWithDic:userInfo];

 }

#pragma mark  极光通知处理

-(void)NOtificationWithDic:(NSDictionary *)userInfo{
    NSString *customizeField1 = [userInfo valueForKey:@"stateNumber"]; //服务端传递的Extras附加字段，key是自己定义的
    //    customizeField1 我的咨询 1 收到回复
    //     我的预约     2 有律师同意   3有律师拒绝  4 有律师点击完成提示去评价
    //     我的需求   5 律师抢单成功   6 律师点完成提示评价
//
//    if ([customizeField1 isEqualToString:@"1"])//
//    {
//        [UserDefaults setValue:@"yes" forKey:@"MyCounsment"];
//    }else if ([customizeField1 isEqualToString:@"2"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyAppoinment"];
//    }else if ([customizeField1 isEqualToString:@"3"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyNeeds"];
//    }
//    // 其他设备登录   先清除别名
//    if ([customizeField1 isEqualToString:@"1001"]) {
//        [self otherLogin];
//    }
//
//    [UserDefaults synchronize];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UPMINEUI" object:nil];
//

    
}

#pragma mark  极光在线消息处理
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
//    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"stateNumber"]; //服务端传递的Extras附加字段，key是自己定义的
/*
 所有通知首页右上角都显示红点
 1. 咨询) 您发布的咨询已经有律师回复，点击查看
 2. 电弧预约）您发布的电话咨询律师已接单，请保持电话畅通/您的电话咨询服
 3. 预约面谈）务已完成，请确认服务完成 您发布的预约面谈律师已接单，请保持电话畅通/您的预
 4. 订单）您发布的案件委托已有律师参与竞标，点击查看
 
*/

    NSLog(@"在线消息 == %@ ",customizeField1);
    // 首页必显示
    [UD setValue:@"YES"  forKey:@"showMainpageTip"];
    
//    咨询
    if([customizeField1 isEqualToString:@"1"]){
        [UD  setObject:@"YES" forKey:@"consultShow"];
     }else   if([customizeField1 isEqualToString:@"2"]){
        [UD setObject:@"YES" forKey:@"PhoneAppointShow"];
     }else  if([customizeField1 isEqualToString:@"3"]){
        [UD setObject:@"YES" forKey:@"MeetAppointShow"];
    }else  if([customizeField1 isEqualToString:@"4"]){
        [UD setObject:@"YES" forKey:@"OredrShow"];
    }
    
    
    [UD synchronize];
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushMessage" object:customizeField1];

    
//    if ([customizeField1 isEqualToString:@"1"])//
//    {
//        [UserDefaults setValue:@"yes" forKey:@"MyCounsment"];
//    }else if ([customizeField1 isEqualToString:@"2"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyAppoinment"];
//     }else if ([customizeField1 isEqualToString:@"3"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyNeeds"];
//    }
//    [UserDefaults synchronize];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UPMINEUI" object:nil];
//    // 其他设备登录   先清除别名
//    if ([customizeField1 isEqualToString:@"1001"]) {
//        [self otherLogin];
//    }
    [self playSoundAndVibration];
//     NSLog(@"自定义消息  = %@",userInfo);
}
-(void)otherLogin{
    NSLog(@"其他设备登录请 清除别名清除本地数据退出登录");
    NSUserDefaults * userdefa =[NSUserDefaults standardUserDefaults];
    [userdefa removeObjectForKey:@"id"];
    [userdefa removeObjectForKey:@"phone"];
    [userdefa removeObjectForKey:@"avatar"];
    [userdefa synchronize];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:[UserId integerValue]];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号已在其他设备上登录！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LawLogionViewController *view = [LawLogionViewController new];
        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
        [UIApplication sharedApplication].delegate.window.rootViewController = na;
        
        NSLog(@"OK Action");
    }];
    [alertController addAction:okAction];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];

    
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                           timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    NSString * SoundsStr = [UserDefaults  objectForKey:@"Sounds"];
    NSString * Vibrate  =  [UserDefaults  objectForKey:@"vibration"];
    if ([SoundsStr isEqualToString:@"YES"]) {
        // 收到消息时，播放音频
        [self playNewMessageSound];
    }
    if ([Vibrate isEqualToString:@"YES"]) {
        // 收到消息时，震动
        [self playVibration];
    }
   
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
//    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxb973ea38951812a4" appSecret:@"d9abb1a7646348c2f7612a0b5b48926a" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106396131"/*设置QQ平台的appID*/  appSecret:@"9Kli6VQwRlZSQbwK" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"660576201"  appSecret:@"f7fea9cc5cefb7e5745ade350fd255c6" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (void)loginStateChange:(NSNotification *)notification{
     Tab =[[MCTabBarController alloc]init];
    self.window.rootViewController = Tab;
}

//
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
//    
//}
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    if (userLocation != nil) {
//        NSLog(@"%f**%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//        
//        NSString *lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
//        NSString *lon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
//        NSUserDefaults *defatls = [NSUserDefaults standardUserDefaults];
//        [defatls setObject:lat forKey:@"Latitudeing"];
//        [defatls setObject:lon forKey:@"Longitudeing"];
//    }else{
//        
//    }
//    
// }


- (void)playNewMessageSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"in" ofType:@"caf"];
    // Path for the audio file
    NSLog(@"path== %@",path);
      if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
         AudioServicesPlaySystemSound(shake_sound_male_id);
 
         AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
    }
    
    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    

 }
-(void)playVibration{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
//     程序结束 调用 通知
    
     // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


 //- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
//{
//
//
//
//    NSString * urlStr =  [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
////    if (self.window) {
////        if (![urlStr hasPrefix:@"wx"]) {
////            NSString *fileNameStr = [url lastPathComponent];
////            // 路径
////            //      wangFile ;
////            NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSAllDomainsMask, YES);
////            NSString *path = [arr objectAtIndex:0];
////            NSString * CreatPath =[path stringByAppendingPathComponent:@"wangFile"];
////            [[NSFileManager defaultManager] createDirectoryAtPath:CreatPath withIntermediateDirectories:YES attributes:nil error:nil];
////            NSString *pStr = [CreatPath stringByAppendingPathComponent:fileNameStr];
////            NSLog(@"%@",pStr);
////            NSData *data = [[NSData alloc]initWithContentsOfURL:url];
////            BOOL isBol =   [data writeToFile:pStr atomically:YES];
////            //        BOOL isBol   =  [strings writeToFile:pStr atomically:YES encoding:NSUTF8StringEncoding error:&errror];
////            if (isBol) {
////                NSLog(@"yes");
////            }else{
////                NSLog(@"no");
////            }
////
////            // NSLog(@"文件已存到本地文件夹内 patch = %@",Doc);
////        }
////    }
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
//        // 其他如支付等SDK的回调
//        if ([urlStr hasPrefix:@"wx"]) {
//            return  [WXApi handleOpenURL:url delegate:self];
//        }
//    }
//    return result;
//     //return YES;
// }


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    NSLog(@" alipay -  结果 返回 9 以上 ") ;
    if ([url.host isEqualToString:@"safepay"]) {// 支付宝支付
        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //            NSLog(@"支付宝支付结果回调result = %@",resultDic);
//            NSString *resultStatus = resultDic[@"resultStatus"];
//            NSDictionary *dic = @{@"resultStatus":resultStatus, @"type":@"1"};
//            [[NSNotificationCenter defaultCenter] postNotificationName:Alipay_PayResultNotfication object:nil userInfo:dic];
//            
//        }];
//        
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            //            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            //            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
        
    }else{ //微信支付
        
        return  [WXApi handleOpenURL:url delegate:self] ;
        
    }
    return YES;
}

 #pragma mark - 支付宝
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSLog(@" alipay -  结果 返回 9 一下 ") ;
    if ([url.host isEqualToString:@"safepay"]) { // 支付宝支付
        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //            NSLog(@"result = %@",resultDic);
//            NSString *resultStatus = resultDic[@"resultStatus"];
//            NSDictionary *dic = @{@"resultStatus":resultStatus , @"type":@"1"};
//            [[NSNotificationCenter defaultCenter] postNotificationName:Alipay_PayResultNotfication object:nil userInfo:dic];
//        }];
//        /**
//         * 收到 应用跳转 回调 , 发送通知 , 在支付页面处理支付结果 ,  支付页面 block里处理网页支付的回调
//         * Appdelegate 里处理应用跳转的回调
//         */
//
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            //            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            //            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
        
    }else{// 微信支付
        
        return  [WXApi handleOpenURL:url delegate:self] ;
    }
    
    return YES;
}

#pragma  mark 微信支付回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark 微信支付代理
 -(void)onResp:(BaseResp *)resp{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PAYSTATUE" object:resp];
    
}




- (void)applicationDidBecomeActive:(UIApplication *)application {
    static NSInteger  number ;
    NSLog(@"%ld",(long)number++);
    [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)getPhone{
    
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewGetPhone ;
    
    [UserDefaults  setObject:@"400-6400-661" forKey:@"400Phone"];
    [UserDefaults synchronize];
    
    [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
        // 处理数据
        if ([responseObjeck[@"status"] integerValue] == 0){
            [UserDefaults  setObject:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"tel"]] forKey:@"400Phone"];
            
            [UserDefaults synchronize];
        }
        
    } failure:^(NSError *error) {
    }];
}
-(void)getlocation{
    [AMapServices sharedServices].apiKey =@"2849ad11590318e5cf93028db7303d8d";
    //    [AMapLocationServices sharedServices].apiKey =@"03007e10d3a5591475445e5b4ee45e64";
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        //       保存位置
            [UserDefaults setValue:[NSString stringWithFormat:@"%f",location.coordinate.latitude] forKey:@"latitude"];
            [UserDefaults setValue:[NSString stringWithFormat:@"%f",location.coordinate.longitude] forKey:@"longitude"];
            [UserDefaults synchronize];

        NSLog(@"location:%@", location);
        
     }];
}

@end
