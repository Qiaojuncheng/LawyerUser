//
//  QJLawyerTItleCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/17.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJLawyerTItleCell.h"

@implementation QJLawyerTItleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:35 view:self.LawyerImagView];

    self.ApproveLB.layer.masksToBounds = YES;
    self.ApproveLB.layer.cornerRadius = 10;
    
    self.WorkTime.layer.masksToBounds = YES;
    self.WorkTime.layer.cornerRadius = 5;
    self.WorkTime.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });

    self.WorkTime.layer.borderColor =borderColorRef;
    
    
    self.guanzhuBtn.layer.masksToBounds = YES;
    self.guanzhuBtn.layer.cornerRadius = 5;
    self.guanzhuBtn.layer.borderWidth = 1;
    self.guanzhuBtn.layer.borderColor = borderColorRef;
    
    
    // Initialization code
}
- (void)setModel:(WYlawyerDetail *)model{
    [self.LawyerImagView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:nil];
    self.LawyerNameLB.text = [NSString changeNullString:[NSString stringWithFormat:@"%@",model.name]];
    self.LawyerProfessionLB.text = [NSString stringWithFormat:@"律师"];

    self.WorkTime.text = [NSString stringWithFormat:@"执业%@年",[NSString changeNullString:model.work_time]];
    
    self.AddressLB.text = [NSString stringWithFormat:@"%@-%@-%@",model.province_name,model.city_name,model.area_name];
    self.AddressLB.text = [self.AddressLB.text stringByReplacingOccurrencesOfString:@"(null)" withString:@"暂无"];
    
    
    self.RemarkLB.text = [NSString stringWithFormat:@"%@个关注",[NSString changeNullString:model.keepCount]];
    self.huidaLab.text = [NSString stringWithFormat:@"%@个回答",[NSString changeNullString:model.zixunCount]];
    
    float b = 0;
    for (int a = 0; a < model.cate_name.count; a ++ ) {
        UILabel *laves = [[UILabel alloc]init];
        laves.textAlignment = NSTextAlignmentCenter;
        laves.font = [UIFont systemFontOfSize:14];
        laves.layer.masksToBounds = YES;
        laves.layer.cornerRadius = 6;
        laves.backgroundColor = MAINCOLOR;
        laves.textColor = [UIColor whiteColor];
        laves.text = [NSString stringWithFormat:@"%@",[NSString changeNullString:model.cate_name[a]]];
        CGRect rectWhite = [laves boundingRectWithInitSize:laves.frame.size];
      
        laves.frame = CGRectMake(b, 0, rectWhite.size.width + 5, 15);
        b += rectWhite.size.width + 10;
        [self.scrollView addSubview:laves];
    }
    self.scrollView.contentSize = CGSizeMake(b, 0);
    
    NSString *isshow = [NSString stringWithFormat:@"%@",model.is_show];
    if ([isshow isEqualToString:@"1"]) {
        self.ApproveLB.hidden = NO;
    }else{
        self.ApproveLB.hidden = YES;
    }
    NSString *guanStr = [NSString stringWithFormat:@"%@",model.lawyerKeep];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
    
    self.guanzhuBtn.layer.borderColor =borderColorRef;
    
    if ([guanStr isEqualToString:@"yes"]) {
        
        [self.guanzhuBtn setTitle:@"已关注" forState:normal];
        self.guanzhuBtn.backgroundColor = MAINCOLOR;
        [self.guanzhuBtn setTitleColor:[UIColor whiteColor] forState:normal];
        
    }else{
        [self.guanzhuBtn setTitle:@"关注" forState:normal];
        self.guanzhuBtn.backgroundColor = [UIColor whiteColor];
        [self.guanzhuBtn setTitleColor:MAINCOLOR forState:normal];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
