//
//  lawMyConsultCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyConsultCell.h"

@implementation lawMyConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.PersonImageView.height/2 view:self.PersonImageView];
    [Utile makeCorner:self.RedVIew.height/2 view:self.RedVIew];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
