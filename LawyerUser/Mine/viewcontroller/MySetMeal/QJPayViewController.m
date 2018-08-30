//
//  QJPayViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJPayViewController.h"
#import "QJPayOneCell.h"
#import "QJTwoCell.h"
#import "QJPersonModel.h"

#import "WXApi.h"
#import "WXApiObject.h"

@interface QJPayViewController ()<UITextFieldDelegate,WXApiDelegate>{
   
    UIButton * BuyBtn;//购买按钮
    
    
/*
 payType   0 充值
        PayStyle      // 支付的方式  支付宝 0
 payType   1  套餐
            PayStyle      // 支付的方式  支付宝 0  ，余额  1
 payType   2  服务支付
        PayStyle      // 支付的方式  支付宝 0  ，余额  1  剩余次数 2
 
 payType   3   聘用律师支付
 
 
 */
    NSInteger  PayStyle;// 支付的方式  微信 0  ，余额  1   次数 2

    
    NSString * show_times;  // 显示次数
    NSString * yuEr;// 余额
    
}

@end

@implementation QJPayViewController

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self makeUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PayState:) name:@"PAYSTATUE" object:nil];
    // 购买服务或者套餐的时候才请求
    if ([self.payType isEqualToString:@"2"] ) {
        if([self.BuyConcent isEqualToString:@"6"] ||[self.BuyConcent isEqualToString:@"7"] ){
            [self makeLawyerPayInfo];
        }else{
                [self makePersonData];
        }
    }else if ([self.payType isEqualToString:@"1"]){
    
        [self makeViPperson];

    }else if ([self.payType isEqualToString:@"3"]){// 聘用律师
    
        [self PinYoongLVshiUpData];
    }
    // Do any additional setup after loading the view.
}
-(void)PayState:(NSNotification *)notfi{
    
     BaseResp  * baseResp = (BaseResp*)notfi.object;
    if (baseResp.errCode ==0) {
        [self Paysuccess];
    }else if (baseResp.errCode ==-1){
        [self showHint:@"支付失败"];
    }else{
        [self showHint:@"您已取消支付"];
    }
    
}
-(void)PinYoongLVshiUpData{
    
    yuEr = _BuyConcent;
    OneDataArray  =  [[NSArray alloc]initWithObjects:
                      @{@"Title":@"支付类型",@"desc":[NSString stringWithFormat:@"聘用律师:%@元",self.payPrice]}
                      ,@{@"Title":@"支付金额",@"desc": [NSString stringWithFormat:@"￥%@",self.payPrice]}, nil];
    TwoDataArray  =[[NSArray alloc]initWithObjects:
                    @{@"Title":@"微信支付",@"desc":@"亿万用户的选择，更快更安全",@"image":@"wx"},
                    @{@"Title":@"余额支付",@"desc":[NSString stringWithFormat:@"可用余额: %@ 元",yuEr],@"image":@"yue"},
                    nil];
    self.title = @"聘用律师支付";



}


