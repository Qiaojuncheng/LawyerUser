//
//  lawMyConsultDetailCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawConsultdetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawMyConsultDetailCell : UITableViewCell
@property (strong , nonatomic ) lawConsultdetailModel * model ;

@property (weak, nonatomic) IBOutlet UIImageView *LawHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *lawNameLB;

@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UIButton *ConsultBtn;
@property (weak, nonatomic) IBOutlet UIButton *CainaBtn;

@property (weak, nonatomic) IBOutlet UIImageView *cainaImageView;





@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (strong, nonatomic) void(^BtnActionBlock)(int index);

- (IBAction)BtnAction:(UIButton *)sender;




@end

NS_ASSUME_NONNULL_END
