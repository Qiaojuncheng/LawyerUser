//
//  lawCompanyCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawCompanyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawCompanyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CellCompanyImage;

@property (weak, nonatomic) IBOutlet UILabel *CommanyNameLB;
@property (weak, nonatomic) IBOutlet UILabel *TypeLB;
@property (weak, nonatomic) IBOutlet UILabel *AddressLB;

@property (strong ,nonatomic) lawCompanyModel * model;



@end

NS_ASSUME_NONNULL_END
