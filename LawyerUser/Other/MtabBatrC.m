//
//  MtabBatrC.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "MtabBatrC.h"
#import "MainViewController.h"
#import "FindingViewController.h"
#import "InformationViewController.h"
#import "MineViewController.h"
#import "WYViewController.h"
@interface MtabBatrC ()

@end

@implementation MtabBatrC

+(void)initialize{
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.barTintColor = [UIColor whiteColor];
    
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MAINCOLOR} forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    MainViewController * Mvc =[[MainViewController alloc]init];
//    Mvc.title = @"汇融法";
    WYViewController * Mna =[[WYViewController alloc]initWithRootViewController:Mvc];
    Mvc.title =@"汇融法";
    UITabBarItem *mainTabbar =[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"首页"] selectedImage:[UIImage imageNamed:@"首页1"]];
    Mvc.tabBarItem = mainTabbar;
    

    
    
    FindingViewController * fvc =[[FindingViewController alloc]init];
//    fvc.title = @"发现";
    WYViewController *  Fna =[[WYViewController alloc]initWithRootViewController:fvc];
    UITabBarItem *FvcTabbar =[[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"发现" ] selectedImage:[UIImage imageNamed:@"发现1"]];
    fvc.tabBarItem = FvcTabbar;
    
    
    
    
    InformationViewController * Ivc =[[InformationViewController alloc]init];
    Ivc.title =@"法律资讯";
    WYViewController  *Ina =[[WYViewController alloc]initWithRootViewController:Ivc];
     UITabBarItem *IvcTabbar =[[UITabBarItem alloc]initWithTitle:@"资讯" image:[UIImage imageNamed:@"咨询1" ] selectedImage:[UIImage imageNamed:@"咨询1"]];
    Ivc.tabBarItem = IvcTabbar;

    
    
    
    
    
    MineViewController * miVc = [[MineViewController alloc]init];
    miVc.title = @"我的";
    WYViewController* mina =[[WYViewController alloc]initWithRootViewController:miVc];
    
     UITabBarItem *MivcTabbar =[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"我的" ] selectedImage:[UIImage imageNamed:@"我的1"]];
    miVc.tabBarItem =MivcTabbar;
    
    NSArray * viewArray =@[Mna,Fna,Ina,mina];
    self.viewControllers =viewArray;
    // Do any additional setup after loading the view.
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
