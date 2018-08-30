//
//  QJSettingViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJSettingViewController.h"
#import "QJOpinionViewController.h"

#import "QJAboutAppViewController.h"
#import "QJFAQViewController.h"
#import "QJLoginViewController.h"
#import "AppDelegate.h"
#import "SDImageCache.h"
#import "QJNewMessageTX.h"
#import "QJPersonInforViewController.h"

#import "JPUSHService.h"

@interface QJSettingViewController (){

    NSString  *  PhoneStr;

}

@end

@implementation QJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self makeBackItem];

    self.title = @"设置";
  PhoneStr  =  [[NSUserDefaults standardUserDefaults] objectForKey:@"KeFuPhone"];

//    dataArray = [[NSArray alloc]initWithObjects:@"常见问题",@"清除缓存",@"客服热线",@"意见反馈",@"关于软件", nil];
    dataArray = [[NSArray alloc]initWithObjects:@"个人资料",@"常见问题",@"新消息提醒",@"清除缓存",@"客服热线",@"意见反馈", nil];
    [self makeTV];
    [self makeLogionBtn];
    // Do any additional setup after loading the view.
}

-(void)makeLogionBtn{
    UIButton * loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(50, ConentViewHeight - 200, ConentViewWidth - 100, 40);
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius= 4;
    
    [loginBtn setBackgroundColor:MAINCOLOR];
//    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];


}

-(void)LoginAction:(UIButton *)sender{
//    if (sender.selected) {
 //    }else{
    
    
    NSUserDefaults * userdefa =[NSUserDefaults standardUserDefaults];
    [userdefa removeObjectForKey:@"id"];
    [userdefa removeObjectForKey:@"phone"];
    [userdefa removeObjectForKey:@"avatar"];
     [userdefa synchronize];

    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:[UserId integerValue]];

    AppDelegate * appdelegatee =(AppDelegate *)[UIApplication sharedApplication].delegate;
    QJLoginViewController *view = [QJLoginViewController new];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:view];
    appdelegatee.window.rootViewController = nav;

    
//        QJLoginViewController * Qvc =[[QJLoginViewController alloc]initWithNibName:@"QJLoginViewController" bundle:[NSBundle mainBundle]];
//        Qvc.hidesBottomBarWhenPushed  = YES;
//        [self.navigationController pushViewController:Qvc  animated:YES];
    
//    }
//    sender.selected = !sender.selected;


}
-(void)makeTV{

    TV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    TV.delegate= self;
    TV.dataSource  = self;
    TV.tableFooterView =[[UITableView alloc]init];
    [self.view addSubview:TV];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell== nil) {
        cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dataArray[indexPath.row]];
   
    
    if (indexPath.row == 3) {
        
        UILabel * lb =[[UILabel alloc]initWithFrame:CGRectMake(100, 0, ConentViewWidth - 140,44)];
        lb.tag= 22;
        lb.text = [NSString stringWithFormat:@"%.1fM",[self folderSize]];
        lb.font = [UIFont systemFontOfSize:15];
        lb.textColor  = TintColor;
        lb.textAlignment = NSTextAlignmentRight;
        [cell addSubview:lb];
    }else if (indexPath.row == 4 ) {

        UILabel * lb =[[UILabel alloc]initWithFrame:CGRectMake(100, 0, ConentViewWidth - 140,44)];
        lb.text = PhoneStr;
        lb.tag= 21;
        lb.font = [UIFont systemFontOfSize:15];
        lb.textColor  = TintColor;
        lb.textAlignment = NSTextAlignmentRight;
        [cell addSubview:lb];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.row  == 0){
        QJPersonInforViewController * cvc =[[QJPersonInforViewController alloc]init];
        
        cvc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:cvc animated:YES];

        
    
    }
    else if  (indexPath.row  == 1) {
        //  常见问题
                QJFAQViewController * qj =[[QJFAQViewController alloc]init];
                qj.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:qj animated:YES];

        
    } else if  (indexPath.row  == 2) {
         QJNewMessageTX * qj =[[QJNewMessageTX alloc]init];
        qj.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qj animated:YES];
     }else if  (indexPath.row  == 3) { // 清除缓存
         
         NSString *url = [NSString stringWithFormat:@"确定要清除缓存?"];
         
         UIAlertController * al =[UIAlertController  alertControllerWithTitle:@"温馨提示" message:url preferredStyle:UIAlertControllerStyleAlert];
         
         
         [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             
         }]];
         
         [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
             
             [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
             UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
              UILabel * bbb =[cell viewWithTag:22];
             bbb.text = [NSString stringWithFormat:@"%.1fM",[self folderSize]];
             
             [self showHint:@"清除缓存成功"];

             
             
             
         }]];
         
         
         [self presentViewController:al animated:YES completion:nil];

    }
    else if  (indexPath.row  == 4) {
        [self showPhone];

    }
    else if (indexPath.row == 5){//意见反馈
        
        
        QJOpinionViewController * qvc =[[QJOpinionViewController alloc]initWithNibName:@"QJOpinionViewController" bundle:[NSBundle mainBundle]];
        qvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qvc animated:YES];
        

//    
//        QJAboutAppViewController * qvc =[[QJAboutAppViewController alloc]initWithNibName:@"QJAboutAppViewController" bundle:[NSBundle mainBundle]];
//        qvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:qvc animated:YES];
    
    }



}




-(void)showPhone{
       NSString *url = [NSString stringWithFormat:@"联系客服 %@\n周一至周五 9：00-17：00\n是否拨打客服？",PhoneStr];
    
    UIAlertController * al =[UIAlertController  alertControllerWithTitle:@"温馨提示" message:url preferredStyle:UIAlertControllerStyleAlert];

    
    [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",PhoneStr];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        });
        

        
        
    }]];
    
   
    [self presentViewController:al animated:YES completion:nil];
 
}


-(float)folderSize{
 
    long long folderSize=0;
     folderSize+=[[SDImageCache sharedImageCache] getSize];
    return folderSize/1024.0/1024.0;
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
