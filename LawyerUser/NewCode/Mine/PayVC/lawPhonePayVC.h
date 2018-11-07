//
//  lawPhonePayVC.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface lawPhonePayVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;
@property (strong, nonatomic) NSString *Pricestr;
@property (weak, nonatomic) IBOutlet UIButton *WXpayBtn;
@property (weak, nonatomic) IBOutlet UIButton *AirPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *YeLB;
@property (weak, nonatomic) IBOutlet UIButton *YeBtn;

 

- (IBAction)PayBtnAction:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
