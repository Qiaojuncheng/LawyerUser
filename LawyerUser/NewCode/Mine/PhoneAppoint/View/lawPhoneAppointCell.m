//
//  lawPhoneAppointCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPhoneAppointCell.h"

@implementation lawPhoneAppointCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    [Utile makecorner:5 view:self.SureBtn color:[UIColor colorWithHex:0x3181FE]];
    [Utile makeCorner:4 view:self.RedView];
    [Utile makeCorner:self.personImageView.height/2 view:self.personImageView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SureAction:(id)sender {
}
@end
