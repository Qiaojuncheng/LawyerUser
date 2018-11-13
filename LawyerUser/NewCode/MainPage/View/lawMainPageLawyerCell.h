//
//  lawMainPageLawyerCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/15.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawLawyerModle.h"
@interface lawMainPageLawyerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DistanceLB;


@property (strong , nonatomic) lawLawyerModle * model;
@property (weak, nonatomic) IBOutlet UIImageView *LawyerImaegView;
 @property (weak, nonatomic) IBOutlet UILabel *lawyerName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;

@property (weak, nonatomic) IBOutlet UIImageView *TuiImage;
@property (weak, nonatomic) IBOutlet UILabel *AddressLB;
@property (weak, nonatomic) IBOutlet UIView *TypeView;


@end
