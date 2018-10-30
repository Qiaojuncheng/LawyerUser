//
//  WYzixunViewController.m
//  Lawyer
//
//  Created by yu on 2017/9/21.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYzixunViewController.h"
#import "DatePickerView.h"
#import "QJVipVc.h"
#import "QJPayViewController.h"
@interface WYzixunViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,DatePickerViewDelegate,UITextFieldDelegate>{
    UITableView *yuyueTable;
    NSArray *titRowArr;
    NSArray *titRowTwoArr;
    UITextView *beizhuText;
    DatePickerView * selectPick;
    NSString *timeStr;//时间
    NSString *nameStr;//姓名
    NSString *beizhuStr;//备注
    NSString *dizhiStr;//地址
    UIView *_backWindowView;
    UITextField *fieldOne;//姓名
    UITextField *fieldTwo;//地址
    UILabel *plaerLab;//输入框的占位符
//    NSString *payPrice;
}

@end

@implementation WYzixunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBackColor;
    
    titRowTwoArr = [NSArray arrayWithObjects:@"您的姓名",@"联系方式",@"期望预约时间",@"预约地址", nil];
    titRowArr = [NSArray arrayWithObjects:@"您的姓名",@"联系方式",@"期望预约时间", nil];
    dizhiStr = [NSString stringWithFormat:@"%@",_addressStr];
    beizhuStr = [NSString stringWithFormat:@""];
    
    nameStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]  ];
    [self addTableview];
//    [self makeConsultGetData];
    // Do any additional setup after loading the view.
}

//#pragma mark  案件类型以及服务费
//- (void)makeConsultGetData{
//    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
//    ConsultgetCategory
//    [self showHudInView:self.view hint:nil];
//    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
//        NSLog(@"案件类型以及服务费%@",data);
//        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
//        if ([str isEqualToString:@"0"]) {
//            payPrice = data[@"data"][@"config"];
//
//        }else{
//            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
//            [self showHint:msg];
//        }
//        [yuyueTable reloadData];
//        [self hideHud];
//    } failure:^(NSError *error) {
//        [self hideHud];
//        [self showHint:@"失败，请稍后重试！"];
//        NSLog(@"案件类型以及服务费%@",error);
//    }];
//
//}

- (void)addTableview{
    yuyueTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight+ 64)style:UITableViewStyleGrouped];
    yuyueTable.delegate = self;
    yuyueTable.dataSource = self;
    yuyueTable.scrollEnabled = NO;
    yuyueTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:yuyueTable];
}
#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.typeStr isEqualToString:@"1"]) {
        return 3;
    }else{
        return 4;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    headerView.backgroundColor = MainBackColor;

    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ConentViewWidth - 20, 30)];
    
    titLab.font = [UIFont systemFontOfSize:16];
    titLab.text = [NSString stringWithFormat:@"请填写您的真实信息，律师将尽快与您联系"];
    titLab.textColor = MAINCOLOR;
    [headerView addSubview:titLab];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 300)];
    footView.userInteractionEnabled = YES;
    
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 100)];
    View.backgroundColor = [UIColor whiteColor];
    [footView addSubview:View];
    
    
    UILabel *titla = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, ConentViewWidth - 20, 20)];
    titla.font = [UIFont systemFontOfSize:16];
    titla.text = [NSString stringWithFormat:@"预约备注"];
    [View addSubview:titla];
    
    if (!beizhuText) {
         beizhuText = [[UITextView alloc]initWithFrame:CGRectMake(15, 30, ConentViewWidth - 20, 60)];
        beizhuText.backgroundColor = [UIColor clearColor];
        beizhuText.delegate = self;
    }
   
  
    [View addSubview:beizhuText];
    
    if(!plaerLab){
        plaerLab = [[UILabel alloc]init];
        plaerLab.textColor = [UIColor grayColor];
        plaerLab.frame = CGRectMake(0, 0, 200, 20);
        plaerLab.font = [UIFont systemFontOfSize:14];
        plaerLab.text = [NSString stringWithFormat:@"请简单描述您要预约的问题"];

    }
   
    plaerLab.backgroundColor = [UIColor clearColor];
    [beizhuText addSubview:plaerLab];
    
    
    
    
    UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(beizhuText.frame)+ 40, 15, 15)];
//    images.image = [UIImage imageNamed:@"xz_Selcted"];
    [footView addSubview:images];
    
    UILabel *labels = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(images.frame)+ 5, CGRectGetMaxY(beizhuText.frame)+ 40, ConentViewWidth - 30, 15)];
//    labels.font = [UIFont systemFontOfSize:14];
//    labels.text = [NSString stringWithFormat:@"服务费%@元，购买套餐可以免费服务",payPrice];
//
//    [Utile setUILabel:labels data:[NSString stringWithFormat:@"服务费%@元，",payPrice] setData:@"购买套餐" color:MAINCOLOR font:14 underLine:NO];
    [footView addSubview:labels];
