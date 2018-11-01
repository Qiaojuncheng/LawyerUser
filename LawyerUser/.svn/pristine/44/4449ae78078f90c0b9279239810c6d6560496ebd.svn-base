//
//  QJSelectDatePickView.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJSelectDatePickView.h"

@implementation QJSelectDatePickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    CGRect frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 250, ConentViewWidth, 250);
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSubView];
        
        
    }
    return self;
}

-(void)makeSubView{
    
    _backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = [UIScreen mainScreen].bounds;
    [_backBtn addTarget:self action:@selector(Dismissself) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *  window =[UIApplication sharedApplication].keyWindow;
    [window addSubview:_backBtn];
    [window addSubview:self];
    
    
    self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    // 创建 确定和取消按钮
    for (int i = 0; i< 2; i++) {
        UIButton * bu =[ UIButton buttonWithType:UIButtonTypeCustom];
        if (i== 0) {
            bu.frame =CGRectMake(10, 10, 50 , 35);
            [bu setTitle:@"取消" forState:UIControlStateNormal];
        }else{
            bu.frame =CGRectMake(self.frame.size.width - 60, 10, 50, 35);
            [bu setTitle:@"确定" forState:UIControlStateNormal];
        }
        [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        bu.tag = 20+i;
        [self addSubview:bu];
    }
   //  创建pickView；
    self.datePicker = [[ UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 200)];

    self.datePicker.datePickerMode = UIDatePickerModeTime;
    
    [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];

    NSDate *currentTime=[NSDate date];
    [self.datePicker setMaximumDate:currentTime];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.datePicker];
    
}
-(void)showUI{
    _backBtn.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 250, [UIScreen mainScreen].bounds.size.width, 250);
        
    }];



}
-(void)Dismissself{
    _backBtn.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 250);
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
    }];



}
-(void)btnAction:(UIButton *)sender{
    if (sender.tag == 20) {
        
        self.CertainBlock(NO, nil);
    }else{
        //1 获取选中的时间
        NSDateFormatter *ndf1 = [NSDateFormatter new];
        //    ndf.dateFormat = @"HH:mm";
        ndf1.dateFormat = @"yyyy-MM-dd";
        NSString * dateString =[ndf1 stringFromDate:self.datePicker.date]; //第5个值  出生日期
        
        self.CertainBlock(YES, dateString);
    }
}


@end
