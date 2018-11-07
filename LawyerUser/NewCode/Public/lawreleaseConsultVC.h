//
//  lawreleaseConsultVC.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/31.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"
#import "LPlaceholderTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawreleaseConsultVC : BaseViewController

@property (strong, nonatomic) NSString * type ;// 1 悬赏  2 免费

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Topheight;
@property (weak, nonatomic) IBOutlet UILabel *FirstLb;
@property (weak, nonatomic) IBOutlet UILabel *SecondLB;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLB;

@property (weak, nonatomic) IBOutlet UILabel *FourLB;

@property (weak, nonatomic) IBOutlet UILabel *typeLB;

@property (weak, nonatomic) IBOutlet LPlaceholderTextView *ContentTextView;


@property (weak, nonatomic) IBOutlet UIView *middlView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomVIewTop;

- (IBAction)EnSureAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *EnSureBtn;
@property (weak, nonatomic) IBOutlet UILabel *desLb;


@property (weak, nonatomic) IBOutlet UILabel *LabelO;

@property (weak, nonatomic) IBOutlet UILabel *LabelT;
@property (weak, nonatomic) IBOutlet UILabel *LabelTHr;

@property (weak, nonatomic) IBOutlet UILabel *LaeblFO;



@property (weak, nonatomic) IBOutlet UILabel *PriceOneLB;
@property (weak, nonatomic) IBOutlet UILabel *PriceTwoLB;
@property (weak, nonatomic) IBOutlet UILabel *PriceThreeLB;

@property (weak, nonatomic) IBOutlet UILabel *PriceFourLB;
- (IBAction)privacyAction:(UIButton *)sender;

- (IBAction)QuestAction:(UIButton *)sender;





@end

NS_ASSUME_NONNULL_END
