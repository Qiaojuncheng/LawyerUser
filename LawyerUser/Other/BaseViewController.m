//
//  BaseViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
     // Do any additional setup after loading the view.
}

-(void)makeBackItem{

    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(0, 0, 40, 40);
    [backBtn setImage:[ UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * BackItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = BackItem;


}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)loadView{
//
//    UIScrollView * scroller =[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    scroller.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight);
//    scroller.scrollEnabled = NO;
//         self.view =scroller;
// 
//    
//}

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
