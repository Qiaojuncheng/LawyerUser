//
//  lawVipZoneTopView.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/4.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawVipConcentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawVipZoneTopView : UIView

@property (weak, nonatomic) IBOutlet UILabel *NameLB;
@property (strong, nonatomic) UIButton * tempBtn;
@property (weak, nonatomic) IBOutlet UIImageView *personHeaderImage;
- (IBAction)CarBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *oneCardBtn;
@property (weak, nonatomic) IBOutlet UIView *WhiteView;
@property (weak, nonatomic) IBOutlet UIView *YellView;
@property (weak, nonatomic) IBOutlet UIView *SmallWhiteView;

@property (weak, nonatomic) IBOutlet UILabel *PriceLB;
@property (weak, nonatomic) IBOutlet UIView *ConcentView;

//
@property (strong, nonatomic) NSArray * DataArray;
@property (strong, nonatomic) void(^changHeightBlock)(CGFloat height);
 
 
- (IBAction)MoreBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WhiteViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *MessageLB;

@property (weak, nonatomic) IBOutlet UILabel *KaitongNumberLB;



-(void)makeSubviews;

- (IBAction)BuyVipAction:(UIButton *)sender;






@end

NS_ASSUME_NONNULL_END
