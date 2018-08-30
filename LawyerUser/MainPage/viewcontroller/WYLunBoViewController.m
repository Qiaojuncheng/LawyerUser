//
//  WYLunBoViewController.m
//  Lawyer
//
//  Created by yu on 2017/9/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYLunBoViewController.h"

@interface WYLunBoViewController (){
    UIWebView *webview;
}

@end

@implementation WYLunBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedView)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
        
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.lunboUrl]]]];
    [self.view addSubview:webview];
    
    // Do any additional setup after loading the view.
}
- (void)onClickedView{
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = @"http://mobile.umeng.com/social";
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
        
        
    }];
    
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

@end
