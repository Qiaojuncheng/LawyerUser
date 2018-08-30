//
//  MineViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "MineViewController.h"
#import "QJMineTopView.h"
#import "QJSettingViewController.h"
 #import "QJMyMessageViewController.h"
#import "QJTiXianViewController.h"
#import "QJHistoryViewController.h"
#import "QJMyConsultViewController.h"
#import "QJInviteViewController.h"
#import "QJAppointmentViewController.h"
#import "QJNeedRpelyViewController.h"
#import "QJPersonInforViewController.h"
#import "QJMySetMealVC.h"
#import "QJPersonModel.h"
#import "QJMyGuanZhuViewController.h"
#import "QJVipVc.h"
#import "QJPayViewController.h"
#import "QJApplePayViewController.h"
#import "QJAboutAppViewController.h"
@interface MineViewController (){
    QJMineTopView * topVIew;
    QJPersonModel * PersonModel;
    NSString *moneyStr;
    NSArray *imgArr;
    NSArray *imgTwoArr;
    
    NSUserDefaults * UserDefaults ;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UserDefaults =[NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeTopTishi) name:@"UPMINEUI" object:nil];
    self.navigationItem.title = @"个人中心";
    [self CreatTopView];
    [self creatTableView];
    imgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"wdhyk"],[UIImage imageNamed:@"l-f-fellow"],[UIImage imageNamed:@"l-history"],[UIImage imageNamed:@"l-about"],[UIImage imageNamed:@"l-setting"], nil];
   // imgTwoArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"l-service"],[UIImage imageNamed:@"l-consult"],[UIImage imageNamed:@"l-order"],[UIImage imageNamed:@"l-request"], nil];
    // Do any additional setup after loading the view.
}
-(void)makeTopTishi{
    [topVIew makeTishi];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self makePersonData];
    
    [topVIew makeTishi];

}
-(void)makePersonData{

    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJeditUser
    NSDictionary * valueDic  = @{@"user_id":UserId};
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
     [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            PersonModel  =[QJPersonModel yy_modelWithJSON:data[@"data"]];
            moneyStr = PersonModel.money;
            [topVIew makeWithModel:PersonModel];
            
            TV.tableHeaderView = topVIew;

             UserDefaults =[NSUserDefaults standardUserDefaults];
            if ([NSString changeNullString:PersonModel.name].length ==0) {
                [UserDefaults setValue:PersonModel.username forKey:@"userName"];
            }else{
                [UserDefaults setValue:PersonModel.name forKey:@"userName"];

            }
            [UserDefaults synchronize];
            
         }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
         [TV reloadData];
     } failure:^(NSError *error) {
         NSLog(@"%@",error);
    }];

}
-(void)creatTableView{
    TV =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight -49) style:UITableViewStylePlain];
    TV.dataSource= self;
    TV.delegate= self;
    TV.tableFooterView =[[UIView alloc]init];
    TV.separatorColor = LINECOLOR;
//    DataArray = [[NSArray alloc]initWithObjects:@"我的会员卡",@"历史记录",@"我的消息",@"邀请好友",@"关于汇融法",@"设置", nil];
    DataArray = [[NSArray alloc]initWithObjects:@"我的会员卡",@"我的关注",@"历史记录",@"关于汇融法", @"设置", nil];

    [self.view addSubview:TV];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([PersonModel.isExpire isEqualToString:@"1"]) {
        return 40;
    }else{
        return  0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    
    UILabel * LB =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, headerView.height)];
    LB.text = @"您的会员即将到期,请尽快续费!";
    LB.textAlignment = NSTextAlignmentCenter;
    LB.backgroundColor = MAINCOLOR;
    LB.textColor = [UIColor whiteColor];
    [headerView addSubview:LB];
    return headerView;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (  indexPath.row ==0) {
        NSLog(@"第一行");
        
        QJVipVc * sevc =[[QJVipVc alloc]init];
        sevc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:sevc animated:YES];

    } else if (indexPath.row ==1){ 
        QJMyGuanZhuViewController * gvc =[[QJMyGuanZhuViewController alloc]init];
        gvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gvc animated:YES];
