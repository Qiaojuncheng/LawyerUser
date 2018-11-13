//
//  lawMyConsultDetailCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyConsultDetailCell.h"

@implementation lawMyConsultDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.LawHeaderImage.height/2 view:self.LawHeaderImage];

//    self.ConsultBtn.userInteractionEnabled  = NO ;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(lawConsultdetailModel *)model{
    _model = model;
  
    [self.LawHeaderImage sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",ImageUrl,model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.lawNameLB.text = model.lawyer_name;
    self.TimeLB.text= model.time;
    self.ConcentLB.text = model.content;
    if ([model.is_adopt isEqualToString:@"0"]) {
//        未采纳
        self.cainaImageView.hidden = YES ;

    }else{
        self.cainaImageView.hidden = NO  ;
     }
    
    if ([model.adopt isEqualToString:@"0"]) {
        self.CainaBtn.hidden = NO ;
    }else{
        self.CainaBtn.hidden = YES ;
        
    }
    
}
- (IBAction)BtnAction:(UIButton *)sender {
    if (self.BtnActionBlock) {
        self.BtnActionBlock(sender.tag);
    }
}
@end
