//
//  QJValuationView.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/30.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJValuationView.h"
#import "RatingBar.h"
@implementation QJValuationView{
    RatingBar * StatrView;
}

-(instancetype)init{

    self = [super initWithFrame:CGRectMake(0,NavStatusBarHeight, ConentViewWidth , ConentViewHeight)];
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
    if(self) {
        // 做事情
//        self.alpha = 0.7;
     }
    return self;
}
-(void)makeUI{
  [self whenTapped:^{
       [self removeFromSuperview];
   }];
    UIWindow * mainWindow =[UIApplication sharedApplication].keyWindow;
    [mainWindow addSubview:self];
    UIView * showView =[[UIView alloc]initWithFrame:CGRectMake(20,  (ConentViewHeight) /2  -80 ,ConentViewWidth - 40, 160)];
    [showView setCornerRadius:5];
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    
     StatrView   =[[RatingBar alloc]initWithFrame:CGRectMake(showView.width/2- 100 - (200 / 12) - 5 , 20, 200, 40)];
    
    [showView addSubview:StatrView];
    
    for (int i  = 0; i< 2; i++) {
        UIButton *bu =[UIButton buttonWithType:UIButtonTypeCustom];
        if (i ==  0) {
            bu.frame = CGRectMake(20, showView.height - 50, 60, 30);
            [bu setTitle:@"取消" forState:UIControlStateNormal];
        }else{
            bu.frame = CGRectMake(showView.width - 80, showView.height - 50, 60, 30);
            [bu setTitle:@"完成" forState:UIControlStateNormal];
         }
        [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bu setCornerRadius:3];
        [bu setBackgroundColor:MAINCOLOR];
        bu.tag = 30+i;
        [bu addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
         [showView addSubview:bu];
     }
}
-(void)BtnAction:(UIButton *) sender{
    if (sender.tag == 30) {// 取消
        
     }else{ // 确定
         NSString * numberStr =[NSString stringWithFormat:@"%ld", StatrView.starNumber ];
         self.NUmberSelectBlock(numberStr);
     }
    
    [self removeFromSuperview];

}

-(void)show{

    [self makeUI];


}


@end
