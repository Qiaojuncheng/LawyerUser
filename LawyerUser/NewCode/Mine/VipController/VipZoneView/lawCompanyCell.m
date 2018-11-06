//
//  lawCompanyCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawCompanyCell.h"

@implementation lawCompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.CellCompanyImage.height/2 view:self.CellCompanyImage];
    // Initialization code
}
-(void)setModel:(lawCompanyModel *)model{
    _model = model;
    self.CommanyNameLB.text = model.name;
    [self.CellCompanyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.img]] placeholderImage:nil];
//    self.TypeLB.text=  model.
    self.AddressLB.text = model.region;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
