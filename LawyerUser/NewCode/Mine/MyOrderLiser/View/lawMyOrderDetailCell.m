//
//  lawMyOrderDetailCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyOrderDetailCell.h"

@implementation lawMyOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.HeaderImage.height/2 view:self.HeaderImage];
    [Utile makeCorner:self.PinBtn.height/2 view:self.PinBtn];
    // Initialization code
}
-(void)setModel:(lawOrderResultModel *)model{
    _model  = model ;
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.avatar ]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.PersonNaem.text =[NSString stringWithFormat:@"%@律师",model.name];
    self.TimeLB.text = model.time;
    self.ConcentLB.text = model.describe;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)PinAction:(UIButton *)sender {
    if(self.PinBlock){
        self.PinBlock();
    }
}
@end
