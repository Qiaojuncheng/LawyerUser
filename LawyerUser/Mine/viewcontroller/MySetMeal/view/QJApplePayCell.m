//
//  QJApplePayCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/10/31.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJApplePayCell.h"

@implementation QJApplePayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [Utile makeCorner:3 view:self.ConcentLB];
    // Initialization code
}

@end
