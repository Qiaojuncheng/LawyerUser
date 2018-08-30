//
//  QJMyConsultCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMyConsultCell.h"

@implementation QJMyConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.YIHUIfuLb createBordersWithColor:LINECOLOR withCornerRadius:4 andWidth:1];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(QJMyConsultModel *)model{
    _model = model;
    self.YIHUIfuLb.hidden = YES;
    self.SolveLB.backgroundColor =[UIColor clearColor];
    self.SolveLB.textColor =[UIColor colorWithHex:0x333333];
    [self.SolveLB createBordersWithColor:LINECOLOR withCornerRadius:4 andWidth:1];

    self.DateLB.text  = [NSString timeWithTimeIntervalString:model.create_time];
    self.TypeLB.text = model.category_name;
    self.ConsultLB.text = model.showMessage;
    
    if ([model.status isEqualToString:@"1"]) {
            self.SolveLB.text = @"待回复";
   
    }else if ([model.status isEqualToString:@"2"]){
        self.YIHUIfuLb.hidden = NO;
        self.SolveLB.text = @"去评价";// 待评价的时候才能评论
        self.SolveLB.backgroundColor =MAINCOLOR;
        [self.SolveLB createBordersWithColor:MAINCOLOR withCornerRadius:4 andWidth:1];

        self.SolveLB.textColor =[UIColor whiteColor];
        [self.SolveLB whenTapped:^{
            self.ValuationBlock();
        }];
    }else  if ([model.status isEqualToString:@"3"]){
         self.SolveLB.text = @"已过期";
    }else  if ([model.status isEqualToString:@"4"]){
        self.SolveLB.text = @"服务结束";
    }


}

@end
