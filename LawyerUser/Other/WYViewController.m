//
//  WYViewController.m
//  Lawyer
//
//  Created by yu on 2017/9/30.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYViewController.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = MAINCOLOR;
    bar.translucent = NO;
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    //设置导航栏标题的字体颜色和大小
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    NSString *version = [UIDevice currentDevice].systemVersion;

    if (version.doubleValue < 11) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    }else{
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0)forBarMetrics:UIBarMetricsDefault];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)popViewController:(NSInteger)index{
    if (index <= 0) {
        return;
    }
    NSMutableArray *allVCArray = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    NSMutableArray *newVCArray = [[NSMutableArray alloc] init];
    if (allVCArray.count > index) {
        for (int i =0; i<=allVCArray.count - index; i++) {
            [newVCArray addObject:[allVCArray objectAtIndex:i]];
        }
    }
    [self setViewControllers:newVCArray];
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
