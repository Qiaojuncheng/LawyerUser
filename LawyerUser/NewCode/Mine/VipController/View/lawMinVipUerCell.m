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
    [Utile makeCorner:self.IconImaegVIew.height/2 view:self.IconImaegVIew];

    // Initialization code
}
-(void)setModel:(lawVipRecodeModel *)model{
    _model = model;
    self.TypeLB.text = model.remark;
    self.LawyerLB.text =[NSString stringWithFormat:@"服务律师：%@",_model.lawyer_name];
    self.TimeLB.text =[NSString timeWithTimeIntervalString:model.time];
    self.surplusLB.text = [NSString stringWithFormat:@"剩余次数：%@",model.num];
    [self.IconImaegVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.icon]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
