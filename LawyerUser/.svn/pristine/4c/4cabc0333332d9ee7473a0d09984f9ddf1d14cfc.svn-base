//
//  QJTaoCanCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/22.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJTaoCanCell.h"

@implementation QJTaoCanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(QJTaocanModel *)model{
    if ([model.price isEqualToString:@"Price"] ) {
        self.PriceLBHeight.constant = 0;
    }else{
        self.PriceLBHeight.constant = 15;
        self.PriceLb.text = [NSString stringWithFormat:@"%@元",model.price];

    }
        self.TypeLB.text = model.level_name;
        self.NumberLB.text  = model.now_num ;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
