//
//  lawVipRechargeCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/3.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipRechargeCell.h"

@implementation lawVipRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(lawVipRecodeModel *)model{
    _model = model;
    
    self.oderNum.text = [NSString stringWithFormat:@"订单号：%@",model.order_sn];
    self.VipName.text =[NSString stringWithFormat:@"%@VIP会员",model.name];
    
    self.PriceLB.text =[NSString stringWithFormat:@"￥%@",model.price];
    self.TimeLB.text=[NSString timeWithTimeIntervalString:model.time];
    self.YearLb.text =[NSString stringWithFormat:@"%@年",model.valid_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
