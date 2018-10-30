//
//  QJChangPersonInfoViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJChangPersonInfoViewController.h"

@interface QJChangPersonInfoViewController (){
    UITextField * textField ;
}

@end

@implementation QJChangPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self makeBackItem];

    [self makeUI];
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    
    
    UIButton * RightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    RightBtn.frame = CGRectMake(0, 0, 50, 35);
    [RightBtn setTintColor:[UIColor whiteColor]];
    [RightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [RightBtn addTarget: self action:@selector(Rightaction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * RightItem =[[UIBarButtonItem alloc]initWithCustomView:RightBtn];
    self.navigationItem.rightBarButtonItem = RightItem;
    
    
   textField =[[UITextField alloc]initWithFrame:CGRectMake(10, 20, ConentViewWidth- 20, 40)];

    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 4;
    self.view.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textField];

    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [textField resignFirstResponder];
}
-(void)Rightaction{

    
    
    
    [textField resignFirstResponder];
    self.changBlock(textField.text);
    
//    NSLog(@"保存");
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
