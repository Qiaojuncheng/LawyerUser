//
//  lawPublicViewController.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/10.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPublicViewController.h"
#import "releaseOriginalViewController.h"
@interface lawPublicViewController ()

@end

@implementation lawPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    releaseOriginalViewController * orgin = [[releaseOriginalViewController alloc]init];
    orgin.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orgin animated:NO];
    
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
