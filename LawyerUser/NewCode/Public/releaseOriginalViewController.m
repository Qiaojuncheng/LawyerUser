//
//  releaseOriginalViewController.m
//  prawnShare
//
//  Created by MYMAc on 2018/7/24.
//  Copyright © 2018年 DongliWuxian. All rights reserved.
//

#import "releaseOriginalViewController.h"
#import "lawreleaseConsultVC.h"
@interface releaseOriginalViewController ()

@end

@implementation releaseOriginalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [Utile makeCorner:15 view:self.BackView];
    [self.BackView createRectShadowWithOffset:CGSizeMake(3, 4) opacity:.33 radius:12];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)addBackButton{
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
self.navigationController.navigationBar.hidden = YES;
    
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


- (IBAction)imageAction:(UIButton *)sender {
    lawreleaseConsultVC * release =[[lawreleaseConsultVC alloc]init];
    release.type = @"1";
    [self.navigationController pushViewController:release animated:YES ];
 }

- (IBAction)DTouchImage:(UIButton *)sender {
    lawreleaseConsultVC * release =[[lawreleaseConsultVC alloc]init];
    release.type = @"2";
    [self.navigationController pushViewController:release animated:YES ];
}

- (IBAction)DeleAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SELECTOTHER" object:nil];
}
@end
