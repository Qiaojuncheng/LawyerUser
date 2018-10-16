//
//  lawDetailMiddleCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawLawyerDetailModle.h"
typedef void(^Reload)();
@interface lawDetailMiddleCell : UITableViewCell
@property (strong ,nonatomic )lawLawyerDetailModle * model;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (weak, nonatomic) IBOutlet UIImageView *MoreImaeg;
@property (weak, nonatomic) IBOutlet UIView *ActionView;
@property (assign , nonatomic) BOOL show;
@property (copy, nonatomic) Reload  reloadDateBlock;
@end
