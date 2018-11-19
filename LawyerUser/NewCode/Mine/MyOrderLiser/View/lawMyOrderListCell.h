//
//  lawMyOrderListCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawMyOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawMyOrderListCell : UITableViewCell

@property (strong ,nonatomic) lawMyOrderModel * model ;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLb;
@property (weak, nonatomic) IBOutlet UILabel *BigType;
@property (weak, nonatomic) IBOutlet UILabel *concentLB;

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;
@property (weak, nonatomic) IBOutlet UILabel *PriceLB;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;

@property (weak, nonatomic) IBOutlet UILabel *numLB;
@property (weak, nonatomic) IBOutlet UILabel *Address;



@end

NS_ASSUME_NONNULL_END
