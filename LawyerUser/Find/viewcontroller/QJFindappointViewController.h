//
//  QJFindappointViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/17.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJFindappointViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *AppointMentNameField;

@property (weak, nonatomic) IBOutlet UITextField *AppointMentPhoneField;


@property (weak, nonatomic) IBOutlet UIView *FirstMiddleView;

@property (weak, nonatomic) IBOutlet UIView *SecondMiddleView;

@property (weak, nonatomic) IBOutlet UIView *ThirdMiddleVIew;

@property (weak, nonatomic) IBOutlet UIView *FourMiddleView;


@property (weak, nonatomic) IBOutlet UIImageView *FirstmiddleImg;
@property (weak, nonatomic) IBOutlet UILabel *FirstMiddleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *SecondImg;

@property (weak, nonatomic) IBOutlet UILabel *SecondMiddleLable;

@property (weak, nonatomic) IBOutlet UIImageView *ThirdMiddleImg;
@property (weak, nonatomic) IBOutlet UILabel *ThirdMiddleLable;

@property (weak, nonatomic) IBOutlet UIImageView *FourMiddleImg;

@property (weak, nonatomic) IBOutlet UILabel *FourMiddleLable;




@property (weak, nonatomic) IBOutlet UITextView *InputFieldsTextView;

@property (weak, nonatomic) IBOutlet UIButton *EnsureBtn;


@property (weak, nonatomic) IBOutlet UIView *FirstVeiw;

@property (weak, nonatomic) IBOutlet UIView *secondeView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;










@end
