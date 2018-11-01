//
//  XieYiViewController.m
//  DoctorProject
//
//  Created by yu on 15/9/16.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import "XieYiViewController.h"

@interface XieYiViewController ()<UIWebViewDelegate>{
    UIWebView *WebView;

}

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    self.title =@"注册协议";
    //[self makeBackItem];

    [super viewDidLoad];
    
//    [self makebackItem];
    [self mkaeIXeYi];
    // Do any additional setup after loading the view.
}
-(void)mkaeIXeYi{

    if (WebView) {
        
    }
    else{
        WebView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight  )];
        
    }
    WebView.delegate= self;
    NSString *ShouY = [NSString stringWithFormat:@"%@/user_xieyi/type/app.html",ImageUrl];
    NSURLRequest * resquest =[NSURLRequest requestWithURL:[NSURL URLWithString:ShouY]];
    [self.view addSubview: WebView];
    [WebView loadRequest:resquest];
    

}
-(void)webViewDidStartLoad:(UIWebView *)webView{
//    [self showHudInView:self.view  hint:nil];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [self hideHud];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self hideHud];
//    [self showHint:@"数据加载失败"];

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
