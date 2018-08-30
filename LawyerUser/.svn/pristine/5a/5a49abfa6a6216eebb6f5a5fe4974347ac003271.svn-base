//
//  QJViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/10/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJViewController.h"
#import "QJLawyerTItleCell.h"
#import "QJValuationView.h"

@interface QJViewController (){
    NSDictionary * detailInfodic ;
    QJLawyerTItleCell * topCell;
}

@end

@implementation QJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTopCellView];
    
    [self makelawxqData];
    self.title = @"预约详情";
    self.view.backgroundColor = MainBackColor;
     // Do any additional setup after loading the view from its nib.
}
#pragma mark 律师详情
- (void)makelawxqData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Userlawxq
    NSDictionary * valudic  = @{@"lid":_model.lawyer_id,@"uid":UserId};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    [self showHudInView:self.view hint:nil];
    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"律师详情%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            detailInfodic = [NSDictionary dictionaryWithDictionary:data[@"data"]];
            
            WYlawyerDetail *model = [WYlawyerDetail yy_modelWithDictionary:detailInfodic];
            topCell.model = model;
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        
         [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"登录失败，请稍后重试！"];
        NSLog(@"律师详情%@",error);
    }];
    
}


#pragma mark 添加关注
- (void)addGuanZhu{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UsercancelAttention
    NSDictionary * valudic  = @{@"lawyer_id":[detailInfodic objectForKey:@"id"],@"user_id":UserId};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"添加关注%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
                        [self makelawxqData];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"添加关注失败，请稍后重试！"];
        NSLog(@"添加关注%@",error);
    }];
    
}


