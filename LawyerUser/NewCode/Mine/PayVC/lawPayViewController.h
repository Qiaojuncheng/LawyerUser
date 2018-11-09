//
//  lawPayViewController.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface lawPayViewController : BaseViewController

// 这个是自定义的  里面的才是后台定义的 PayId
@property (strong, nonatomic) NSString * Type;// 支付类型 1  充值 ， 2 送心意 , 3 购买套餐， 4 悬赏咨询支付  5 预约面谈 支付 6 案件委托 7 发律师函 8 合同审查 9 合同起草
@property (strong, nonatomic)     NSString * PayId ;// 服务id


@property  (strong, nonatomic ) NSString * Pricestr;// 费用
@property  (strong, nonatomic ) NSString * VIPNameStr;// 套餐名字
@property (weak, nonatomic) IBOutlet UILabel *PayTypeName;
@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;
@property (weak, nonatomic) IBOutlet UIView *WXPayView;
@property (weak, nonatomic) IBOutlet UIView *AirPayView;
@property (weak, nonatomic) IBOutlet UIView *YePayView;
@property (weak, nonatomic) IBOutlet UIView *VIPPayView;

@property (weak, nonatomic) IBOutlet UIButton *WXpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *AirPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *YeLB;

@property (weak, nonatomic) IBOutlet UIButton *YeBtn;

@property (weak, nonatomic) IBOutlet UIButton *VipPayBtn;




@property (weak, nonatomic) IBOutlet UIView *BottomPayView;

@property (weak, nonatomic) IBOutlet UIButton *BottomPayBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomPayBtnHright;




- (IBAction)ChongzhiAction:(UIButton *)sender;


- (IBAction)PayBtnAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
