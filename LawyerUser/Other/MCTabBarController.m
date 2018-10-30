//
//  MCTabBarController.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/4.
//  Copyright © 2017年 Mr.C. All rights reserved.
//

#import "MCTabBarController.h"
#import "LawMainPageViewController.h"
#import "lawFindLawyerViewController.h"
#import "lawPublicViewController.h"
#import "LawCaseAppreciateViewController.h"
#import "lawMineVC.h"
#import "WYViewController.h"
#import "MCTabBar.h"
@interface MCTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) MCTabBar *mcTabbar;
@property (nonatomic, assign) NSUInteger selectItem;//选中的item
@property (nonatomic, assign) NSUInteger laseSelectItem;//上次选中的item

@end

@implementation MCTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JunmIndex) name:@"SELECTOTHER" object:nil];
    
    
    
    _mcTabbar = [[MCTabBar alloc] init];
     [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _mcTabbar.tintColor = MAINCOLOR;
   //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    
    self.selectItem = 0; //默认选中第一个
    self.laseSelectItem = self.selectItem;
    self.delegate = self;
    [self addChildViewControllers];
}
-(void)JunmIndex{
    self.selectItem = self.laseSelectItem;
    self.selectedIndex = self.laseSelectItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议26*26
    [self addChildrenViewController:[[LawMainPageViewController alloc] init] andTitle:@"首页" andImageName:@"bar_01" andSelectImage:@"bar_01_select"];
    [self addChildrenViewController:[[lawFindLawyerViewController alloc] init] andTitle:@"找律师" andImageName:@"bar_02" andSelectImage:@"bar_02_select"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[lawPublicViewController alloc] init] andTitle:@"发布咨询" andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[LawCaseAppreciateViewController alloc] init] andTitle:@"案例" andImageName:@"bar_03" andSelectImage:@"bar_03_select"];
    [self addChildrenViewController:[[lawMineVC alloc] init] andTitle:@"我的" andImageName:@"bar_04" andSelectImage:@"bar_04_select"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    WYViewController *baseNav = [[WYViewController alloc] initWithRootViewController:childVC];
    [baseNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x3181FE]} forState:UIControlStateSelected];

    [self addChildViewController:baseNav];
    [baseNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
}

- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
    if (self.selectItem != 2){
//        [self rotationAnimation];
    }
    self.selectItem = 2;
}

//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.selectItem = tabBarController.selectedIndex;
    if (self.selectItem != 2) {
        self.laseSelectItem = self.selectItem;
    }
    if (tabBarController.selectedIndex == 2){//选中中间的按钮
        if (self.selectItem != 2){

//             [self rotationAnimation];
        }
    }else {
        [_mcTabbar.centerBtn.layer removeAllAnimations];
    }
    
}
//旋转动画
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [_mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}
@end
