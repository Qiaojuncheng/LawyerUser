//
//  QJConsultationVc.m
//  Lawyer
//
//  Created by MYMAc on 2017/7/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJConsultationVc.h"
#import "QJSelectItemView.h"
#import "QJPayViewController.h"

#import "QJVipVc.h"




#import <StoreKit/StoreKit.h>

@interface QJConsultationVc ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>{

    NSMutableArray * TypeArray;
    NSString *category_id;
     NSString * payPrice;
    
    
    NSString * BuyCode;
}
@property (strong, nonatomic) SKPayment *payment;
@property (strong, nonatomic) SKMutablePayment *g_payment;



@end

@implementation QJConsultationVc
- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"咨询";
    BuyCode = @"ServiceFee01";
    [super awakeFromNib];
    TypeArray = [NSMutableArray array];
    
    self.TitleTextField.enabled = NO;
    self.ContentTextView.placeholderText =@"请输入您的咨询内容";
    self.OneLB.layer.masksToBounds = YES;
    self.OneLB.layer.cornerRadius = 5;
    
    self.TwoLB.layer.masksToBounds = YES;
    self.TwoLB.layer.cornerRadius = 5;
    
    self.ThreLB.layer.masksToBounds = YES;
    self.ThreLB.layer.cornerRadius = 5;
    
    self.FouLB.layer.masksToBounds = YES;
    self.FouLB.layer.cornerRadius = 5;
    
    _EnSureBtn.layer.masksToBounds   = YES;
    _EnSureBtn.layer.cornerRadius = 10;
    _EnSureBtn.layer.borderWidth = 1;
    _EnSureBtn.layer.borderColor =[MAINCOLOR CGColor];
    _EnSureBtn.backgroundColor = LINECOLOR;
    
    [Utile addClickEvent:self action:@selector(didGouMaiTaocan) owner:self.FuwuLB];
    
    NSMutableAttributedString * attr =[[NSMutableAttributedString alloc]initWithString:self.FuwuLB.text];
    
    NSRange   strrang = [self.FuwuLB.text rangeOfString:@"购买套餐"];
    [attr  addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:strrang];
    [self.FuwuLB setAttributedText:attr];
    self.view.backgroundColor =MainBackColor;
   // [self makeTypeAction];
    [self makeConsultGetData];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 购买套餐
- (void)didGouMaiTaocan{
    QJVipVc * sevc =[[QJVipVc alloc]init];
    sevc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:sevc animated:YES];
    
}
#pragma mark  案件类型以及服务费
- (void)makeConsultGetData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultgetCategory
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"案件类型以及服务费%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [TypeArray addObjectsFromArray:data[@"data"][@"categoryList"]];
            
            self.FuwuLB.text = [NSString stringWithFormat:@"服务费%@元，购买套餐可以免费服务",data[@"data"][@"config"]];
            [Utile setUILabel:self.FuwuLB data:[NSString stringWithFormat:@"服务费%@元，",data[@"data"][@"config"]] setData:@"购买套餐" color:MAINCOLOR font:14.0 underLine:NO];
            payPrice = data[@"data"][@"config"];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self makeTypeAction];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"案件类型以及服务费%@",error);
    }];

}

-(void)makeTypeAction{
    
   // TypeArray =[[NSMutableArray alloc]initWithObjects:@"纠纷",@"不纠纷",@"婚姻纠纷",@"财产纠纷",@"经济纠纷", nil];
 
    [self.view endEditing:YES];
    NSMutableArray *listArr = [NSMutableArray array];
    for (NSDictionary *dica in TypeArray) {
        [listArr addObject:[dica objectForKey:@"cat_name"]];
    }
    
    [_TypeLabel whenTapped:^{
        [self.view endEditing:YES];
    QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
    seleView.ViewTitlt= @"纠纷类型";
        _TypeLabel.text = @"请选择案件类型";
    seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:listArr] ;
    seleView.selectWithIndexBlcik = ^(int index) {
     _TypeLabel.text  = listArr[index];
        category_id = TypeArray[index][@"cat_id"];
    };
      
        
    [self.view addSubview:seleView];
    [seleView showView];
 }];

    [self.PersonOrCompany whenTapped:^{
         [self.view endEditing:YES];
        QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt= @"当事人信息";
//        _TypeLabel.text = @"请选择当事人信息";
        NSArray * perArray  =@[@"个人",@"公司"];
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:perArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
            _TitleTextField.text  = perArray[index];
         };
        [self.view addSubview:seleView];
        [seleView showView];

    }];
        
 }
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"view.subviews = %@",self.view.subviews);

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 添加咨询信息
- (IBAction)EnSureAction:(id)sender {
    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//    [self requestProductData:@"ServiceFee01"];
//    return ;
    
    if ([Utile stringIsNil:category_id]) {
        [self showHint:@"案件类型不能为空！"];
        return;
    }
    
    if ([Utile stringIsNil:_TitleTextField.text]) {
        [self showHint:@"当事人信息不能为空！"];
        return;
    }
    
    if ([Utile stringIsNil:_ContentTextView.text]) {
        [self showHint:@"咨询内容不能为空！"];
        return;
    }
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultdoConsult
    NSDictionary * valudic  = @{@"category_id":category_id,@"title":_TitleTextField.text,@"user_id":UserId,@"content":_ContentTextView.text};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"添加咨询信息%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            category_id = @"";
            _TitleTextField.text = @"";
            _ContentTextView.text = @"";
            _TypeLabel.text = @"请选择案件类型";

            
             QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.title = @"咨询支付";
             pavVc.payType = @"2";
            pavVc.BuyConcent= @"1";
            pavVc.payID = data[@"data"];
             pavVc.payName= [NSString stringWithFormat:@"%@服务费",self.title];
             pavVc.payPrice= payPrice;
             pavVc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:pavVc animated:YES];

        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
         NSLog(@"添加咨询信息%@",error);
    }];

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
