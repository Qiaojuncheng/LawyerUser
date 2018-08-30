//
//  QJNeedRpelyViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNeedRpelyViewController.h"
#import "QJNeedsWenShuVC.h"
#import "QJDeleGateVC.h"
#import "QJHTVC.h"
#import "QJLawyerVC.h"

@interface QJNeedRpelyViewController ()<UIScrollViewDelegate>{
    UIScrollView *segmentScrollView;//视图上部选项卡按钮
    NSArray      *segmentArray;
    UIView       *yellowView;//黄色小滑块儿
    UIButton     *signButton;//标记当前选中的按钮
    UIScrollView *bottomScrollView;
    NSArray      *controlArray;
}

@end

@implementation QJNeedRpelyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self makeBackItem];
    
    self.title = @"我的需求";
    controlArray = @[@"QJNeedsWenShuVC",@"QJDeleGateVC",@"QJHTVC",@"QJLawyerVC"];
    [self creatView];
    // Do any additional setup after loading the view from its nib.
}
-(void)creatView{
    segmentArray = @[@"代写文书",@"案件委托",@"合同审查",@"发律师函"];
    segmentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    segmentScrollView.scrollEnabled  = NO;
    segmentScrollView.showsHorizontalScrollIndicator = NO;
    segmentScrollView.contentSize = CGSizeMake((ConentViewWidth/.0)*segmentArray.count, 46);
    [self.view addSubview:segmentScrollView];
    
    for (int i =0; i <segmentArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(ConentViewWidth/4.0), 0, ConentViewWidth/4.0, segmentScrollView.height - 2);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:segmentArray[i] forState:UIControlStateNormal];
        [button setTitleColor:SetColor(0x333333) forState:UIControlStateNormal];
//        [button setTitleColor:MainYellowColor forState:UIControlStateSelected];
        button.tag = 10+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [segmentScrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            signButton = button;
        }
    }
    
    yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentScrollView.frame)-2, ConentViewWidth/4.0, 1.5)];
    yellowView.backgroundColor = MAINCOLOR;
    [segmentScrollView addSubview:yellowView];
    
    bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, ConentViewWidth, ConentViewHeight-42)];
    bottomScrollView.delegate = self;
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.contentSize = CGSizeMake(segmentArray.count*ConentViewWidth, 0);
    [self.view addSubview:bottomScrollView];
    
    for (int i = 0; i <controlArray.count; i ++) {
        UIViewController *view = [[NSClassFromString(controlArray[i]) alloc]init];
        view.view.frame = CGRectMake(i *ConentViewWidth, 0, ConentViewWidth, ConentViewHeight-  segmentScrollView.height);
        [bottomScrollView addSubview:view.view];
        [self addChildViewController:view];
    }
    
//    if (self.myOrderType == 0) {
//        bottomScrollView.contentOffset = CGPointMake(0, 0);
//    }else if (self.myOrderType == 1){
//        bottomScrollView.contentOffset = CGPointMake(ConentViewWidth, 0);
//    }else if (self.myOrderType == 2){
//        bottomScrollView.contentOffset = CGPointMake(2*ConentViewWidth, 0);
//    }else if (self.myOrderType == 3){
//        bottomScrollView.contentOffset = CGPointMake(3*ConentViewWidth, 0);
//    }else if (self.myOrderType == 4){
//        bottomScrollView.contentOffset = CGPointMake(4*ConentViewWidth, 0);
//    }else{
//        bottomScrollView.contentOffset = CGPointMake(5*ConentViewWidth, 0);
//    }
}

-(void)segmentButtonClick:(UIButton *)button{
    signButton.selected = NO;
    button.selected = YES;
    signButton = button;
    
    [UIView animateWithDuration:0.3 animations:^{
//        if (button.tag > 12) {
//            segmentScrollView.contentOffset = CGPointMake(ConentViewWidth/4.0, 0);
//        }else
//        {
//            segmentScrollView.contentOffset = CGPointMake(0, 0);
//        }
        bottomScrollView.contentOffset = CGPointMake((button.tag-10)*ConentViewWidth, 0);
        yellowView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(segmentScrollView.frame)-2, ConentViewWidth/4.0, 2);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != bottomScrollView) {
        return;
    }
    NSInteger index = scrollView.contentOffset.x/ConentViewWidth;
    UIButton *button = (UIButton *)[self.view viewWithTag:10+index];
    signButton.selected = NO;
    button.selected = YES;
    signButton = button;
//    if (10+index > 12) {
//        [UIView animateWithDuration:0.3 animations:^{
//            segmentScrollView.contentOffset = CGPointMake(ConentViewWidth/4.0, 0);
//            
//        }];
//    }else{
        [UIView animateWithDuration:0.3 animations:^{
            segmentScrollView.contentOffset = CGPointMake(0, 0);
            
        }];
//    }
    [UIView animateWithDuration:0.3 animations:^{
        yellowView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(segmentScrollView.frame)-2, ConentViewWidth/4.0, 2);
    }];
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
