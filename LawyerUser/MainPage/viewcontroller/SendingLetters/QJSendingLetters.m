//
//  QJSendingLetters.m
//  Lawyer
//
//  Created by MYMAc on 2017/7/28.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJSendingLetters.h"
#import "QJNearCell.h"
#import "QJlawyerDetailsViewController.h"
#import "QJMainTapShwoView.h"
#import "QJSLMiddleView.h"
#import "QJMiddleBuyView.h"
#import "QJSelectItemView.h"

#import "WYWenShuViewController.h"
#import "QJPayViewController.h"
#import "QJVipVc.h"


#import "QJLayerLettersmiddleView.h"

#import "DatePickerView.h"
@interface QJSendingLetters ()<DatePickerViewDelegate,UITextViewDelegate,UITextFieldDelegate>{

    QJLayerLettersmiddleView * Topleshowview;
    NSString *  party_information;
    DatePickerView * selectPick ;
    UIView * _backWindowView;
    NSString * timeStr;
    NSString * PriceStr;
    
    NSMutableArray * DataArray1;// 案件领域的数据
    NSMutableArray *listArr;

    NSString * typeStr;
    NSString *contract_type;
    QJMiddleBuyView * middleBuyview;
    NSString *moneyStr;
    QJSLMiddleView * middleshowview;

}


@property (strong, nonatomic)   UIView *TvHeaderView;
@end

@implementation QJSendingLetters

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文书规范";
    DataArray1 = [NSMutableArray array];
    listArr = [NSMutableArray array];
    
    contract_type = [NSString stringWithFormat:@""];
    
    [self makeTV];
    [self makeConsultGetData];
   // [self makeBackItem];
    
    // Do any additional setup after loading the view from its nib.
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
            [DataArray1 addObjectsFromArray:data[@"data"][@"categoryList"]];
            
            for (NSDictionary *dica in DataArray1) {
                [listArr addObject:[dica objectForKey:@"cat_name"]];
            }
            moneyStr  = [NSString stringWithFormat:@"%@",data[@"data"][@"config"]];
            
            middleBuyview.ShwoMessageLB.text = [NSString stringWithFormat:@"服务费%@元，购买套餐可以免费服务",moneyStr];
            [Utile setUILabel:middleBuyview.ShwoMessageLB data:[NSString stringWithFormat:@"服务费%@元，",moneyStr] setData:@"购买套餐" color:MAINCOLOR font:14 underLine:NO];
            
            
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [_TV reloadData];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"案件类型以及服务费%@",error);
    }];
    
}

