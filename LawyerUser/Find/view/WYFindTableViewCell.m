//
//  WYFindTableViewCell.m
//  Lawyer
//
//  Created by yu on 2017/9/22.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "WYFindTableViewCell.h"

@implementation WYFindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.img.layer.masksToBounds = YES;
    self.img.layer.cornerRadius = 35;
    
    _StarView = [[RatingBar alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 33, 100, 25)];
    _StarView.centerY  = self.pingLab.centerY -1;
    _StarView.enable = NO;
    _StarView.starNumber = 3;
    _StarView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_StarView];
    
    
    
    self.timeLab.layer.masksToBounds = YES;
    self.timeLab.layer.cornerRadius = 3;
    self.timeLab.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
    
    self.timeLab.layer.borderColor =borderColorRef;
    
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void)setModel:(WYFindViewModel *)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLab.text = [NSString stringWithFormat:@"%@ 律师",model.name];
    [Utile setUILabel:self.nameLab data:[NSString stringWithFormat:@"%@ ",model.name] setData:@"律师" color:TintColor font:14.0 underLine:NO];
    
    self.companyLab.text = [NSString stringWithFormat:@"%@",model.company];
    self.companyLab.text = [self.companyLab.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    self.timeLab.text = [NSString stringWithFormat:@"执业%@年",model.work_time];
    
    self.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@",model.province_name,model.city_name,model.area_name];
    self.addressLab.text = [self.addressLab.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    float b = 0;
    for (int a= 0; a < model.cate_name.count; a ++ ) {
        UILabel *labels = [[UILabel alloc]init];
        labels.backgroundColor = MAINCOLOR;
        labels.font = [UIFont systemFontOfSize:12];
        labels.text = [NSString stringWithFormat:@"%@",model.cate_name[a]];
        labels.textColor = [UIColor whiteColor];
    
        CGRect lavRect = [labels boundingRectWithInitSize:labels.frame.size];
        labels.frame = CGRectMake(b, 0, lavRect.size.width+ 15, 15);
        b += lavRect.size.width + 10;
        labels.textAlignment = NSTextAlignmentCenter;
        labels.layer.masksToBounds = YES;
        labels.layer.cornerRadius = 6;
        [self.cateNameLab addSubview:labels];
        
    }
    
    if ([model.lawyer_level_id intValue] > 3) {
        self.pingLab.text = [NSString stringWithFormat:@"%@ 好评",model.lawyer_level_id];
    }else if ([model.lawyer_level_id intValue] == 3){
        self.pingLab.text = [NSString stringWithFormat:@"%@ 中评",model.lawyer_level_id];
    }else{
        self.pingLab.text = [NSString stringWithFormat:@"%@ 差评",model.lawyer_level_id];
    }
    
    
    
    [Utile setUILabel:self.pingLab data:nil setData:model.lawyer_level_id color:MainYellowColor font:14 underLine:NO];
    
    _StarView.starNumber = [model.lawyer_level_id integerValue];
    
}

@end
