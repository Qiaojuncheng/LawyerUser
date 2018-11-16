//
//  lawPhonePayVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPhonePayVC.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface lawPhonePayVC (){
    NSArray * BtnArary ;

    NSString * PayCon ;// 支付方式 微信等
    
    NSString * moneyStr ;// 可用金额

}
@end

@implementation lawPhonePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"电话咨询服务费" titleColor:nil];
    [self requestData];
    self.AirPayBtn.hidden = YES ;
    self.YeLB.hidden = YES ;
    self.PriceTextField.text = [NSString stringWithFormat:@"￥%@",self.Pricestr];
    self.PriceLB.text=  self.PriceTextField.text;
    BtnArary =@[self.WXpayBtn,self.AirPayBtn,self.YeBtn];
    [Utile makeCorner:self.headerImage.height/2 view:self.headerImage];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,self.model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.LawName.text=  self.model.name;
    
    CGFloat labelleft = 0;
    for (NSString * typeTitle in self.model.cate_name) {
        
        CGSize labWidth =   [NSString  GetHeightWithMaxSize:CGSizeMake(100, 22) AndFont:[UIFont systemFontOfSize:13] AndText:typeTitle];
        
        UILabel* typeLabel  =[[UILabel alloc]initWithFrame:CGRectMake(labelleft, 0, labWidth.width + 10, 22)];
        typeLabel.font = [UIFont systemFontOfSize:13];
        labelleft += typeLabel.width + 10;
        typeLabel.text  = typeTitle;
        typeLabel.textColor =[UIColor colorWithHex:0x999999];
        
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [Utile  makecorner:3 view:typeLabel color:[UIColor colorWithHex:0x999999]];
        [self.ShowVIew addSubview:typeLabel];
    }

    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)PayAction:(id)sender {
    if ([PayCon isEqualToString:@"3"]) {
//        余额支付
        [self YuEpay];
    }else if([PayCon isEqualToString:@"1"]){
        
        [self getWxPayData];
    }
}



#pragma  mark  余额支付
-(void)YuEpay{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewYuEPay
    NSDictionary * valudic =[[NSMutableDictionary alloc]init] ;
    [valudic setValue:self.PayId forKey:@"id"];
    [valudic setValue:@"3" forKey:@"type"];
    [valudic setValue:UserId forKey:@"uid"];
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
 
        if ([str isEqualToString:@"0"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
        }
        [self showHint:data[@"msg"]];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


- (IBAction)PayBtnAction:(UIButton *)sender {
    for (UIButton * tempBtn in BtnArary) {
        tempBtn.selected = NO ;
    }
    sender.selected = YES ;
    if (sender.tag == 31) {
        PayCon = @"1";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXpayResult:) name:@"PAYSTATUE" object:nil];

    }else if (sender.tag == 32){
        PayCon = @"2";
    }else if (sender.tag ==33){
        PayCon = @"3";
     }
}


// 获取余额
- (void)requestData {
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJAddvicegetMoney
    if( !IsLogin){
        return ;
    }
    NSDictionary * valudic  = @{@"id":UserId,@"type":@"1"};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            moneyStr =[NSString stringWithFormat:@"%@",data[@"data"][@"money"]];
            self.CanuserLB.text =[NSString stringWithFormat:@"可用金额%@元",moneyStr];
            if([moneyStr floatValue] <= [[self.PriceTextField.text stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue]){
                self.YeLB.hidden = NO ;
                self.YeBtn.hidden = YES;
                
            }
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
    
}


-(void)getWxPayData{        //请求 参数 token
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewGetwxPay
    if( !IsLogin){
        return ;
    }
    NSMutableDictionary * valudic  = [[NSMutableDictionary alloc]init];
    [valudic setValue:self.PayId forKey:@"id"];
    [valudic setValue:@"3" forKey:@"type"];
    [valudic setValue:UserId forKey:@"uid"];
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSDictionary * dict  = data[@"data"];
            if(dict != nil){
                NSMutableString *retcode = [dict objectForKey:@"appid"];
                if (retcode.length > 0){
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    //调起微信支付
                    PayReq* req = [[PayReq alloc] init];
                    req.partnerId = [dict objectForKey:@"partnerid"];// 商家ID
                    req.prepayId            = [dict objectForKey:@"prepayid"];// 订单号
                    req.nonceStr = [dict objectForKey:@"noncestr"]; /** 随机串，防重发 */
                    req.timeStamp = stamp.intValue;/** 时间戳，防重发 */
                    req.package             = [dict objectForKey:@"package"];/** 商家根据财付通文档填写的数据和签名 */
                    req.sign                = [dict objectForKey:@"sign"];/** 商家根据微信开放平台文档对数据做的签名 */
                    [WXApi sendReq:req];
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                }
                
            }
        }
        [self hideHud];
        
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
    
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WXpayResult" object:nil];
}
-(void)WXpayResult:(NSNotification *)info{
    
    PayResp *  payRespay = (PayResp *)info.object;
    int payCode = payRespay.errCode;
    NSString * payResoult ;
    if (payCode == 0) {
        payResoult = @"支付成功";
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if (payCode == -1) {
        payResoult = @"支付失败，请稍后再试！";
    } else if (payCode == -2) {
        payResoult = @"您已u取消支付！";
    } else {
        payResoult = [NSString stringWithFormat:@"%@",payRespay.errStr];
    }
    
    [self showHint:payResoult];
    
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