-(void)makeTV{

    //dataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    _TV =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight ) style:UITableViewStylePlain];
    _TV.delegate = self;
    _TV.dataSource= self;
    _TV.backgroundColor = MainBackColor;
    _TV.tableFooterView = [[UIView alloc]init];
    _TV.tableHeaderView = [self makeTvHeaderView ];
    [self.view addSubview:_TV];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    QJNearCell  *cell =[tableView dequeueReusableCellWithIdentifier:@"celll"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"QJNearCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    QJlawyerDetailsViewController * lvc= [[QJlawyerDetailsViewController alloc]init];
//    
//    self.navigationController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:lvc animated:YES];
//    
//    NSLog(@"indexPath.row  = %ld",(long)indexPath.row);
//    
}

-(UIView *)makeTvHeaderView{

   // NSArray * typtArray =@[@"纠纷",@"财产纠纷",@"需要类别",@"请求",@"本地",@"类型",];
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 632)];
    
    headerView.backgroundColor =MainBackColor;
    QJMainTapShwoView * topshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJMainTapShwoView" owner:self options:nil]lastObject];
    topshowview.topImage.image = [UIImage imageNamed:@"l-file-3"];
    topshowview.oneLab.text = [NSString stringWithFormat:@"文书规范"];
    topshowview.frame = CGRectMake(0, 0, ConentViewWidth, topshowview.height);
    [topshowview.WenshuView whenTapped:^{
        NSLog(@" 文书")  ;
        WYWenShuViewController *wenshu = [[WYWenShuViewController alloc]init];
        wenshu.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wenshu animated:NO];
        
        
    }];
    
    [headerView addSubview:topshowview];
    
   
    Topleshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJLayerLettersmiddleView" owner:self options:nil]lastObject];
    Topleshowview.frame = CGRectMake(0,  topshowview.bottom , ConentViewWidth, Topleshowview.height);
    Topleshowview.PriceTextField.delegate = self;
    [headerView addSubview:Topleshowview];
    Topleshowview.AreaLb.text = @"请选择案件领域";
    [Topleshowview.AreaLb whenTouchedUp:^{
        QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt= @"案件领域";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:listArr] ;
        seleView.selectWithIndexBlcik = ^(int index) {

            contract_type = DataArray1[index][@"cat_id"];
            Topleshowview.AreaLb.text =listArr[index];
        };
        [self.view addSubview:seleView];
        [seleView showView];
        
    }];
    
    NSArray * typtArray =@[@"个人",@"公司"];
    NSArray *intArray = @[@"1",@"2"];
    
    Topleshowview.PerInfoLB.text= @"请选择当事人信息";
    [Topleshowview.PerInfoLB whenTouchedUp:^{
        QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt= @"当事人信息";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:typtArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
           
            party_information = intArray[index];
            Topleshowview.PerInfoLB.text =typtArray[index];
        };
        [self.view addSubview:seleView];
        [seleView showView];
        
    }];
    
    Topleshowview.TimeLb.text = [NSString stringWithFormat:@"请选择交付时间"];
    [Utile addClickEvent:self action:@selector(diChoseTime) owner:Topleshowview.TimeLb];
    
    
    [headerView addSubview:Topleshowview];
    
    
    
    
    
    middleshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJSLMiddleView" owner:self options:nil]lastObject];
    middleshowview.frame = CGRectMake(0,  Topleshowview.bottom +1, ConentViewWidth, middleshowview.height);
    [headerView addSubview:middleshowview];
    middleshowview.TypeLabel.text = @"请选择类型";
  
    NSString *phoneStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]];
    if ([Utile stringIsNil:phoneStr]) {
        
    }else{
        middleshowview.PhoneField.text = phoneStr;
    }
    
    
 
    
    middleBuyview =[[[NSBundle mainBundle] loadNibNamed:@"QJMiddleBuyView" owner:self options:nil]lastObject];
    middleBuyview.frame = CGRectMake(0,  ConentViewHeight - middleBuyview.height, ConentViewWidth, middleBuyview.height);
    [headerView addSubview:middleBuyview];
    
    [middleBuyview.ShwoMessageLB whenTapped:^{
        NSLog(@"tap");
        
        QJVipVc * sevc =[[QJVipVc alloc]init];
        sevc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:sevc animated:YES];
    }];
    
    [middleBuyview.BaojiaButton whenTapped:^{
        NSLog(@"报价button");
        [self tijiaoButon];
   
    }];
   
    if (middleBuyview.top  < middleshowview.bottom ) {
        middleBuyview.frame = CGRectMake(0, middleshowview.bottom + 20, ConentViewWidth, middleBuyview.height);
     }
        
        
    
    
    headerView.height = middleBuyview.bottom;

     return headerView;
}
#pragma mark 文书规范
- (void)tijiaoButon{
    
    [self.view endEditing:YES];
    if ([Utile stringIsNil:middleshowview.TextView.text]) {
        [self showHint:@"描述不能为空！"];
        return;
    }
    if ([Utile stringIsNil:contract_type]) {
        [self showHint:@"请选择类型"];
        return;
    }
    
    
    if ([Utile stringIsNil:middleshowview.PhoneField.text]) {
        [self showHint:@"手机号码不能为空！"];
        return;
    }
    
    if ([Utile stringIsNil:middleshowview.EmailField.text]) {
        [self showHint:@"邮箱不能为空"];
        return;
    }
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultdoDocument
    NSDictionary * valudic  = @{@"user_id":UserId,@"contract_description":middleshowview.TextView.text,@"contract_type":contract_type,@"phone":middleshowview.PhoneField.text,@"email":middleshowview.EmailField.text,@"party_information":party_information,@"time":timeStr,@"offer":PriceStr};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"文书规范%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            Topleshowview.AreaLb.text = @"请选择案件领域";
            contract_type = @"";

            Topleshowview.PerInfoLB.text= @"请选择当事人信息";
            party_information = @"";

            Topleshowview.PriceTextField.text=@"";
            PriceStr =@"";
        Topleshowview.TimeLb.text = [NSString stringWithFormat:@"请选择交付时间"];
            timeStr= @"";
            
            middleshowview.TypeLabel.text = @"请选择类型";
            middleshowview.EmailField.text =@"";
            middleshowview.TextView.text = @"";
            contract_type= @"";
            
            QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.title = @"法律服务支付";
            pavVc.payType = @"2";
            pavVc.payID = data[@"data"];
            pavVc.BuyConcent = @"5";
            pavVc.payName= [NSString stringWithFormat:@"%@服务费",self.title];
            pavVc.payPrice= moneyStr;
            pavVc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:pavVc animated:YES];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"登录失败，请稍后重试！"];
        NSLog(@"文书规范%@",error);
    }];

}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    PriceStr = textField.text;
    return YES ;
    
}
#pragma mark  选择时间
- (void)diChoseTime{
    [self didTimeButton];
    
}
#pragma mark 随访时间 start time
- (void)didTimeButton{
    if(selectPick==nil){
        _backWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight)];
        _backWindowView.backgroundColor = [UIColor blackColor];
        _backWindowView.alpha = 0.5;
        
        
        [self.view addSubview:_backWindowView];
        selectPick = [DatePickerView datePickerView];
        selectPick.delegate = self;
        selectPick.type = 0;
        selectPick.frame= CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
        [self.view addSubview:selectPick];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            selectPick.frame = CGRectMake(0, ConentViewHeight-184, ConentViewWidth, 184);
        } completion:^(BOOL finished) {
        }];
        
    }else{
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_backWindowView removeFromSuperview];
            _backWindowView = nil;
            selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
        } completion:^(BOOL finished) {
            [selectPick removeFromSuperview];
            selectPick = nil;
        }];
    }
    
    
    
}
- (void)getcancel{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_backWindowView removeFromSuperview];
        _backWindowView = nil;
        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
    } completion:^(BOOL finished) {
        [selectPick removeFromSuperview];
        selectPick = nil;
    }];
    
}
- (void)getSelectDate:(NSString *)date type:(DateType)type {
    timeStr = [NSString stringWithFormat:@"%@", date];
    Topleshowview.TimeLb.text = [NSString stringWithFormat:@"%@", timeStr];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_backWindowView removeFromSuperview];
        _backWindowView = nil;
        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
    } completion:^(BOOL finished) {
        [selectPick removeFromSuperview];
        selectPick = nil;
    }];
    [_TV reloadData];
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
