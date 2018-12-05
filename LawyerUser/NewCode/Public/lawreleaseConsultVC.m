//
//  lawreleaseConsultVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/31.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawreleaseConsultVC.h"
#import "LawSelectTypeofCaseView.h"
#import "LawConsultTypeModel.h"
#import "lawPayViewController.h"
@interface lawreleaseConsultVC (){
    NSArray * PriceLBArray;// 价格Label的数组
    BOOL  is_secret; // NO 不隐私   YES  隐私
    NSString * Price;// 悬赏金额；
}


@property (strong , nonatomic) LawSelectTypeofCaseView * selectCaseTypeView;
@property (strong , nonatomic) LawConsultTypeModel * casetypeModel;


@end

@implementation lawreleaseConsultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    is_secret = NO ;
    self.Topheight.constant = NavStatusBarHeight;
    self.ContentTextView.placeholderText = @"请输入您要咨询的问题，如案情经过、证据情况、以便 律师更好的为您解答";
    self.desLb.text= [NSString stringWithFormat:@"客服电话：%@  技术支持：律源科技",APPPhone];
    [Utile makeCorner:6 view:self.EnSureBtn];

    //    self.SmallPrice.text = @"500";
    [Utile makeCorner:10 view:self.FirstLb];
    [Utile makeCorner:10 view:self.SecondLB];
    [Utile makeCorner:10 view:self.ThirdLB];
    [Utile makeCorner:10 view:self.FourLB];
    [self priceLBView];
    
    if ([self.type isEqualToString:@"2"]) {
        self.middlView.hidden = YES ;
        self.BottomVIewTop.constant = -44;
        [self addCenterLabelWithTitle:@"免费咨询" titleColor:nil];

    }else{
        [self addCenterLabelWithTitle:@"悬赏咨询" titleColor:nil];
         self.LabelT.text = @"支付赏金并发布";
 
        
        
    }
    [self makePricData];
    [self.typeLB whenTapped:^{
        [self showTypeVIew];
    }];

    [self.view addSubview:self.selectCaseTypeView];

    // Do any additional setup after loading the view from its nib.
}
#pragma mark
-(void)showTypeVIew{
    self.selectCaseTypeView.hidden = NO;
}

-(LawSelectTypeofCaseView *)selectCaseTypeView{
    if (!_selectCaseTypeView) {
        _selectCaseTypeView  =[[LawSelectTypeofCaseView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        LawSelectTypeofCaseView *extractedExpr = _selectCaseTypeView;
        
        extractedExpr.dataArray = [[NSMutableArray alloc]initWithObjects:self.casetypeModel, nil];
        MJWeakSelf
        _selectCaseTypeView.hidden = YES;
        _selectCaseTypeView.MaxNumber = 1;
        _selectCaseTypeView.selectBlock = ^(NSArray *seleArray) {
            
            if(seleArray.count  > 0){
                weakSelf.casetypeModel = seleArray[0];
                weakSelf.typeLB.text  = weakSelf.casetypeModel.name;
            }
            
            
        };
    }
    return _selectCaseTypeView;
}
-(void)priceLBView{
    PriceLBArray =@[self.PriceOneLB,self.PriceTwoLB,self.PriceThreeLB,self.PriceFourLB];
   
    for (UILabel * laabel in PriceLBArray) {
        [Utile makecorner:3 view:laabel color:[UIColor colorWithHex:0xFC6F4A]];
        [laabel whenTapped:^{
            [self makePriceWihtback];
            laabel.backgroundColor = [UIColor colorWithHex:0xFC6F4A];
            laabel.textColor =[UIColor whiteColor];
            self->Price  = [laabel.text  stringByReplacingOccurrencesOfString:@"元" withString:@""] ;
        }];
     }
 }
-(void)makePriceWihtback{
    for (UILabel * laabel in PriceLBArray) {
        laabel.backgroundColor = [UIColor whiteColor];
        laabel.textColor = [UIColor colorWithHex:0xFC6F4A];
    }
 }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)makePricData{
    
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    LawMaingetsysMoney
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            NSArray * tempArray = [[NSArray alloc]initWithArray:data[@"data"][@"consult_money"]];
            if (tempArray.count > 0){
                 int   i = 0 ;
                for (NSString * money in tempArray) {
                    if(i < PriceLBArray.count){
                        UILabel * label =  (UILabel *)PriceLBArray[i];
                        label.text =[NSString stringWithFormat:@"%@元",money];
                        i++;
                    }
                    
                }
                
            }
        }
    } failure:^(NSError *error) {
  
        
    }];
    
    
    
    
    
}

- (IBAction)privacyAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)QuestAction:(UIButton *)sender {
    NSLog(@"提示");
    
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"关于私密咨询" message:@"\n·您的咨询内容不会向其他用户公开，仅律师可见 \n\n·发布私密咨询不需支付服务费，您可以通过采纳、送心意等方式向律师表达谢" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAler =[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:sureAler];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)EnSureAction:(UIButton *)sender {
      if (self.casetypeModel == nil) {
        [self showHint:@"请选择案件类型"];
        return ;
    }else if (self.ContentTextView.text.length == 0){
        [self showHint:@"请输入您的咨询内容"];
        return ;
    }
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    if([self.type isEqualToString:@"1"]){
        //      悬赏
        if(!Price){
            [self showHint:@"请选择悬赏金额"];
            return ;
        }
        addRewardConsult
        [valueDic setObject:[NSString stringWithFormat:@"%@",Price ] forKey:@"money" ];

    }else{
         addFreeConsult
    }

    
    
        [valueDic setObject:[NSString stringWithFormat:@"%@",UserId ] forKey:@"uid" ];
        [valueDic setObject:[NSString stringWithFormat:@"%@",self.casetypeModel.id ] forKey:@"cate_id" ];
        [valueDic setObject:[NSString stringWithFormat:@"%@",self.ContentTextView.text ] forKey:@"content" ];
    if(!is_secret){
        [valueDic setObject:[NSString stringWithFormat:@"0"] forKey:@"is_secret" ];
     }else{
         [valueDic setObject:[NSString stringWithFormat:@"1"] forKey:@"is_secret" ];

    }
    
    
    MJWeakSelf
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            if([self.type isEqualToString:@"2"]){
                [self.navigationController popViewControllerAnimated: YES];
            }else{
                if (![self.type isEqualToString:@"2"]) {
                    lawPayViewController * lawrevc  = [[lawPayViewController alloc] initWithNibName:@"lawPayViewController" bundle:nil];
                    lawrevc.Type = @"4";
                    lawrevc.PayId = data[@"data"][@"id"];
                    lawrevc.Pricestr=Price;
                    [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                }
            }
            
        }else{
            [self showHint:data[@"msg"]];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
    }];
    
    
    
}
@end
