//
//  QJAppointmentCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJAppointmentCell.h"

@implementation QJAppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:40 view:self.IconLb];
    self.StateLb.backgroundColor =[UIColor clearColor];
    self.StateLb.textColor =[UIColor colorWithHex:0x333333];
    [self.StateLb createBordersWithColor:LINECOLOR withCornerRadius:4 andWidth:1];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(QJAppontmentModel *)model{

    [self.IconLb sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:[UIImage imageNamed:@"头像.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    
    self.NameLb.text = model.name;
    if ([model.type  isEqualToString:@"1"]) {
        self.TypeLb.text =@"预约方式：电话";
        self.AddressLb.text = [NSString stringWithFormat:@"时间 %@",model.meet_time];
        self.TimeLb.text = [NSString stringWithFormat:@"电话 %@",model.phone];
        self.PhoneLb.hidden = YES;
        
     }else{
         self.TypeLb.text = @"预约方式：见面";
         
         self.AddressLb.text = [NSString stringWithFormat:@"地址 %@",model.meet_address];
         self.TimeLb.text = [NSString stringWithFormat:@"时间 %@",model.meet_time];
         self.PhoneLb.text = [NSString stringWithFormat:@"电话 %@",model.phone];
     }
    
    
    
//      4  已完成   5 已结束 ，字体灰色 不能点击
    //     }else if ([_model.status isEqualToString:@"2"]){

    if ([model.status isEqualToString:@"1"]) {
        self.StateLb.text = @"待回复";
    }else if ([model.status isEqualToString:@"2"]){
    
        self.StateLb.text = @"已预约";

    }else  if ([model.status isEqualToString:@"3"]){
        self.StateLb.text = @"已拒绝";
        
    }else  if ([model.status isEqualToString:@"4"]){
        self.StateLb.text = @"去评价";
        
        
    }else  if ([model.status isEqualToString:@"5"]){
        self.StateLb.text = @"已完成";
         
    }
    self.StatusWidth.constant = [NSString GetHeightWithMaxSize:CGSizeMake(ConentViewWidth, 100) AndFont:self.StateLb.font AndText:self.StateLb.text].width+ 10;

}

@end
