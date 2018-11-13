//
//  lawMyConsultCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawMyconsultListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawMyConsultCell : UITableViewCell
@property (strong , nonatomic )lawMyconsultListModel *Model;

@property (weak, nonatomic) IBOutlet UIImageView *PersonImageView;
@property (weak, nonatomic) IBOutlet UILabel *PersonNameLB;
@property (weak, nonatomic) IBOutlet UILabel *TypeLB;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;

@property (weak, nonatomic) IBOutlet UILabel *AnswerLB;

@property (weak, nonatomic) IBOutlet UIView *RedVIew;



@end

NS_ASSUME_NONNULL_END
