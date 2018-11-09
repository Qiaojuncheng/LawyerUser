//
//  lawCollectLawyerCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/9.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawCollecLawyerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawCollectLawyerCell : UITableViewCell
@property (strong, nonatomic) lawCollecLawyerModel * model ;
@property (weak, nonatomic) IBOutlet UIImageView *lawImgeView;

@property (weak, nonatomic) IBOutlet UILabel *Lawname;

@property (weak, nonatomic) IBOutlet UILabel *LawAddress;
@property (weak, nonatomic) IBOutlet UILabel *yearLB;
@property (weak, nonatomic) IBOutlet UILabel *CollectionLB;


@end

NS_ASSUME_NONNULL_END
