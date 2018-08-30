//
//  QJSelectDatePickView.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJSelectDatePickView : UIView

@property (nonatomic,strong) UIDatePicker *datePicker;

//   取消 确定  按钮事件 传参数


//  IsCertain   YES   确定按钮  并传日期  NO 取消不传日期

typedef void(^block)(BOOL IsCertain,NSString *dateString);


@property(nonatomic, strong) block CertainBlock;

@property (nonatomic, strong) UIButton * backBtn;



-(void)showUI;
-(void)Dismissself;
 

@end
