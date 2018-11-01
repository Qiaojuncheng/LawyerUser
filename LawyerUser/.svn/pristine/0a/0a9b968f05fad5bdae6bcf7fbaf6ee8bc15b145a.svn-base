//
//  QJCaseDelegateViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/21.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJCaseDelegateViewController.h"
#import "QJDelegateCell.h"
#import "QJSelectItemView.h"
#import "UIView+XPKit.h"

#import "QJVipVc.h"

#import "QJPayViewController.h"
#import "DatePickerView.h"

@interface QJCaseDelegateViewController ()<UITextFieldDelegate,DatePickerViewDelegate>{


    UIView  *   _backWindowView ;

    DatePickerView * selectPick;
    NSString *   timeStr;
    NSString * fieldTitleType ;//  1 个人 2 公司

    NSMutableArray * DataArray1;// 案件领域的数据
    NSArray * DataArray2;// 案件类型的数据
    NSArray * DataArray3;// 案件时间的
    
    NSArray * DataArray4;// 案件地点
    NSString *fieldTitle;//标题
    NSString *fieldMoney;//报价
    NSString *typeStr;
    NSString *type;
    NSMutableArray *listArr;
    UILabel *labesl;
    NSString *payStr;

}

@end

@implementation QJCaseDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataArray1 = [NSMutableArray array];
    listArr = [NSMutableArray array];
    typeStr = [NSString stringWithFormat:@"请选择案件领域"];
    fieldTitle = [NSString stringWithFormat:@"请选择当事人信息"];
    timeStr = [NSString stringWithFormat:@"请选择交付时间"];
    
    self.title =@"案件委托";
    [self makeConsultGetData];
   // [self makeBackItem];
    [self makeUI];
    [self makeTExtView];
    [self showLBAndBuuton];
    // Do any additional setup after loading the view.
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
            payStr = [NSString stringWithFormat:@"%@",data[@"data"][@"config"]];
            labesl.text = [NSString stringWithFormat:@"服务费%@元，购买套餐可以免费服务",data[@"data"][@"config"]];
            [Utile setUILabel:labesl data:[NSString stringWithFormat:@"服务费%@元，",data[@"data"][@"config"]] setData:@"购买套餐" color:MAINCOLOR font:14 underLine:NO];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
      //  [self makeTypeAction];
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"案件类型以及服务费%@",error);
    }];
    
}

-(void)makeUI{
    DataArray = [[NSArray alloc]initWithObjects:@"案件领域",@"当事人信息",@"服务报价",@"交付时间",nil];
    _TV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 176) style:UITableViewStylePlain];
    
