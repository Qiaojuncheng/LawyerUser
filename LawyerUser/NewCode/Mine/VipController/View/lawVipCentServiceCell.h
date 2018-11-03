//
//  lawVipCentServiceCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/2.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawVipModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawVipCentServiceCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (weak, nonatomic) IBOutlet UILabel *DesLB;
@property (weak, nonatomic) IBOutlet UIView *RightLineView;

@property (strong, nonatomic) lawVipModel  * model;


@end

NS_ASSUME_NONNULL_END
