//
//  QJNearCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/7/28.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNearCell.h"

@implementation QJNearCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _RenZhenLB.layer.masksToBounds = YES;
    _RenZhenLB.layer.cornerRadius = 11;
    
    _Consult.layer.masksToBounds = YES;
    _Consult.layer.cornerRadius = 5;
    _Consult.layer.borderWidth = 1;
    _Consult.layer.borderColor =[MAINCOLOR CGColor];
    
    _FirstLB.layer.cornerRadius = 8;
    _FirstLB.layer.masksToBounds = YES;
    
    _SecondLB.layer.cornerRadius = 8;
    _SecondLB.layer.masksToBounds = YES;
    
    _ThirdLB.layer.cornerRadius = 8;
    _ThirdLB.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