-(void)makeViPperson{


    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJShowVIPOrder
    NSDictionary * valueDic  = @{@"order_id":self.payID,@"user_id":UserId};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            self.payPrice = data[@"data"][@"money"];// 订单金额
             yuEr =data[@"data"][@"user_money"];
            [self UpdataData ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

// 电话预约 预约面谈获取支付信息
-(void)makeLawyerPayInfo{

    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJShowBooK
    NSDictionary * valueDic  = @{@"user_id":UserId,@"id":self.payID};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            self.payPrice = data[@"data"][@"money"];// 订单金额
            show_times =data[@"data"][@"zixun_num"];
            yuEr =data[@"data"][@"user_money"];
            self.payID = data[@"data"][@"sn"];
            [self UpdataData ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}
// 购买服务或者套餐的时候才请求 支付信息
-(void)makePersonData{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ShowPay
    NSDictionary * valueDic  = @{@"user_id":UserId,@"sn":self.payID,@"type":self.BuyConcent};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {

            self.payPrice = data[@"data"][@"money"];// 订单金额
            show_times =data[@"data"][@"show_num"];
            yuEr =data[@"data"][@"user_money"];
            [self UpdataData ];
         }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)UpdataData{
    // 充值或者套餐支付 0 充值 1 套餐  2 服务支付
    if([self.payType  isEqualToString:@"1"]){// 套餐支付
        
        OneDataArray  =  [[NSArray alloc]initWithObjects:
                          @{@"Title":@"支付类型",@"desc":[NSString stringWithFormat:@"购买套餐:%@(%@元)",self.payName,self.payPrice]}
                          ,@{@"Title":@"支付金额",@"desc": [NSString stringWithFormat:@"￥%@",self.payPrice]}, nil];
        TwoDataArray  =[[NSArray alloc]initWithObjects:
                        @{@"Title":@"微信支付",@"desc":@"亿万用户的选择，更快更安全",@"image":@"wx"},
                        @{@"Title":@"余额支付",@"desc":[NSString stringWithFormat:@"可用余额: %@ 元",yuEr],@"image":@"yue"},
                        nil];
        self.title = @"套餐支付";
    }else if([self.payType  isEqualToString:@"0"]){// 充值
        
        OneDataArray  =  [[NSArray alloc]initWithObjects:
                          @{@"Title":@"支付类型",@"desc":@"￥ 请输入金额"}
                          , nil];
        TwoDataArray  =[[NSArray alloc]initWithObjects:
                        @{@"Title":@"微信支付",@"desc":@"亿万用户的选择，更快更安全",@"image":@"wx"},
                        nil];
        self.title = @"充值";
        
        
    }else if([self.payType  isEqualToString:@"2"]){// 服务支付
        
        OneDataArray  =  [[NSArray alloc]initWithObjects:
                          @{@"Title":@"支付类型",@"desc":[NSString stringWithFormat:@"%@",self.payName]}
                          ,@{@"Title":@"支付金额",@"desc": [NSString stringWithFormat:@"￥%@",self.payPrice]}, nil];
        TwoDataArray  =[[NSArray alloc]initWithObjects:
                        @{@"Title":@"微信支付",@"desc":@"亿万用户的选择，更快更安全",@"image":@"wx"},
                        @{@"Title":@"余额支付",@"desc":[NSString stringWithFormat:@"可用余额: %@ 元",yuEr],@"image":@"yue"},
                        @{@"Title":@"使用次数",@"desc":[NSString stringWithFormat:@"剩余次数: %@ 次",show_times],@"image":@"cishu"},
                        nil];
      
       

    }
    
    if (_tv) {
        [_tv reloadData];
    }
}
-(void)makeUI{
    PayStyle = 0; // 默认微信支付
    yuEr = @"0";
    show_times  = @"0";
    [self UpdataData];
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth , ConentViewHeight  - 150) style:UITableViewStyleGrouped];
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.scrollEnabled = NO;
    _tv.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_tv];
    
    
    BuyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BuyBtn.frame =CGRectMake(20, _tv.bottom + 30, ConentViewWidth  - 40, 55);
    [BuyBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [BuyBtn setBackgroundColor:[UIColor lightGrayColor]];
    [BuyBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [BuyBtn createBordersWithColor:MAINCOLOR withCornerRadius:8 andWidth:1];
    
    [BuyBtn addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:BuyBtn];
    
    
    
    
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return   OneDataArray.count;
    }else{
        return  TwoDataArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 ) {
        return 50;
        
    }else{
        return  60;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        UIView * headereView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 60)];
        headereView.backgroundColor = MainBackColor;
        UIView * baview =[[UIView alloc]initWithFrame:CGRectMake(0, 10,ConentViewWidth, 50)];
        baview.backgroundColor = [UIColor whiteColor];
        [headereView addSubview:baview];
        UILabel * title =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ConentViewWidth - 10 , 50)];
        title.text = @"支付方式";
        title.textColor = TintColor;
        [baview addSubview:title];
        return headereView ;

    }else{
        return [[UIView alloc]init];
    }
  }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section ==0 ) {
        return 0.0001;
        
    }else{
        return  60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section ==  0) {
        QJPayOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"QJPayOneCell" owner:self options:nil]lastObject];
        }
        cell.PayTypeLB.text = [OneDataArray[indexPath.row] objectForKey:@"Title"];
        cell.PayConcentTxetField.text = [OneDataArray[indexPath.row] objectForKey:@"desc"];

        if ([self.payType isEqualToString:@"0"]) {// 充值
            cell.PayConcentTxetField.tag = 23;
            cell.PayConcentTxetField.userInteractionEnabled = YES;
            cell.PayConcentTxetField.text = @"";
            cell.PayConcentTxetField.delegate = self;
            cell.PayConcentTxetField.placeholder = [OneDataArray[indexPath.row] objectForKey:@"desc"];
            cell.PayConcentTxetField.keyboardType = UIKeyboardTypeNumberPad;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else{
    
        QJTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"QJTwoCell" owner:self options:nil]lastObject];
        }
        cell.PayTypeLB.text = [TwoDataArray[indexPath.row] objectForKey:@"Title"];
        cell.DesLB.text = [TwoDataArray[indexPath.row] objectForKey:@"desc"];
        cell.Imageviewa.image =[UIImage imageNamed:[TwoDataArray[indexPath.row] objectForKey:@"image"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectBtn.userInteractionEnabled = NO;
        cell.SelectBtn.selected = NO;
        if(indexPath.row == PayStyle){
            cell.SelectBtn.selected = YES;
        }
        return  cell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
     PayStyle  =    indexPath.row;
     if([self.payType  isEqualToString:@"2"]){// 服务支付
         if (PayStyle == 1) {//余额
             OneDataArray  =  [[NSArray alloc]initWithObjects:
                               @{@"Title":@"支付类型",@"desc":[NSString stringWithFormat:@"%@",self.payName]}
                               ,@{@"Title":@"支付金额",@"desc": [NSString stringWithFormat:@"￥%@",self.payPrice]}, nil];
             
         }else if(PayStyle == 2){// 次数
             OneDataArray  =  [[NSArray alloc]initWithObjects:
                               @{@"Title":@"支付类型",@"desc":[NSString stringWithFormat:@"%@",self.payName]}
                               , nil];
             
         }
         
     }
        [_tv reloadData];
    }
}

