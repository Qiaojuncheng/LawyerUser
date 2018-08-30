//
//  WYJiFenTableViewCell.m
//  Lawyer
//
//  Created by yu on 2017/10/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYJiFenTableViewCell.h"

@implementation WYJiFenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 30;
    // Initialization code
}
- (void)setModel:(WYJiFenModel *)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:[UIImage imageNamed:@"头像"]];
    
    
    self.lvshiLab.text = [NSString stringWithFormat:@"%@ | %@",model.name,model.offer];
    self.lvshiLab.text = [self.lvshiLab.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"律师"];
    [Utile setUILabel:self.lvshiLab data:nil setData:model.name color:DEEPTintColor font:16 underLine:NO];
    
    
    
    self.timeLab.text = model.create_time;
    self.stringLab.text = [NSString stringWithFormat:@"恭喜%@律师收到用户好评！",model.name];
    self.fengshuLab.text = [NSString stringWithFormat:@"+%@分",model.jf];
    [Utile setUILabel:self.fengshuLab data:[NSString stringWithFormat:@"+%@",model.jf] setData:@"分" color:TintColor font:14 underLine:NO];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
