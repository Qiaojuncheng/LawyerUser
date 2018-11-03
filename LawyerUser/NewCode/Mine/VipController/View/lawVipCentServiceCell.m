//
//  lawVipCentServiceCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/2.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipCentServiceCell.h"

@implementation lawVipCentServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(lawVipModel *)model{
    _model = model;
    
    [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.icon]] placeholderImage:nil];
    self.titleLB.text=  model.name;
    self.DesLB.text = [NSString stringWithFormat:@"剩余次数:%@",model.num];
}

@end
