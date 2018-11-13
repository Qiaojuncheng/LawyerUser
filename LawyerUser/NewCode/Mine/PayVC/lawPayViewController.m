//
//  lawPayViewController.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPayViewController.h"

@interface lawPayViewController (){
    NSArray * BtnArary ;
//    后台定义的
    
 NSString * payType;// 1法律服务 2咨询支付 3预约支付 4送心意 5充值
    NSString * payFangshi;// 支付方式
    NSString * moneyStr ;// 可用金额

}

@end

@implementation lawPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AirPayBtn.hidden = YES ;
    self.YeLB.hidden = YES ;
    [self requestData];
    BtnArary =@[self.WXpayBtn,self.AirPayBtn,self.YeBtn,self.VipPayBtn];
    self.BottomPayView.hidden = YES ;
    [self addCenterLabelWithTitle:@"请选择支付方式" titleColor:nil];

    if([self.Type isEqualToString:@"1"]){
        self.VIPPayView.hidden = YES ;
        self.YePayView.hidden = YES ;
        self.PayTypeName.text = @"充值金额";
        [self addCenterLabelWithTitle:@"充值中心" titleColor:nil];
        payType = @"5";

    }else if([self.Type isEqualToString:@"2"]){
        payType = @"4";

        self.VIPPayView.hidden = YES ;
        self.PayTypeName.text = @"送心意";
        self.PriceTextField.text =[NSString stringWithFormat:@"￥%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;

    }else if([self.Type isEqualToString:@"3"]){
        payType = @"6";

        self.VIPPayView.hidden = YES ;
        self.YePayView.hidden = NO ;
        self.PayTypeName.text = [NSString stringWithFormat:@"%@VIP会员",self.VIPNameStr];
        self.PriceTextField.text = [NSString stringWithFormat:@"￥%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;

    }else if([self.Type isEqualToString:@"4"]){
        self.VIPPayView.hidden = YES ;
        self.PayTypeName.text = @"需支付金额";
        self.PriceTextField.userInteractionEnabled = NO ;
        self.PriceTextField.text =[NSString stringWithFormat:@"￥%@",self.Pricestr];
        self.PriceTextField.textColor  = [UIColor colorWithHex:0xFC6F4A];
        [self addCenterLabelWithTitle:@"支付" titleColor:nil];
        self.PayPriceLBss.text = self.PriceTextField.text;
        self.BottomPayView.hidden = NO ;
        self.BottomPayBtn.hidden = YES ;
        self.BottomPayBtnHright.constant = 0;
        payType =@"2";
    }else if([self.Type isEqualToString:@"5"]){
        self.PayTypeName.text = @"预约面谈";
        self.PriceTextField.text =[NSString stringWithFormat:@"￥%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;

        payType = @"3";

    }else if([self.Type isEqualToString:@"6"]){
        payType = @"1";

        self.PayTypeName.text = @"案件委托";
        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
    }else if([self.Type isEqualToString:@"7"]){
        payType = @"1";

        self.PayTypeName.text = @"发律师函";
        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
        payType = @"1";

    }else if([self.Type isEqualToString:@"8"]){
        payType = @"1";

        self.PayTypeName.text = @"合同审查";
        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
    }else if([self.Type isEqualToString:@"9"]){
        payType = @"1";

        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
        self.PayTypeName.text = @"合同起草";
    }

    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma  mark 充值数据
-(void)UserChongZhi{
    if (![self.PriceTextField.text integerValue]) {
         [self showHint:@"请输入充值金额"];
         return ;
    }
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewUserCZ
    NSDictionary * valudic =[[NSMutableDictionary alloc]init] ;
    [valudic setValue:UserId forKey:@"uid"];
    [valudic setValue:self.PriceTextField.text forKey:@"money"];
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        
        if ([str isEqualToString:@"0"]) {
            //         只有微信充值
            self.PayId = data[@"data"][@"id"];
            payType= data[@"data"][@"type"];
//            [self getPayInfo];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
 }


#pragma  mark  余额支付
-(void)YuEpay{
    
 NSDictionary * dic  =[[NSMutableDictionary alloc]init];
        NewYuEPay
    NSDictionary * valudic =[[NSMutableDictionary alloc]init] ;
    [valudic setValue:self.PayId forKey:@"id"];
    [valudic setValue:payType forKey:@"type"];
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














// NSString * payType;// 1法律服务 2咨询支付 3预约支付 4送心意 5充值

- (IBAction)ChongzhiAction:(UIButton *)sender {
    
    
    if([payFangshi isEqualToString:@"3"]){
//       余额支付
        [self YuEpay];

    }
    
//    if([self.Type isEqualToString:@"1"]){// 充值
//     [self UserChongZhi];// 获取充值信息
//
//    }else if([self.Type isEqualToString:@"2"]){// 悬赏咨询
//        [self YuEpay];
//
//    }else if([self.Type isEqualToString:@"2"]){
//
//    }else if([self.Type isEqualToString:@"2"]){
//
//    }else if([self.Type isEqualToString:@"2"]){
//
//    }
    
    
}

- (IBAction)PayBtnAction:(UIButton *)sender {
    if(sender.tag == 30){
//  微信
        payFangshi = @"1";
    }else if(sender.tag == 31){
//  支付宝
        payFangshi =@"2";
    }else if(sender.tag == 32){
//  余额
        payFangshi =@"3";

    }else if(sender.tag == 33){
//  套餐
         payFangshi =@"4";

    }
    
    for (UIButton * tempBtn in BtnArary) {
        tempBtn.selected = NO ;
    }
    sender.selected = YES ;
    
}
#pragma mark  获取微信支付信息

-(void)getWxPayData{        //请求 参数 token
 
  
//    if(dict != nil){
//        NSMutableString *retcode = [dict objectForKey:@"appid"];
//        if (retcode.length > 0){
//            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//            //调起微信支付
//            PayReq* req = [[PayReq alloc] init];
//            req.partnerId = [dict objectForKey:@"partnerid"];// 商家ID
//            req.prepayId            = [dict objectForKey:@"prepayid"];// 订单号
//            req.nonceStr = [dict objectForKey:@"noncestr"]; /** 随机串，防重发 */
//            req.timeStamp = stamp.intValue;/** 时间戳，防重发 */
//            req.package             = [dict objectForKey:@"package"];/** 商家根据财付通文档填写的数据和签名 */
//            req.sign                = [dict objectForKey:@"sign"];/** 商家根据微信开放平台文档对数据做的签名 */
//            [WXApi sendReq:req];
//            //日志输出
//            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//        }
//
}


// 获取余额
- (void)requestData {
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJAddvicegetMoney
    if( [UserId length] < 1){
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
            self.CanUSerYuELB.text =[NSString stringWithFormat:@"可用金额%@元",moneyStr];
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

@end
