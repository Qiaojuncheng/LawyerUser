//
//  QJFindappointViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/17.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJFindappointViewController.h"
#import "UIViewAdditions.h"
#import "UIView+XPKit.h"
@interface QJFindappointViewController ()

@end

@implementation QJFindappointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self makeBackItem];
    [self makeUI];
    [self StartStatu]
    ;    self.title = @"预约面谈";
    // Do any additional setup after loading the view from its nib.
}

 -(void)makeUI{
    
     self.AppointMentNameField.delegate= self;
     self.AppointMentPhoneField.delegate= self;
     self.InputFieldsTextView.delegate= self;
     
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor  =  [UIColor colorWithRed:241/255.0 green:242/255.0 blue:244/255.0 alpha:1];
    _EnsureBtn.layer.masksToBounds = YES;
    _EnsureBtn.layer.cornerRadius = 20;
    _EnsureBtn.layer.borderWidth =1;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
    
    
     
    _EnsureBtn.layer.borderColor =borderColorRef;

   

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.AppointMentPhoneField) {
        
        NSLog(@" 是不是电话号码  啊 ");
    }


}

-(void)textViewDidEndEditing:(UITextView *)textView{

    if ([textView.text  isEqualToString:@""]) {
        textView.text =@"请简单描述您要咨询的问题...(100字以内)";
        textView.textColor =[UIColor grayColor];

    }

}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请简单描述您要咨询的问题...(100字以内)"]) {
        textView.text =@"";
        textView.textColor =[UIColor blackColor];
    }
}

-(void)viewDidLayoutSubviews{

    self.FirstmiddleImg.image=[UIImage imageNamed:@"time"];
    self.FirstMiddleLabel.textColor =MAINCOLOR;
    
    self.secondeView.frame = CGRectMake(self.secondeView.left, self.FirstVeiw.bottom+5, self.secondeView.width, self.secondeView.height);
    
    self.ThirdView.frame = CGRectMake(self.ThirdView.left, self.secondeView.bottom  + 5, self.ThirdView.width, self.ThirdView.height);
    
//    if (self.FirstmiddleImg.width > self.FirstmiddleImg.height) {
//        self.FirstmiddleImg.height= self.FirstmiddleImg.width;
//        self.SecondImg.height= self.FirstmiddleImg.width;
//        self.ThirdMiddleImg.height= self.FirstmiddleImg.width;
//        self.FourMiddleImg.height= self.FirstmiddleImg.width;
//        
//    }
//    else{
//        self.FirstmiddleImg.centerX =  self.FourMiddleImg.centerX + (self.FirstmiddleImg.width - self.FirstmiddleImg.height)/2;
//        self.SecondImg.centerX =  self.FourMiddleImg.centerX + (self.FirstmiddleImg.width - self.FirstmiddleImg.height)/2;
//        self.ThirdMiddleImg.centerX =  self.FourMiddleImg.centerX + (self.FirstmiddleImg.width - self.FirstmiddleImg.height)/2;
//        self.FourMiddleImg.centerX =  self.FourMiddleImg.centerX + (self.FirstmiddleImg.width - self.FirstmiddleImg.height)/2;
//
//        
//        self.FirstmiddleImg.width= self.FirstmiddleImg.height;
//        self.SecondImg.width= self.FirstmiddleImg.height;
//        self.ThirdMiddleImg.width= self.FirstmiddleImg.height;
//        self.FourMiddleImg.width= self.FirstmiddleImg.height;
//    
//    }
    
    // 点击Block
    [self.FirstMiddleView whenTapped:^{
        [self StartStatu];

        self.FirstmiddleImg.image=[UIImage imageNamed:@"时间"];
        self.FirstMiddleLabel.textColor =MAINCOLOR;
    }];
    
    
    [self.SecondMiddleView whenTapped:^{
        [self StartStatu];

        self.SecondImg.image=[UIImage imageNamed:@"time"];
        self.SecondMiddleLable.textColor =MAINCOLOR;

    }];
    
    [self.ThirdMiddleVIew whenTapped:^{
        [self StartStatu];
        self.ThirdMiddleImg.image=[UIImage imageNamed:@"time"];
        self.ThirdMiddleLable.textColor =MAINCOLOR;

    }];
    
    [self.FourMiddleView whenTapped:^{
        [self StartStatu];

        self.FourMiddleImg.image=[UIImage imageNamed:@"time"];
        self.FourMiddleLable.textColor =MAINCOLOR;

    }];

    
    
//    NSLog(@"height ===%f@",self.secondeView.height);


}

-(void)StartStatu{
    
    self.FirstmiddleImg.image=[UIImage imageNamed:@"timeh"];
    self.FirstMiddleLabel.textColor =[UIColor grayColor];
    
    self.SecondImg.image=[UIImage imageNamed:@"timeh"];
    self.SecondMiddleLable.textColor =[UIColor grayColor];
    
    self.ThirdMiddleImg.image=[UIImage imageNamed:@"timeh"];
    self.ThirdMiddleLable.textColor =[UIColor grayColor];
    
    self.FourMiddleImg.image=[UIImage imageNamed:@"timeh"];
    self.FourMiddleLable.textColor =[UIColor grayColor];
    
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

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
