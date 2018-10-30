//
//  QJOpinionViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJOpinionViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface QJOpinionViewController ()

@end

@implementation QJOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    //[self makeBackItem];

    self.view.backgroundColor = MainBackColor;
    [self makeView];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)makeView{
    
    [self.putInTextView setCornerRadius:6];
    [self.TijiaoBtn  setCornerRadius:3];

//    self.putInTextView.delegate= self;
//     self.putInTextView.layer.borderWidth =0.5;
//    self.putInTextView.layer.masksToBounds = YES;
//    self.putInTextView.layer.cornerRadius = 6;
//
//     self.TijiaoBtn.layer.borderWidth =0.5;
//    self.TijiaoBtn.layer.masksToBounds = YES;
//    self.TijiaoBtn.layer.cornerRadius = 3;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.putInTextView resignFirstResponder];
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

- (IBAction)TijiaoAction:(id)sender {
  
    NSLog(@"点我提交你的 建议啊");
    
    [self.putInTextView resignFirstResponder];
   
     NSDictionary * dic  =[[NSMutableDictionary alloc]init];
     QJAddvice
    
    NSDictionary * valudic  = @{@"content":self.putInTextView.text,@"uid":UserId};
     NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];

    [self showHudInView:self.view hint:nil];

    
    [HttpAfManager postWithUrlString:MainUrl parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self performAction];
          }else{
            
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
 
    
    
//
    
}
// 提交完成
-(void)performAction{

    UIAlertController * al =[UIAlertController  alertControllerWithTitle:@"提交成功" message:@"您的宝贵意见已经提交至后台，客服专员会对您的意见作出改进，谢谢！" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    
    [self presentViewController:al animated:YES completion:nil];








}


@end
