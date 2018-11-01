//
//  LawCaseAppreciateDetail.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseAppreciateDetail.h"
#import <WebKit/WebKit.h>
@interface LawCaseAppreciateDetail ()<WKNavigationDelegate,WKUIDelegate>{
    UIButton * consultBtn ;
    
}
@property (strong, nonatomic) WKWebView * webView;

@end

@implementation LawCaseAppreciateDetail

- (void)viewDidLoad {
    [super viewDidLoad];
/*
   */
    [self addCenterLabelWithTitle:self.model.title titleColor:nil];
    self.view.backgroundColor =[UIColor whiteColor];
     self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight +10, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - 68- 10)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.huirongfa.com/Wap/News/xq/app/1/id/%@.html",self.model.id]]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
     [self addBottomView];
    
    [self showHudInView:self.view hint:nil];
    // Do any additional setup after loading the view.
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
   
    [self hideHud];
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self hideHud];
    [self showHint:@"页面加载失败，请重试！"];
}
-(void)addBottomView{
    
     consultBtn =[[UIButton alloc]initWithFrame:CGRectMake(68, self.webView.bottom +10, SCREENWIDTH  - 68*2, 40)];
  
    [consultBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
    [consultBtn setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateSelected];
    
    [consultBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [consultBtn setTitleColor:[UIColor colorWithHex:0x3181FE] forState:UIControlStateNormal];
    
    if([self.model.is_collect isEqualToString:@"1"]){
        consultBtn.selected = YES;
        [consultBtn setBackgroundColor:[UIColor colorWithHex:0x3181FE]];
       
    }else{
        consultBtn.selected = NO;
        [consultBtn setBackgroundColor:[UIColor clearColor]];
        
       
    }
    
   

    consultBtn.adjustsImageWhenHighlighted = NO;
    [consultBtn addTarget:self action:@selector(CollectionAction:) forControlEvents:UIControlEventTouchUpInside];
    consultBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:consultBtn];
    [consultBtn createBordersWithColor:[UIColor colorWithHex:0x3181FE] withCornerRadius:20 andWidth:1];
 
    
}

-(void)CollectionAction:(UIButton *)sender{
    
    [self makeCollect];
   
}
-(void)makeCollect{
   
    if (IsLogin) {
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        NewCaseNewscollect
        NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
            [self showHudInView:self.view hint:nil];

            [valuedic setValue:UserId forKey:@"id"];
            [valuedic setValue:@"1" forKey:@"type"];
            [valuedic setValue:@"2" forKey:@"role"];
            [valuedic setValue:self.model.id forKey:@"tid"];
            
         NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
            __weak typeof(consultBtn)  weakConsultBtn = consultBtn;
        [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
            [self hideHud];
            // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
           
                weakConsultBtn.selected = !weakConsultBtn.selected;
                if (weakConsultBtn.selected) {
                    self.ChangCollectStatus(@"1");
                    [weakConsultBtn setBackgroundColor:[UIColor colorWithHex:0x3181FE]];
                }else{
                    self.ChangCollectStatus(@"0");
                     [weakConsultBtn setBackgroundColor:[UIColor colorWithHex:0xffffff]];
                }
            }
            [self showHint:responseObjeck[@"msg"]];
             [self hideHud];

        } failure:^(NSError *error) {
            [self hideHud];
            
        }];
            
        }else{
            
            LawLogionViewController *view = [LawLogionViewController new];
            UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
            [UIApplication sharedApplication].delegate.window.rootViewController = na;
        }
 
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