//
//        我的消息
//        QJMyMessageViewController * qvc =[[QJMyMessageViewController alloc]init];
//        qvc.hidesBottomBarWhenPushed  = YES;
//        [self.navigationController pushViewController:qvc animated:YES];
    }else if (indexPath.row ==2){
        QJHistoryViewController * hvc =[[QJHistoryViewController alloc]init];
        hvc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:hvc animated:YES];
    
    }else if (indexPath.row ==20){
        QJInviteViewController* qvc =[[QJInviteViewController alloc]init];
        qvc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:qvc animated:YES];
    }else if (indexPath.row ==3){
        QJAboutAppViewController* qvc =[[QJAboutAppViewController alloc]initWithNibName:@"QJAboutAppViewController" bundle:[NSBundle mainBundle]];
        qvc.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:qvc animated:YES];
    }
    else if ( indexPath.row ==4){
        QJSettingViewController * svc =[[QJSettingViewController alloc]init];
         svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins  = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =DataArray[(indexPath.section*2 +indexPath.row)];
    
    cell.imageView.image =imgArr[(indexPath.section*2 +indexPath.row)];
//    [NSString stringWithFormat:@"%ld组%ld行",(long)indexPath.section,(long)indexPath.row];
    return cell;

}



-(void)CreatTopView{
      topVIew =[[[NSBundle mainBundle]loadNibNamed:@"QJMineTopView" owner:self options:nil]lastObject];
    __weak __typeof(self)weakSelf = self;
    topVIew.frame = CGRectMake(0, 0,ConentViewWidth, 235);
    [topVIew makeUI];
//    [self.view addSubview:topVIew];
    
    topVIew.TapTopBlock = ^{
        
//        QJPersonInforViewController * cvc =[[QJPersonInforViewController alloc]init];
//        
//        cvc.hidesBottomBarWhenPushed = YES;
//        
//        [weakSelf.navigationController pushViewController:cvc animated:YES];
      };
 
     topVIew.Block =^(UIButton *btntag){
        
        if (btntag.tag == 10) {// 充值
//            QJApplePayViewController  * pavVc =[[QJApplePayViewController alloc]init];
             QJPayViewController * pavVc =[[QJPayViewController alloc]init];
            pavVc.payType = @"0";
            pavVc.payName= @"请输入支付金额";
            pavVc.hidesBottomBarWhenPushed =YES;
            [weakSelf.navigationController pushViewController:pavVc animated:YES];
            //        进入支付界面；

//            QJRechargeViewController * rvc =[[QJRechargeViewController alloc]initWithNibName:@"QJRechargeViewController" bundle:[NSBundle mainBundle]];
//            rvc.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:rvc animated:YES];
        }
        
        else if(btntag.tag ==11){// 提现
            QJTiXianViewController * tvc =[[QJTiXianViewController alloc]initWithNibName:@"QJTiXianViewController" bundle:[NSBundle mainBundle]];
            tvc.moneyString = moneyStr;
            tvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:tvc animated:YES];
        }else if(btntag.tag ==12){//我的套餐
            
          

 
            QJMySetMealVC * tvc =[[QJMySetMealVC alloc]initWithNibName:@"QJMySetMealVC" bundle:[NSBundle mainBundle]];
            tvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:tvc animated:YES];
        }

        else if (btntag.tag == 13){//咨询
            QJMyConsultViewController * cvc =[[QJMyConsultViewController alloc]init];
             cvc.hidesBottomBarWhenPushed = YES;
        
            [weakSelf.navigationController pushViewController:cvc animated:YES];
                            NSLog(@"我的咨询");
        }else if (btntag.tag ==14){
        
            QJAppointmentViewController * cvc =[[QJAppointmentViewController alloc]init];
            cvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:cvc animated:YES];

            NSLog( @"我的预约");
        }else if (btntag.tag ==15){
            
            QJNeedRpelyViewController * cvc =[[QJNeedRpelyViewController alloc]init];
            cvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:cvc animated:YES];
            [UserDefaults  setValue:@"no" forKey:@"MyNeeds"];
            [UserDefaults synchronize];
            NSLog( @"我的需求");
        }
//        
//        switch (btntag.tag) {
//            case 10:
//                NSLog(@"充值");
//                break;
//            case 11:
//                NSLog(@"提现");
//                
//                break;
//            case 12:
//                NSLog(@"我的套餐");
//                break;

//            case 15:
//                NSLog(@"我的需求");
//                break;
//                
//            default:
//                break;
//        }
//
        
    };


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
