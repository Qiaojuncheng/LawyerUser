//
//  lawPhonePayVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPhonePayVC.h"

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
