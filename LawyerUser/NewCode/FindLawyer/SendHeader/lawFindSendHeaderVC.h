//
//  lawFindSendHeaderVC.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/19.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"
#import "lawLawyerDetailModle.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawFindSendHeaderVC : BaseViewController



@property (weak, nonatomic) IBOutlet UIView *RedBackView;

@property (strong , nonatomic) lawLawyerDetailModle * model;
 
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topheight;
@property (weak, nonatomic) IBOutlet UIImageView *LwayerHeader;


@property (weak, nonatomic) IBOutlet UILabel *lawyerNameLB;

@property (weak, nonatomic) IBOutlet UILabel *FirstLB;
@property (weak, nonatomic) IBOutlet UILabel *SecondLB;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLB;
@property (weak, nonatomic) IBOutlet UILabel *LastLB;

@property (weak, nonatomic) IBOutlet UITextField *MoneyTextField;
- (IBAction)BottomAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
