//
//  lawAppointmentVC.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/18.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface lawAppointmentVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *NameField;

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;

@property (weak, nonatomic) IBOutlet UILabel *TypeLb;
@property (weak, nonatomic) IBOutlet UILabel *TimeLb;

@property (weak, nonatomic) IBOutlet UIView *TimeTopView;

@property (assign, nonatomic) BOOL IsPhoneMeeting ;// yes 电话预约，no 见面预约
@property (strong, nonatomic) NSString * lid;// 律师id
@property (strong, nonatomic) NSString * price; // 面谈或预约的价格；
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewTopHeight;

- (IBAction)PushAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