//
//    [Utile addClickEvent:self action:@selector(didGouMaiTaocan) owner:labels];
    
    
    UIButton *tijiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labels.frame) +40, ConentViewWidth - 60, 44)];
    [footView addSubview:tijiaoBtn];
    [tijiaoBtn addTarget:self action:@selector(didTIjiaoButton) forControlEvents:UIControlEventTouchUpInside];
    [tijiaoBtn setTitle:@"提交预约" forState:normal];
    tijiaoBtn.backgroundColor = [UIColor colorMakeWithRed:192 green:192 blue:192 alpha:1.0];
    [tijiaoBtn setTitleColor:MAINCOLOR forState:normal];
    tijiaoBtn.layer.masksToBounds = YES;
    tijiaoBtn.layer.cornerRadius = 14;
    tijiaoBtn.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
    tijiaoBtn.layer.borderColor =borderColorRef;
    
    return footView;
}

#pragma mark 购买套餐
- (void)didGouMaiTaocan{
    QJVipVc * sevc =[[QJVipVc alloc]init];
    sevc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:sevc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellTwo= @"cellTwo";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTwo];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([self.typeStr isEqualToString:@"1"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",titRowArr[indexPath.row]];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@",titRowTwoArr[indexPath.row]];
    }
    
    
    if (indexPath.row == 0) {
        fieldOne = [[UITextField alloc]initWithFrame:CGRectMake(ConentViewWidth - 200, 0, 190, 40)];
        fieldOne.delegate = self;
        fieldOne.placeholder = @"请输入预约人的姓名";
        fieldOne.textAlignment = NSTextAlignmentRight;
        if ([Utile stringIsNil:nameStr]) {
            
        }else{
            fieldOne.text = nameStr;
        }
        fieldOne.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:fieldOne];
    }else if (indexPath.row == 1){
        UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 120, 0, 110, 40)];
        phoneLab.textAlignment = NSTextAlignmentRight;
        phoneLab.font = [UIFont systemFontOfSize:16];
        phoneLab.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]];
        [cell.contentView addSubview:phoneLab];
    }else if (indexPath.row == 2){
        UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 170, 0, 160, 40)];
        phoneLab.textAlignment = NSTextAlignmentRight;
        phoneLab.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:phoneLab];
        if (timeStr.length == 0) {
            phoneLab.text = [NSString stringWithFormat:@"请输入预约时间"];
        }else{
            phoneLab.text = [NSString stringWithFormat:@"%@",timeStr];
        }
    }else{
        fieldTwo = [[UITextField alloc]initWithFrame:CGRectMake(ConentViewWidth - 250, 0, 240, 40)];
        fieldTwo.delegate = self;
        fieldTwo.placeholder = self.addressStr;
        fieldTwo.text = [NSString stringWithFormat:@"%@",dizhiStr];
        fieldTwo.textAlignment = NSTextAlignmentRight;
        fieldTwo.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:fieldTwo];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        [self didTimeButton];
    }else if (indexPath.row == 3){
        
    }
}
#pragma mark  提交按钮 电话和面谈预约
- (void)didTIjiaoButton{
    
    if (timeStr.length == 0) {
        [self showHint:@"请选择预约时间！"];
        return;
    }
    
    NSString *phonrString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]];
    if ([Utile stringIsNil:phonrString]) {
        [self showHint:@"请填写手机号码！"];
        return;
    }
    if ([Utile stringIsNil:nameStr]) {
        [self showHint:@"请填写姓名！"];
        return;
    }
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UserputYuyue
    NSDictionary * valudic  = @{@"uid":UserId,@"lid":self.lvshiId,@"type":self.typeStr,@"meet_time":timeStr,@"desc":beizhuStr,@"meet_address":dizhiStr,@"phone":phonrString,@"username":nameStr};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"电话和面谈预约%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            
            QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            if ([self.typeStr isEqualToString:@"1"]) {
                pavVc.title = @"电话咨询支付";
                pavVc.BuyConcent = @"6";

            }else{
                pavVc.title = @"预约面谈支付";
                pavVc.BuyConcent = @"7";

            }
            pavVc.payType = @"2";
            pavVc.payID = data[@"data"][@"id"];
             pavVc.payName= [NSString stringWithFormat:@"%@服务费",self.title];
            pavVc.payPrice= self.yuyuePrice;
            pavVc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:pavVc animated:YES];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"电话和面谈预约%@",error);
    }];

    
}
#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ( textField == fieldOne) {
        nameStr = textField.text;
    }else{
        dizhiStr = textField.text;
    }
}
#pragma mark textview delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    plaerLab.text = @"";
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@""]) {
        plaerLab.text = @"请简单描述您要预约的问题";
        textView.textColor =[UIColor grayColor];
    }else{
        plaerLab.text = @"";
        beizhuStr = textView.text;
    }
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
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_backWindowView removeFromSuperview];
        _backWindowView = nil;
        selectPick.frame = CGRectMake(0, ConentViewHeight, ConentViewWidth, 184);
    } completion:^(BOOL finished) {
        [selectPick removeFromSuperview];
        selectPick = nil;
    }];
    [yuyueTable reloadData];
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
