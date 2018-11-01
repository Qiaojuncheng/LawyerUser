//
//  lawPublicLegalSevice.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/31.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPublicLegalSevice.h"
#import "LawSelectTypeofCaseView.h"
#import "LawConsultTypeModel.h"
@interface lawPublicLegalSevice ()


@property (strong , nonatomic) LawSelectTypeofCaseView * selectCaseTypeView;
@property (strong , nonatomic) LawConsultTypeModel * casetypeModel;

@end

@implementation lawPublicLegalSevice

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SmallView.hidden = YES  ;
    self.TopHeigt.constant = NavStatusBarHeight;
    self.ContentTextView.placeholderText = @"请详细描述您的委托内容（5-500字）";
//    self.SmallPrice.text = @"500";
    self.SmallPrice.userInteractionEnabled = NO ;
    [Utile makeCorner:10 view:self.CircleLB];
    [Utile makeCorner:10 view:self.OneCirceLB];
    [Utile makeCorner:10 view:self.TwoCircel];
    [Utile makeCorner:10 view:self.ThreeCircelLB];
    if ([self.type isEqualToString:@"1"]) {
        self.SmallView.hidden = NO ;
        [self addCenterLabelWithTitle:@"案件委托" titleColor:nil];

    }else  if ([self.type isEqualToString:@"2"]) {
        [self addCenterLabelWithTitle:@"发律师函" titleColor:nil];
 

    }else if ([self.type isEqualToString:@"3"]) {
        [self addCenterLabelWithTitle:@"起草合同" titleColor:nil];
 

    }else if ([self.type isEqualToString:@"4"]) {
        [self addCenterLabelWithTitle:@"合同审查" titleColor:nil];
 

    }else if ([self.type isEqualToString:@"5"]) {
//        [self addCenterLabelWithTitle:@"案件委托" titleColor:nil];

    }
 
    [self.TypeLB whenTapped:^{
        [self showTypeVIew];
    }];
    [self.view addSubview:self.selectCaseTypeView];
    [self makedata];
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
                weakSelf.TypeLB.text  = weakSelf.casetypeModel.name;
            }
            
            
        };
    }
    return _selectCaseTypeView;
}

-(void)makedata{
     NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    getServiceMoneyByType
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
         [valueDic setObject:[NSString stringWithFormat:@"%@",self.type ] forKey:@"type" ];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
      [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            self.PriceLB.text =[NSString stringWithFormat: @"￥%@",data[@"data"][@"money"]];
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

- (IBAction)AddAction:(UIButton *)sender {
    if (self.casetypeModel == nil) {
        [self showHint:@"请选择案件类型"];
        return ;
    }else if (self.ContentTextView.text.length == 0){
        [self showHint:@"请输入您的委托描述"];
        return ;
    }
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewPublicSevice
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    if(IsLogin){
        [valueDic setObject:[NSString stringWithFormat:@"%@",UserId ] forKey:@"uid" ];
        [valueDic setObject:[NSString stringWithFormat:@"%@",self.casetypeModel.id ] forKey:@"cate_id" ];
        [valueDic setObject:[NSString stringWithFormat:@"%@",self.ContentTextView.text ] forKey:@"content" ];
        [valueDic setObject:[NSString stringWithFormat:@"%@",self.type ] forKey:@"type" ];
        if ([self.type isEqualToString:@"1"]) {
            if([self.SmallPrice.text floatValue] <= [self.BigPrice.text floatValue] && [self.SmallPrice.text floatValue] >= 500){
                [valueDic setObject:[NSString stringWithFormat:@"%@ - %@",self.SmallPrice.text,self.BigPrice.text] forKey:@"user_money" ];
                
            }else {
                if ([self.SmallPrice.text floatValue] < 500) {
                    [self showHint:@"最低金额不少以500"];
                }else if([self.SmallPrice.text floatValue] > [self.BigPrice.text floatValue]){
                    [self showHint:@"金额不能低于最低金额！"];
                }
                return ;
            }
        }
    }
    
 
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            [self showHint:@"去支付"];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
    }];
}
@end