-(void)zhifu{

     if (PayStyle == 0 )// 微信支付
    {
        if ([self.payPrice integerValue] > 0){
            if ([self.payType isEqualToString:@"0"]) {// 充值
                [self WXPay];
            }else if ([self.payType isEqualToString:@"2"]){ // 服务支付
                if ([self.BuyConcent isEqualToString:@"6"]||[self.BuyConcent isEqualToString:@"7"]) {// 预约微信支付
                    [self WXYYPay];
                }else if ([self.BuyConcent isEqualToString:@"1"]) {//咨询微信支付
                    [self WXZXPay];
                }else if ([self.BuyConcent isEqualToString:@"2"]){
                    [self WXPayFUWithType:@"2"];
                }
                else if ([self.BuyConcent isEqualToString:@"3"]){
                    [self WXPayFUWithType:@"3"];
                }
                else if ([self.BuyConcent isEqualToString:@"4"]){
                    [self WXPayFUWithType:@"4"];
                }
                else if ([self.BuyConcent isEqualToString:@"5"]){
                    [self WXPayFUWithType:@"1"];
                 }

            }else if ([self.payType isEqualToString:@"1"]){// 套餐支付
                [self WXpayTaoCan];
            }else if ([self.payType isEqualToString:@"3"]){//聘用律师
                [self WXLawyerPaym];

             }
            
            
            
            
            
            
            
            
        }else{
            [self showHint:@"请输入充值金额"];
        }
    }
    else if (PayStyle == 1) // 余额
    {
        // 余额支付先判断 余额够不够支付
            if([self.payPrice integerValue]  > [yuEr integerValue]){
            
                [self showHint:@"余额不足，请更换支付方式"];
       
            }else{// 余额支付
                if ([self.payType isEqualToString:@"1"]) {// 套餐支付
                    [self VipPayYue];
                }else if ([self.payType isEqualToString:@"3"]) {
                    [self PinYongZhifuYuE];
                
                }else{
                     if ([self.BuyConcent isEqualToString:@"1"]||[self.BuyConcent isEqualToString:@"6"]||[self.BuyConcent isEqualToString:@"7"]) {// 法律咨询支付 电话预约 预约面谈
                             [self StatusMoneyPay:@"1"];
                         } else{
                              [self PayMoney:self.BuyConcent];
                         }
                 }
            }
    }else if (PayStyle == 2){// 次数支付
        if([show_times integerValue] > 0){
//            剩余次数支付
           
            if ([self.BuyConcent isEqualToString:@"1"]||[self.BuyConcent isEqualToString:@"6"]||[self.BuyConcent isEqualToString:@"7"]) {// 法律咨询支付

                [self StatusMoneyPay:@"2"];
       
            }else{
                 [self NUmberMoney:self.BuyConcent];
             }
 
        
        }else{
            [self showHint:@"剩余次数不足，请更换支付方式"];
        }

     
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 23) {
        self.payPrice = textField.text;
    }
}

 

-(void)WXLawyerPaym{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    WXLawyerPay
    valueDic  = @{@"user_id":UserId,@"order_sn":self.PinYongoffer_ordersn};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self makeZhiFuWithSign:data[@"data"]];
        }else{
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)WXpayTaoCan{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    WXSuitPay
    valueDic  = @{@"user_id":UserId,@"id":self.payID};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self makeZhiFuWithSign:data[@"data"]];
        }else{
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)WXPayFUWithType:(NSString * )PayType{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    WXServicePay
    valueDic  = @{@"user_id":UserId,@"order_sn":self.payID,@"type":PayType};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self makeZhiFuWithSign:data[@"data"]];
        }else{
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
    
    
    
}

