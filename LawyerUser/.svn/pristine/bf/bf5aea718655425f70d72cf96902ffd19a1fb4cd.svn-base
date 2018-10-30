//
//  QJInfoCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/22.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJInfoCell.h"

@implementation QJInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
   // self.HeaderImage.contentMode = UIViewContentModeScaleAspectFill;
//    [Utile makeCorner:40 view:self.HeaderImage];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(QJNewModel *)model{
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:[UIImage imageNamed:@"占位符"] completed:nil];
    self.TitleLB.text = model.title;
    self.ConcentLB.text = model.desc;
    self.TimeLB.text = model.create_time;

}

@end
