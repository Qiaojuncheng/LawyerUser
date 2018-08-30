//
//  QJPhoneServiceViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/17.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJPhoneServiceViewController.h"

@interface QJPhoneServiceViewController ()

@end

@implementation QJPhoneServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeUI{
    
    //[self makeBackItem];
    //self.title = @"电话咨询服务费";
    self.view.backgroundColor  =  [UIColor colorWithRed:241/255.0 green:242/255.0 blue:244/255.0 alpha:1];

    _ensureBtn.layer.masksToBounds = YES;
    _ensureBtn.layer.cornerRadius = 20;
    self.Zhifubao.selected  =  self;

    _ensureBtn.layer.borderWidth =1;
   
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });

    
    _ensureBtn.layer.borderColor =borderColorRef;







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

- (IBAction)EnsureAction:(UIButton *)sender {
  
    NSLog(@"支付");
    
}

- (IBAction)StyleAction:(UIButton *)sender {
    
    self.WeiXinBtn.selected =NO;
    self.Zhifubao.selected  =  NO;
    
    sender.selected = YES;
    
    if (sender.tag == 21) {
        NSLog(@"支付宝支付");
    }else{
        
        NSLog(@"微信支付");
    }
    
}
@end
