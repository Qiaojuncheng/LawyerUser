//
//  lawCollectLawyerCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/9.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawCollectLawyerCell.h"

@implementation lawCollectLawyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.lawImgeView.height/2 view:self.lawImgeView];
    [Utile makeCorner:self.CollectionLB.height/2 view:self.CollectionLB];
    [Utile makeCorner:4 view:self.yearLB];
    // Initialization code
}
-(void)setModel:(lawCollecLawyerModel *)model{
    
    [self.lawImgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ImageUrl,model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.Lawname.text = [NSString stringWithFormat:@"%@",model.name];
    self.yearLB.text = [NSString stringWithFormat:@"执业%@年",model.practice_years];
    self.LawAddress.text =[NSString stringWithFormat:@"%@·%@",model.city_name,model.company];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
