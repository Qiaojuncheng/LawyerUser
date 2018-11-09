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
 

}

@end

@implementation lawPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AirPayBtn.hidden = YES ;
    self.YeLB.hidden = YES ;
    BtnArary =@[self.WXpayBtn,self.AirPayBtn,self.YeBtn,self.VipPayBtn];
    self.BottomPayView.hidden = YES ;
    [self addCenterLabelWithTitle:@"请选择支付方式" titleColor:nil];

    if([self.Type isEqualToString:@"1"]){
        self.VIPPayView.hidden = YES ;
        self.YePayView.hidden = YES ;
        self.PayTypeName.text = @"充值金额";
        [self addCenterLabelWithTitle:@"充值中心" titleColor:nil];

    }else if([self.Type isEqualToString:@"2"]){
        self.VIPPayView.hidden = YES ;
        self.PayTypeName.text = @"送心意";
        self.PriceTextField.text =[NSString stringWithFormat:@"￥%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;

    }else if([self.Type isEqualToString:@"3"]){
        self.VIPPayView.hidden = YES ;
        self.YePayView.hidden = YES ;
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
        self.BottomPayView.hidden = NO ;
        self.BottomPayBtn.hidden = YES ;
        self.BottomPayBtnHright.constant = 0;
        payType =@"2";
    }else if([self.Type isEqualToString:@"5"]){
        self.PayTypeName.text = @"预约面谈";
        self.PriceTextField.text =[NSString stringWithFormat:@"￥%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;

        
    }else if([self.Type isEqualToString:@"6"]){
        self.PayTypeName.text = @"案件委托";
        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
    }else if([self.Type isEqualToString:@"7"]){
        self.PayTypeName.text = @"发律师函";
        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
    }else if([self.Type isEqualToString:@"8"]){
        self.PayTypeName.text = @"合同审查";
        self.PriceTextField.text =[NSString stringWithFormat:@"%@",self.Pricestr];
        self.PriceTextField.userInteractionEnabled = NO ;
    }else if([self.Type isEqualToString:@"9"]){
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
            [self getPayInfo];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
 }


// 获取支付信息  调用支付宝、微信、余额、套餐
-(void)getPayInfo{
    
         NSDictionary * dic  =[[NSMutableDictionary alloc]init];
        NewUserPay
    NSDictionary * valudic =[[NSMutableDictionary alloc]init] ;
    [valudic setValue:self.PayId forKey:@"id"];
    [valudic setValue:payType forKey:@"type"];
        [valudic setValue:self.PriceTextField.text forKey:@"money"];
        NSString * baseStr = [NSString getBase64StringWithArray:valudic];
        [dic setValue:baseStr forKey:@"value"];
        
        [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
            NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
            
            if ([str isEqualToString:@"0"]) {
                //         只有微信充值
                
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
 
}















- (IBAction)ChongzhiAction:(UIButton *)sender {
    if([self.Type isEqualToString:@"1"]){// 充值
     [self UserChongZhi];// 获取充值信息
        
    }else if([self.Type isEqualToString:@"2"]){// 悬赏咨询
        [self getPayInfo];
        
    }
    
    
}

- (IBAction)PayBtnAction:(UIButton *)sender {
    for (UIButton * tempBtn in BtnArary) {
        tempBtn.selected = NO ;
    }
    sender.selected = YES ;
    
}



@end
