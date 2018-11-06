//
//  lawPhoneAppointCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawPhoneAppointCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *publicTimeLB;

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

- (IBAction)SureAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;






@end

NS_ASSUME_NONNULL_END