#pragma mark  充值  微信
-(void)WXPay{
      NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    WXPreCharge
    valueDic  = @{@"user_id":UserId,@"money":self.payPrice};
     NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
             [self makeZhiFuWithSign:data[@"data"]];
        }else{
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark 预约 微信支付
-(void)WXYYPay{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    WXYYCharge
    valueDic  = @{@"user_id":UserId,@"order_sn":self.payID};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self makeZhiFuWithSign:data[@"data"]];
        }else{
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)WXZXPay{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    WXZXCharge
    valueDic  = @{@"user_id":UserId,@"order_sn":self.payID};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self makeZhiFuWithSign:data[@"data"]];
        }else{
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)makeZhiFuWithSign:(NSDictionary  *)dict{
    
    if(dict != nil){
    NSMutableString *retcode = [dict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
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
            }else{
                //                NSLog([dict objectForKey:@"retmsg"])";
            }
        }else{
            NSLog(@"服务器返回错误，未获取到json对象");
        }
    
}
//聘用律师  余额支付
-(void)PinYongZhifuYuE{

    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QjVIPSUITYUEPay
    NSDictionary * valueDic  = @{@"id":self.payID,@"user_id":UserId,@"type":self.PinYongType,@"offer_id":self.PinYongoffer_id};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSLog(@"还未测试支付结果");
            [ self Paysuccess ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    





}
//number 支付       1: 代写文书 2：案件委托 3：审查合同 4：发律师函
-(void)NUmberMoney:(NSString *)PayType{
    NSString * paytypesss ; //      1: 代写文书 2：案件委托 3：审查合同 4：发律师函
    
    //  PayType  //  1:法律咨询 2：案件委托 3：审查合同 4：发律师函 5：代写文书
    if ([PayType isEqualToString:@"2"]) {
        paytypesss =@"2";
    }else if ([PayType isEqualToString:@"3"]){
        paytypesss =@"3";
        
    }
    else if ([PayType isEqualToString:@"4"]){
        paytypesss =@"4";
        
    }
    else if ([PayType isEqualToString:@"5"]){
        paytypesss =@"1";
        
    }
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJNumber_Pay
    NSDictionary * valueDic  = @{@"user_id":UserId,@"order_sn":self.payID,@"type":paytypesss};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSLog(@"还未测试支付结果");
            [ self Paysuccess ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}

// money 支付
//案件委托 发律师函 合同审查 代写文书 ——余额支付
-(void)PayMoney:(NSString *)PayType{
    NSString * paytypesss ; //      1: 代写文书 2：案件委托 3：审查合同 4：发律师函
 //  PayType  //  1:法律咨询 2：案件委托 3：审查合同 4：发律师函 5：代写文书
    if ([PayType isEqualToString:@"2"]) {
        paytypesss =@"2";
    }else if ([PayType isEqualToString:@"3"]){
        paytypesss =@"3";
    }
    else if ([PayType isEqualToString:@"4"]){
        paytypesss =@"4";
    }
    else if ([PayType isEqualToString:@"5"]){
        paytypesss =@"1";
    }
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJMoney_Pay
    NSDictionary * valueDic  = @{@"user_id":UserId,@"order_sn":self.payID,@"type":paytypesss};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSLog(@"还未测试支付结果");
            [ self Paysuccess ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    


}

// vip 余额支付
-(void)VipPayYue{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QjVIPSUIT_PAY
    NSDictionary * valueDic  = @{@"order_id":self.payID,@"user_id":UserId};
     NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];

    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSLog(@"还未测试支付结果");
            [ self Paysuccess ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    

}


// 法律咨询——余额or次数 支付方法  payType  1：余额支付 2：次数支付   
-(void)StatusMoneyPay:(NSString *)payType{

    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSDictionary * valueDic ;
    if ([self.BuyConcent isEqualToString:@"6"] ||[self.BuyConcent isEqualToString:@"7"] ) {
        QJChangInforSTATUS
        valueDic  = @{@"user_id":UserId,@"ordersn":self.payID,@"type":payType};
    }else{
    QJChangInfoSTARUS
        valueDic  = @{@"user_id":UserId,@"order_sn":self.payID,@"payType":payType};
    }
    
     NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSLog(@"还未测试支付结果");
            [ self Paysuccess ];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

-(void)Paysuccess{
//    [self showHint:@"支付成功"];
//    payType;// 充值或者套餐支付 0 充值 1 套餐  2 服务支付 3 聘用律师
    if([self.payType isEqualToString:@"0"] ){
        [self showHint:@"充值成功！"];
    }else if([self.payType isEqualToString:@"1"] ){
        [self showHint:@"套餐购买成功！"];
    }else if([self.payType isEqualToString:@"2"]){
        [self showHint:@"发布成功，等待回复！"];
    }else if([self.payType isEqualToString:@"3"] ){
        [self showHint:@"聘用律师成功！"];
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];

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