-(void)makeTopCellView{

    topCell =[[[NSBundle mainBundle]loadNibNamed:@"QJLawyerTItleCell" owner:self options:nil]lastObject];
    topCell.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topCell];
    topCell.width = ConentViewWidth;
    [topCell.guanzhuBtn addTarget:self action:@selector(addGuanZhu) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat lableHeight = 20;
    UIView * BackView =[[UIView alloc]initWithFrame:CGRectMake(0, topCell.bottom +5,ConentViewWidth, 150)];
    BackView.backgroundColor =[UIColor whiteColor];
    
    UILabel * FangShiLB =[[UILabel alloc]initWithFrame:CGRectMake(12, 10, ConentViewWidth - 24, lableHeight)];
    FangShiLB.textColor =DEEPTintColor;
    FangShiLB.font = font15;
    //    FangShiLB.backgroundColor =[UIColor blueColor];
    [BackView addSubview:FangShiLB];
    
    UILabel * AddressLB =[[UILabel alloc]initWithFrame:CGRectMake(12, FangShiLB.bottom + 5, ConentViewWidth - 24, lableHeight)];
//    AddressLB.backgroundColor =[UIColor blueColor];
    AddressLB.textColor =DEEPTintColor;
    AddressLB.font = font15;

    [BackView addSubview:AddressLB];
  

    UILabel * TimeLB =[[UILabel alloc]initWithFrame:CGRectMake(12, AddressLB.bottom + 5, ConentViewWidth - 24, lableHeight)];
     TimeLB.text = [NSString stringWithFormat:@"时间:%@",_model.meet_time];
    
     TimeLB.textColor =DEEPTintColor;
     TimeLB.font = font15;

    if ([_model.type  isEqualToString:@"1"]) {
        FangShiLB.text =@"预约方式:电话";
        AddressLB.height = 0;
        TimeLB.top =FangShiLB.bottom + 5;
    }else{
        FangShiLB.text = @"预约方式:见面";
        AddressLB.text = [NSString stringWithFormat:@"地址:%@",_model.meet_address];
        
    }
    
    

    
//    TimeLB.backgroundColor =[UIColor blueColor];
    [BackView addSubview:TimeLB];

    UILabel * PhoneLB =[[UILabel alloc]initWithFrame:CGRectMake(12, TimeLB.bottom + 5, ConentViewWidth - 24, lableHeight)];
    PhoneLB.text = [NSString stringWithFormat:@"电话:%@",_model.phone];
    PhoneLB.textColor =DEEPTintColor;
    PhoneLB.font = font15;

//    PhoneLB.backgroundColor =[UIColor blueColor];
    [BackView addSubview:PhoneLB];

    
    
    
    UILabel * Stataus =[[UILabel alloc]initWithFrame:CGRectMake(12, PhoneLB.bottom + 5, ConentViewWidth - 24, lableHeight)];
//    Stataus.backgroundColor =[UIColor blueColor];
    [BackView addSubview:Stataus];
    Stataus.textColor =DEEPTintColor;
    Stataus.font = font15;

    UILabel * TiShiLB =[[UILabel alloc]initWithFrame:CGRectMake(12, Stataus.bottom + 5, ConentViewWidth - 24, lableHeight)];
//    TiShiLB.backgroundColor =[UIColor blueColor];
    [BackView addSubview:TiShiLB];
     TiShiLB.textColor =DEEPTintColor;

    BackView.height  = Stataus.bottom + 10;

//    状态 1： 待回复, 2：同意 3:拒绝  4 待评价   
    // 1：等待回答 2：已预约 3:拒绝 4 已完成去评价
    if ([_model.status isEqualToString:@"1"]) {
//        BackView.bottom  = Stataus.bottom + 10;
        Stataus.text = @"预约状态:等待回答";
    }else if ([_model.status isEqualToString:@"2"]){
        Stataus.text = @"预约状态：已预约";
    }else if ([_model.status isEqualToString:@"5"]){
        Stataus.text = @"预约状态：已完成";
    }else  if ([_model.status isEqualToString:@"3"]){
        Stataus.text = @"预约状态:拒绝";
         TiShiLB.text =@"退款状态:已退款";
        BackView.height  = TiShiLB.bottom + 10;

        TiShiLB.font = font15;
 
     }else if ([_model.status isEqualToString:@"4"]) {
        Stataus.text = @"预约状态:已完成";
        TiShiLB.top = BackView.bottom + 30;
         TiShiLB.height = 40;
         [TiShiLB createBordersWithColor:MAINCOLOR withCornerRadius:4 andWidth:.5];
         TiShiLB.backgroundColor = MAINCOLOR;
         [self.view addSubview:TiShiLB];
         TiShiLB.textAlignment = NSTextAlignmentCenter;
         TiShiLB.textColor = [UIColor whiteColor];
        TiShiLB.text =@"去评价！";
         
         __weak typeof(self) WeakSelf  = self;
         [TiShiLB whenTapped:^{
   
    NSLog(@"去评价");
    
    QJValuationView * valVC =[[QJValuationView alloc]init];
    [valVC show];
    valVC.NUmberSelectBlock = ^(NSString *numberStr) {
        [WeakSelf makePongjiaWithNumber:numberStr Withid:self.model.id];
    };

}];
     }
     [self.view addSubview:BackView];
}
-(void)makePongjiaWithNumber:(NSString *)Number Withid:(NSString *)rid{
    
    [self showHint:@""];
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    Useryy_pingjia
    NSDictionary * valueDic  = @{@"uid":UserId,@"id":rid,@"star":Number};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self showHint:@"评价成功！"];

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    
}

/*
 -(void)makeTopCellView{
 _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
 _tv.dataSource = self;
 _tv.delegate = self;
 [self.view addSubview:_tv];
 
 
 }
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 
 if (indexPath.row == 0 ) {
 
 QJLawyerTItleCell *  topCell =[[[NSBundle mainBundle]loadNibNamed:@"QJLawyerTItleCell" owner:self options:nil]lastObject];
 return topCell;
 }else{
 UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
 return cell;
 
 }
 
 }
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return 4;
 }

 */
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
