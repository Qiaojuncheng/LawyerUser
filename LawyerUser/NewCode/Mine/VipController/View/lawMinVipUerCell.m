//
//  lawMinVipUerCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/3.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMinVipUerCell.h"

@implementation lawMinVipUerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(lawVipRecodeModel *)model{
    _model = model;
    self.TypeLB.text = model.remark;
    self.LawyerLB.text =[NSString stringWithFormat:@"服务律师：%@",_model.lawyer_name];
    self.TimeLB.text =[NSString timeWithTimeIntervalString:model.time];
    self.surplusLB.text = [NSString stringWithFormat:@"剩余次数：%@",model.num];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
