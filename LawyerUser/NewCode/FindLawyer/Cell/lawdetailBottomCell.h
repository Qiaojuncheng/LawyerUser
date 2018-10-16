//
//  lawdetailBottomCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawLawyerDetailModle.h"
typedef void(^touchck)(NSInteger index);

@interface lawdetailBottomCell : UITableViewCell
@property (strong ,nonatomic )lawLawyerDetailModle * model;

@property (weak, nonatomic) IBOutlet UILabel *FirstLB;
@property (weak, nonatomic) IBOutlet UILabel *SecondLB;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLB;

@property (weak, nonatomic) IBOutlet UIView *FirstView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *TwoView;
@property (weak, nonatomic) IBOutlet UIView *ThreeView;

@property (strong ,nonatomic) touchck touchBlock ;

@end
