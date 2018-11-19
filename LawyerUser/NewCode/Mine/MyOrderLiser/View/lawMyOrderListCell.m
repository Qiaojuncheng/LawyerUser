//
//  lawMyOrderListCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyOrderListCell.h"

@implementation lawMyOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.headerImage.height/2 view:self.headerImage];
    // Initialization code
}
-(void)setModel:(lawMyOrderModel *)model{
    _model  = model;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    
    
    self.NameLb.text = model.name;
    self.BigType.text= model.type_name;
    self.TypeLB.text = model.cate_name;
    self.concentLB.text =model.content;
    self.TimeLB.text = model.create_time;
    self.numLB.text = [NSString stringWithFormat:@"%@人竞标",model.lawyer_num];
    self.Address.text =  [NSString stringWithFormat:@"%@·%@",model.province_name,model.city_name];
   
    NSString *paytype ;
    if ([model.pay_type isEqualToString:@"1"]) {
        paytype =@"微信";
    }else if ([model.pay_type isEqualToString:@"2"]) {
        paytype =@"余额";
    }else if ([model.pay_type isEqualToString:@"3"]) {
        paytype =@"套餐券";
    }
    
    if([model.type  isEqualToString:@"1"]){
        self.PriceLB.text = [NSString stringWithFormat:@"服务价格：%@元（%@支付）",model.user_money,paytype];

    }else{
        self.PriceLB.text = [NSString stringWithFormat:@"服务价格：%@元（%@支付）",model.money,paytype];

        
    }
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
