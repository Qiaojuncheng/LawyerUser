//
//  QJLawyerListCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/29.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJLawyerListCell.h"

@implementation QJLawyerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 30;
    // Initialization code
}
- (void)setModel:(QJLawyerModle *)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]]];
    
    self.nameLab.text = [NSString stringWithFormat:@"%@ | %@",model.name,[NSString changeNullString:model.offer]];
    if ([NSString changeNullString:model.offer].length == 0) {
        self.nameLab.text = [NSString stringWithFormat:@"%@ ",model.name];
 
    }
    
    [Utile setUILabel:self.nameLab data:[NSString stringWithFormat:@"%@ | ",model.name] setData:[NSString stringWithFormat:@"%@",model.offer] color:MAINCOLOR font:15 underLine:NO];
    self.companyLab.text = [NSString stringWithFormat:@"律所：%@",model.company];
    self.addressLab.text = [NSString stringWithFormat:@"地域：%@",model.pca];
    self.priceLab.text = [NSString stringWithFormat:@"报价：%@¥",model.price];
    self.zhuanchangLab.text = [NSString stringWithFormat:@"专长：%@",model.cate_id_three_];
    self.timeLab.text = [NSString stringWithFormat:@"交付时间：%@",model.finish_time];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
