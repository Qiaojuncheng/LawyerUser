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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewTopHeight;

@end

NS_ASSUME_NONNULL_END
