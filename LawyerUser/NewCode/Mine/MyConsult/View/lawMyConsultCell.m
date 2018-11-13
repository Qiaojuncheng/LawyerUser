//
//  lawMyConsultCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMyConsultCell.h"

@implementation lawMyConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.PersonImageView.height/2 view:self.PersonImageView];
    [Utile makeCorner:self.RedVIew.height/2 view:self.RedVIew];
    // Initialization code
}
-(void)setModel:(lawMyconsultListModel *)Model{
    _Model = Model;

    
    [self.PersonImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",ImageUrl,Model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    
    self.PersonNameLB.text = [NSString stringWithFormat:@"%@",Model.name];
    self.TypeLB.text = Model.cate_name;
    self.ConcentLB.text =Model.content;
    if ([Model.reply_count integerValue] > 0) {
        self.AnswerLB.text = [NSString stringWithFormat:@"%@·%@人回答",Model.create_time,Model.reply_count];
    }else{
        self.AnswerLB.text = [NSString stringWithFormat:@"%@",Model.create_time];
    }
    if ([Model.red isEqualToString:@"1"]) {
        self.RedVIew.hidden = YES ;
    }else{
        self.RedVIew.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
