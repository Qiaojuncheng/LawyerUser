//
//  lawPublicLegalSevice.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/31.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"
#import "LPlaceholderTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawPublicLegalSevice : BaseViewController
//1 案件委托 2合同审查 3 合同起草 4 发律师函 5 其他服务
@property (strong, nonatomic )NSString *type;

@property (weak, nonatomic) IBOutlet UILabel *CircleLB;
@property (weak, nonatomic) IBOutlet UILabel *OneCirceLB;
@property (weak, nonatomic) IBOutlet UILabel *TwoCircel;
@property (weak, nonatomic) IBOutlet UILabel *ThreeCircelLB;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopHeigt;

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *ContentTextView;
@property (weak, nonatomic) IBOutlet UILabel *PriceLB;

@property (weak, nonatomic) IBOutlet UITextField *SmallPrice;
@property (weak, nonatomic) IBOutlet UITextField *BigPrice;
@property (weak, nonatomic) IBOutlet UIView *SmallView;



- (IBAction)AddAction:(UIButton *)sender;






@end

NS_ASSUME_NONNULL_END
