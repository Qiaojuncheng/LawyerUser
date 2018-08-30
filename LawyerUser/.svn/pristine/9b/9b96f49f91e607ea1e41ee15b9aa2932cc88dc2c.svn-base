//
//  QJEspenseCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJEspenseCell.h"

@implementation QJEspenseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:26 view:self.BigImageView];
    // Initialization code
}
-(void)setModel:(QJXiaoFeiModel *)model{


    self.DateLB.text = model.time;
    
//    type：1 //1 充值 2 提现 3 开通会员 4:预约支付 5：咨询支付 6：代写文书 7：案件委托 8：审查合同 9：发律师函
    if([model.type isEqualToString:@"1"]){
        self.DesLB.text = [NSString stringWithFormat:@"充值支付成功"];
     }else if ([model.type isEqualToString:@"2"]){
         self.DesLB.text = [NSString stringWithFormat:@"提现成功"];
     }else if ([model.type isEqualToString:@"3"]){
         self.DesLB.text = [NSString stringWithFormat:@"开通会员支付成功"];
     }else if ([model.type isEqualToString:@"4"]){
         self.DesLB.text = [NSString stringWithFormat:@"预约支付成功"];
     }else if ([model.type isEqualToString:@"5"]){
         self.DesLB.text = [NSString stringWithFormat:@"咨询支付成功"];
     }else if ([model.type isEqualToString:@"6"]){
         self.DesLB.text = [NSString stringWithFormat:@"代写文书支付成功"];
     }else if ([model.type isEqualToString:@"7"]){
         self.DesLB.text = [NSString stringWithFormat:@"案件委托支付成功"];
     }else if ([model.type isEqualToString:@"8"]){
         self.DesLB.text = [NSString stringWithFormat:@"审查合同支付成功"];
     }else if ([model.type isEqualToString:@"9"]){
         self.DesLB.text = [NSString stringWithFormat:@"发律师函支付成功"];
     }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
