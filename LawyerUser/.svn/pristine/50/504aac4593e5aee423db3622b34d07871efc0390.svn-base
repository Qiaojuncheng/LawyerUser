//
//  QJVipCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/22.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJVipCell.h"

@implementation QJVipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selected = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)makeCellWithDic:(NSDictionary *)dic{

    self.NameLB.text =[NSString stringWithFormat:@"%@%@元/年",dic[@"name"],dic[@"price"]];
    

}

@end
