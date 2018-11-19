//
//  lawFindSendHeaderVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/19.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawFindSendHeaderVC.h"
#import "lawPayViewController.h"
@interface lawFindSendHeaderVC (){
    NSArray * LBArray ;
    NSArray * moneyArray ;
}

@end

@implementation lawFindSendHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addCenterLabelWithTitle:@"送心意" titleColor:nil];
    self.topheight.constant = NavStatusBarHeight;
    LBArray =@[self.FirstLB,self.SecondLB,self.ThirdLB,self.LastLB];
    [self.LwayerHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,self.model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.lawyerNameLB.text = self.model.name;
    
    [Utile makeCorner:self.LwayerHeader.height/2  view:self.LwayerHeader  ];
    [Utile makeCorner:self.RedBackView.height/2  view:self.RedBackView  ];

    
    
    for (UILabel * label  in LBArray) {
        [Utile makecorner:3 view:label color:[UIColor colorWithHex:0xFF5E52]];
        
        UIView * labelSupView = label.superview;
        [label whenTouchedUp:^{
            [self makeSelectPriceWithIndex:label.tag - 30];
        }];
        [labelSupView createCornerRadiusShadowWithCornerRadius:5 offset:CGSizeMake(0, 2) opacity:0.1 radius:8 Color:[UIColor colorWithHex:0xD9564C]];
        
    }
    
    [self makePricData];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeSelectPriceWithIndex:(NSInteger )index{
    
    if (index < moneyArray.count) {
        self.MoneyTextField.text = moneyArray[index];
    }
    
}
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
            NSArray * tempArray = [[NSArray alloc]initWithArray:data[@"data"][@"mind_money"]];
            if (tempArray.count > 0){
                moneyArray  = [[NSArray alloc]initWithArray:tempArray];
                int   i = 0 ;
                for (NSString * money in tempArray) {
                    UILabel * label =  (UILabel *)LBArray[i];
                    label.text =[NSString stringWithFormat:@"￥%@",money];
                    i++;
                    if (i ==4) {
                        return ;
                    }

                }
            }
        }
     } failure:^(NSError *error) {
 
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

#pragma mark 送心意
- (IBAction)BottomAction:(UIButton *)sender {
    
    if(self.MoneyTextField.text.length == 0){
        
        [self showHint:@"请输入送出的心意！"];
        return;
    }
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    LawMaingetsysmind
    MJWeakSelf
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setValue:UserId forKey:@"uid"];
    [valueDic setValue:self.model.id forKey:@"lid"];
    [valueDic setValue:self.MoneyTextField.text forKey:@"money"];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
 
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            
            lawPayViewController * lawrevc  = [[lawPayViewController alloc] initWithNibName:@"lawPayViewController" bundle:nil];
            lawrevc.Type = @"2";
            lawrevc.PayId = data[@"data"][@"id"];
            lawrevc.Pricestr= self.MoneyTextField.text;
            [weakSelf.navigationController pushViewController:lawrevc animated:YES];

//            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSError *error) {
        
    }];
    
    
}
@end
