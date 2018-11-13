//
//  lawPhoneAppointCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawAppointModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawPhoneAppointCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *publicTimeLB;
@property (strong ,nonatomic) lawAppointModel * model ;
@property (weak, nonatomic) IBOutlet UIView *RedView;
@property (weak, nonatomic) IBOutlet UILabel *ServiceLB;
@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *PersonImage;
@property (weak, nonatomic) IBOutlet UILabel *PriceLB;
@property (weak, nonatomic) IBOutlet UILabel *MeetAddresLB;

@property (weak, nonatomic) IBOutlet UILabel *PhoneLB;
@property (weak, nonatomic) IBOutlet UIImageView *ticketImage;

@property (weak, nonatomic) IBOutlet UIImageView *PhoneImage;
@property (weak, nonatomic) IBOutlet UILabel *TypeLB;

@property (strong, nonatomic) void(^OverBlock)();

- (IBAction)SureAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopHeight;




@end

NS_ASSUME_NONNULL_END
