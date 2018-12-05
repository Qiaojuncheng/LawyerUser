//
//  lawMyOrderDetailCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawOrderResultModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawMyOrderDetailCell : UITableViewCell

@property (strong , nonatomic) lawOrderResultModel * model ;
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *PersonNaem;

@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;


@property (weak, nonatomic) IBOutlet UIButton *PinBtn;
@property (copy ,nonatomic) void (^PinBlock)();
- (IBAction)PinAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