//    _TV.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    _TV.delegate= self;
    _TV.dataSource = self;
    _TV.tableFooterView  =[[UIView alloc]init];
    _TV.scrollEnabled = NO;
    [self.view addSubview:_TV];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textVeiw resignFirstResponder];

}
-(void)textViewDidEndEditing:(UITextView *)textView{
  
 
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}
-(void)makeTExtView{

    _textVeiw  =[[LPlaceholderTextView alloc]initWithFrame:CGRectMake(0, 176+10, ConentViewWidth, 150)];
    _textVeiw.backgroundColor = [UIColor whiteColor];
    _textVeiw.placeholderText =@"请输入委托律师的需求及案件详情...";
    _textVeiw.textColor =[UIColor colorWithHex:0x333333];
    _textVeiw.delegate = self;
    self.view.backgroundColor = MainBackColor;
    [self.view addSubview:_textVeiw];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QJDelegateCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJDelegateCell" owner:self options:nil]lastObject];
    }
    cell.TypeLB.text= [NSString stringWithFormat:@"%@",DataArray[indexPath.row]];
    
    

    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.DetaileLB.text=  [NSString stringWithFormat:@"%@",typeStr];
    }else if(indexPath.row == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.DetaileLB.text=  [NSString stringWithFormat:@"%@",fieldTitle];
        
    }else if(indexPath.row ==2){
        cell.DetaileLB.hidden = YES;
        UITextField *fieldS = [[UITextField alloc]initWithFrame:CGRectMake(ConentViewWidth - 200, 0, 180, 50)];
        fieldS.tag = indexPath.row;
        fieldS.textAlignment = NSTextAlignmentRight;
        fieldS.delegate = self;
             fieldS.keyboardType = UIKeyboardTypeNumberPad;
            fieldS.placeholder = @"请输入您的报价";
            fieldS.text = fieldMoney;
         [cell.contentView addSubview:fieldS];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.DetaileLB.text=  [NSString stringWithFormat:@"%@",timeStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  

    QJSelectItemView  *seleView =[[QJSelectItemView alloc]initWithFrame:self.view.bounds];
    
    if(indexPath.row  == 0){
        seleView.ViewTitlt= @"案件领域";

        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:listArr] ;
        seleView.selectWithIndexBlcik = ^(int index) {
            typeStr = [NSString stringWithFormat:@"%@",seleView.ViewDatArray[index]];
            //NSLog(@"选中了 数据    %@",seleView.ViewDatArray[index]);
            type = [NSString stringWithFormat:@"%@",DataArray1[index][@"cat_id"]];
            [_TV reloadData];
        };
        [self.view addSubview:seleView];
        [seleView showView];
        [seleView whenTapped:^{
        [seleView dismissView];
        }];

    }else if (indexPath.row  ==1){
        
        seleView.ViewTitlt= @"当事人信息";
        NSArray * tielArray =@[@"个人",@"公司"];
        seleView.ViewDatArray = [[NSMutableArray alloc]initWithArray:tielArray] ;
        seleView.selectWithIndexBlcik = ^(int index) {
            fieldTitle = [NSString stringWithFormat:@"%@",seleView.ViewDatArray[index]];
            fieldTitleType = [NSString stringWithFormat:@"%d", index + 1];
            //NSLog(@"选中了 数据    %@",seleView.ViewDatArray[index]);
             [_TV reloadData];
        };
        [self.view addSubview:seleView];
        [seleView showView];
        [seleView whenTapped:^{
            [seleView dismissView];
        }];

        
     }
    else if (indexPath.row  ==3){
        [self  didTimeButton];
      }
}
#pragma mark textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        fieldTitle  = textField.text;
    }else{
        fieldMoney = textField.text;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 购买套餐
- (void)didGouMaiTaocan{
    QJVipVc * sevc =[[QJVipVc alloc]init];
    sevc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:sevc animated:YES];
    
}
-(void)showLBAndBuuton{
    UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textVeiw.frame)+ 30, 20,20)];
    images.image = [UIImage imageNamed:@"xz"];
    [self.view addSubview:images];
    
    labesl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(images.frame)+ 5, CGRectGetMaxY(_textVeiw.frame)+ 30, ConentViewWidth - 50, 20)];
    labesl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labesl];
    [Utile addClickEvent:self action:@selector(didGouMaiTaocan) owner:labesl];

    
    
    

    UILabel * showLabe =[[UILabel alloc]initWithFrame:CGRectMake(0, ConentViewHeight - 110, ConentViewWidth, 20)];

    showLabe.textColor =[UIColor colorWithRed:33/255.0 green:101/255.0 blue:176/255.0 alpha:0.8];
     showLabe.font =[UIFont systemFontOfSize:14];
    showLabe.text =@"我们的工作人员会在24小时之内联系您";
    showLabe.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabe];


    UIButton * deleButton =[UIButton  buttonWithType:UIButtonTypeCustom];
    deleButton.frame = CGRectMake(30, ConentViewHeight - 80, ConentViewWidth -60, 40);
    
    [deleButton setTitle:@"寻求律师报价" forState:UIControlStateNormal];
    [deleButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    deleButton.layer.cornerRadius = 10;
    deleButton.layer.masksToBounds = YES;
    deleButton.layer.borderWidth = 1;
    deleButton.layer.borderColor =MAINCOLOR.CGColor;
    
    [deleButton addTarget:self action:@selector(deleAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:deleButton];

}
#pragma mark 案件委托
-(void)deleAction:(UIButton*)sender{
    if ([Utile stringIsNil:type]) {
        [self showHint:@"案件领域不能为空！"];
        return;
    }
    if ([Utile stringIsNil:fieldTitle]) {
        [self showHint:@"请选择当事人信息！"];
        return;
    }
     if ([Utile stringIsNil:fieldMoney]) {
        [self showHint:@"报价不能为空"];
        return;
    }
    
     if ([timeStr isEqualToString:@"请选择交付时间"]) {
        [self showHint:@"请选择交付时间！"];
        return;
    }

    
    if ([Utile stringIsNil:_textVeiw.text]) {
        [self showHint:@"内容不能为空"];
        return;
    }
    
    NSLog(@"show 提交 申请");
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    ConsultdoCase
    NSDictionary * valudic  = @{@"user_id":UserId,@"party_information":fieldTitleType,@"content":_textVeiw.text,@"offer":fieldMoney,@"type":type,@"time":timeStr};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"案件委托%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            typeStr = [NSString stringWithFormat:@"请选择案件领域"];
            fieldTitle = [NSString stringWithFormat:@"请选择当事人信息"];
             _textVeiw.text= @"";
            fieldMoney = @"";
            type =@"";
            timeStr = [NSString stringWithFormat:@"请选择交付时间"];

            
            [_TV reloadData];
            
            QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.title = @"法律服务支付";
            pavVc.payType = @"2";
            pavVc.payID = data[@"data"];
            pavVc.payName= [NSString stringWithFormat:@"%@服务费",self.title];
            pavVc.payPrice= payStr;
            pavVc.BuyConcent = @"2";
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
        NSLog(@"案件委托%@",error);
    }];

    

}



#pragma mark  选择时间
//- (void)diChoseTime{
//    [self didTimeButton];
//
//}
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
//    middleshowview.TimeLb.text = [NSString stringWithFormat:@"%@", timeStr];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
