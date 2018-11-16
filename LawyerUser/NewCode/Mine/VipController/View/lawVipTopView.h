//
//  lawVipTopView.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/2.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawVipTopView : UIView
@property (strong, nonatomic) NSString * VipPriceStr ;
@property (strong, nonatomic) NSString * VipId ;
@property (strong, nonatomic) MyInfoModel * Model;
@property (weak, nonatomic) IBOutlet UILabel *HeaderNameLB;
@property (weak, nonatomic) IBOutlet UIImageView *VipImage;
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *OneTimeLB;
@property (weak, nonatomic) IBOutlet UIButton *VipTypeBtn;

@property (weak, nonatomic) IBOutlet UILabel *TwoTimeLB;


@property (weak, nonatomic) IBOutlet UIButton *OneBtn;
@property (weak, nonatomic) IBOutlet UIButton *TwoBtn;

- (IBAction)BtnAction:(UIButton *)sender;
- (IBAction)BackVC:(id)sender;

-(void)initSubview;

@end

NS_ASSUME_NONNULL_END
