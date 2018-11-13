//
//  lawVipRechargeCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/3.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawVipRecodeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawVipRechargeCell : UITableViewCell
@property (strong ,nonatomic) lawVipRecodeModel * model;
@property (weak, nonatomic) IBOutlet UILabel *oderNum;

@property (weak, nonatomic) IBOutlet UILabel *VipName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;

@property (weak, nonatomic) IBOutlet UILabel *PriceLB;


@property (weak, nonatomic) IBOutlet UILabel *YearLb;



@end

NS_ASSUME_NONNULL_END
