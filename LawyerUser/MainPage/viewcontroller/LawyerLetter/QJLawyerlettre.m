//
//  QJLawyerlettre.m
//  Lawyer
//
//  Created by MYMAc on 2017/8/3.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJLawyerlettre.h"

#import "QJNearCell.h"
#import "QJlawyerDetailsViewController.h"
#import "QJMainTapShwoView.h"
#import "QJLayerLettersmiddleView.h"
#import "QJMiddleBuyView.h"
#import "QJSelectItemView.h"

#import "DatePickerView.h"

#import "QJPayViewController.h"
#import "QJVipVc.h"

#import "LPlaceholderTextView.h"

@interface QJLawyerlettre ()<DatePickerViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
    
    LPlaceholderTextView * _textVeiw;
    NSMutableArray * DataArray1;// 案件领域的数据
    NSMutableArray *listArr;
    
    NSString * typeStr;
    NSString *moneyStr;//服务费
    NSString *party_information;//当事人信息
    NSString *lawyer_field;//法律领域
    NSString *timeStr;//时间
    NSString *PriceStr;// 价格
    NSString * contenttext; // 内容
    
    UIView *_backWindowView;
    DatePickerView * selectPick;
    QJMiddleBuyView * middleBuyview;
    QJLayerLettersmiddleView * middleshowview;
    
}


@property (strong, nonatomic)   UIView *TvHeaderView;


@end

@implementation QJLawyerlettre
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发律师函";
    
    DataArray1 = [NSMutableArray array];
    listArr = [NSMutableArray array];
    
    [self makeConsultGetData];
  //  [self makeBackItem];
    [self makeTV];
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
    
   // dataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    _TV =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight ) style:UITableViewStylePlain];
    _TV.backgroundColor = MainBackColor;
    _TV.delegate = self;
    _TV.dataSource= self;
    _TV.tableFooterView = [[UIView alloc]init];
    _TV.tableHeaderView = [self makeTvHeaderView];
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
    
}

-(UIView *)makeTvHeaderView{
    
    NSArray * typtArray =@[@"个人",@"公司"];
    NSArray *intArray = @[@"1",@"2"];
    
    
    
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 480)];
    
    headerView.backgroundColor =MainBackColor;
    QJMainTapShwoView * topshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJMainTapShwoView" owner:self options:nil]lastObject];
    topshowview.topImage.image = [UIImage imageNamed:@"l-file"];
    topshowview.imageView.hidden = YES;
    topshowview.frame = CGRectMake(0, 0, ConentViewWidth, topshowview.height);
    [topshowview.WenshuView whenTapped:^{
        NSLog(@" 文书")  ;
    }];
    
    [headerView addSubview:topshowview];
    
    
    
    middleshowview =[[[NSBundle mainBundle] loadNibNamed:@"QJLayerLettersmiddleView" owner:self options:nil]lastObject];
    middleshowview.frame = CGRectMake(0,  topshowview.bottom +10, ConentViewWidth, middleshowview.height);
    middleshowview.PriceTextField.delegate = self;
    [headerView addSubview:middleshowview];
    middleshowview.AreaLb.text = @"请选择案件领域";
    [middleshowview.AreaLb whenTouchedUp:^{
        NSLog(@"类型");
         QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
        seleView.ViewTitlt= @"案件领域";
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:listArr] ;
        seleView.selectWithIndexBlcik = ^(int index) {
            lawyer_field = DataArray1[index][@"cat_id"];
            middleshowview.AreaLb.text =listArr[index];
        };
        [self.view addSubview:seleView];
        [seleView showView];

    }];
    
    middleshowview.PerInfoLB.text= @"请选择当事人信息";
     [middleshowview.PerInfoLB whenTouchedUp:^{
            QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
            seleView.ViewTitlt= @"当事人信息";
            seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:typtArray] ;
            seleView.selectWithIndexBlcik = ^(int index) {
                party_information = intArray[index];
                middleshowview.PerInfoLB.text =typtArray[index];
            };
    
        
        [self.view addSubview:seleView];
        [seleView showView];
        
    }];
    
    middleshowview.TimeLb.text = [NSString stringWithFormat:@"请选择交付时间"];
    [Utile addClickEvent:self action:@selector(diChoseTime) owner:middleshowview.TimeLb];
    
    
     _textVeiw  =[[LPlaceholderTextView alloc]initWithFrame:CGRectMake(0, middleshowview.bottom+10, ConentViewWidth, 150)];
    _textVeiw.backgroundColor = [UIColor whiteColor];
    _textVeiw.placeholderText =@"请输入委托律师的需求及案件详情...";
    _textVeiw.textColor =[UIColor colorWithHex:0x333333];
    _textVeiw.delegate = self;
    self.view.backgroundColor = MainBackColor;
    [headerView  addSubview:_textVeiw];
    
    
    
    middleBuyview =[[[NSBundle mainBundle] loadNibNamed:@"QJMiddleBuyView" owner:self options:nil]lastObject];
    middleBuyview.frame = CGRectMake(0, ConentViewHeight - middleBuyview.height, ConentViewWidth, middleBuyview.height);
    [headerView addSubview:middleBuyview];
    
    [middleBuyview.ShwoMessageLB whenTapped:^{
        NSLog(@"tap");
        QJVipVc * sevc =[[QJVipVc alloc]init];
        sevc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:sevc animated:YES];
    }];
    
    [middleBuyview.BaojiaButton whenTapped:^{
        [self didBaojIAButton];

    }];
 
    if (middleBuyview.top  < _textVeiw.bottom ) {
        middleBuyview.frame = CGRectMake(0, _textVeiw.bottom + 20, ConentViewWidth, middleBuyview.height);
    }

    
    headerView.height  = middleBuyview.bottom;;

    return headerView;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    PriceStr  = textField.text;
    return  YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if(_textVeiw ==textView){
        contenttext = textView.text;
        }
    
}
#pragma mark 法律函
- (void)didBaojIAButton{
    [self.view endEditing: YES];
    
    if ([Utile stringIsNil:lawyer_field]) {
        [self showHint:@"案件领域不能为空！"];
        return;
    }
    

    if ([Utile stringIsNil:party_information]) {
        [self showHint:@"当事人信息不能为空！"];
        return;
    }
    if ([Utile stringIsNil:PriceStr]) {
        [self showHint:@"报价不能为空！"];
        return;
    }
    
    if ([Utile stringIsNil:timeStr]) {
        [self showHint:@"交付时间不能为空！"];
        return;
    }
    if ([Utile stringIsNil:contenttext]) {
        [self showHint:@"内容不能为空！"];
        return;
    }
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultsendLawyer
    NSDictionary * valudic  = @{@"user_id":UserId,@"party_information":party_information,@"time":timeStr,@"lawyer_field":lawyer_field,@"offer":PriceStr,@"content":contenttext};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"法律函%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            party_information =@"";
            timeStr =@"";
            middleshowview.TimeLb.text = [NSString stringWithFormat:@"请选择预约时间"];
            middleshowview.PriceTextField.text =@"";
            PriceStr =@"";
            lawyer_field=@"";

            middleshowview.AreaLb.text = @"请选择案件领域";
            middleshowview.PerInfoLB.text= @"请选择当事人信息";

            [_TV reloadData];
            
            
            
            QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.title = @"法律服务支付";
            pavVc.payType = @"2";
            
            pavVc.payID = data[@"data"];
            pavVc.BuyConcent = @"4";
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
        NSLog(@"法律函%@",error);
    }];

    
    
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
    middleshowview.TimeLb.text = [NSString stringWithFormat:@"%@", timeStr];
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
