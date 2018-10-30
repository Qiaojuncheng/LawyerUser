//
//  lawdetailBottomCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawdetailBottomCell.h"

@implementation lawdetailBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.oneView createCornerRadiusShadowWithCornerRadius:5 offset:CGSizeMake(0, 1) opacity:1 radius:3 Color:[UIColor colorWithRed:38/255.0 green:89/255.0 blue:149/255.0 alpha:0.16]] ; // #265995
    [self.TwoView createCornerRadiusShadowWithCornerRadius:5 offset:CGSizeMake(0, 1) opacity:1 radius:3 Color:[UIColor colorWithRed:38/255.0 green:89/255.0 blue:149/255.0 alpha:0.16]] ; // #265995
    [self.ThreeView createCornerRadiusShadowWithCornerRadius:5 offset:CGSizeMake(0, 1) opacity:1 radius:3 Color:[UIColor colorWithRed:38/255.0 green:89/255.0 blue:149/255.0 alpha:0.16]] ; //

    [self makeVeiwColor];


    [self.FirstView whenTouchedUp:^{
        [self makeVeiwColor];
        self.FirstView.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
        if (self.touchBlock) {
            self.touchBlock(10);
        }
    }];
    [self.SecondView whenTouchedUp:^{
        [self makeVeiwColor];
        self.SecondView.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
        if (self.touchBlock) {
            self.touchBlock(11);
        }
    }];  [self.ThirdView whenTouchedUp:^{
        [self makeVeiwColor];
        self.ThirdView.backgroundColor = [UIColor colorWithHex:0xF6F6F6];
        if (self.touchBlock) {
            self.touchBlock(12);
        }
    }];
    // Initialization code
}
-(void)makeVeiwColor{
    
    self.FirstView.backgroundColor = [UIColor whiteColor];
    self.SecondView.backgroundColor = [UIColor whiteColor];
    self.ThirdView.backgroundColor = [UIColor whiteColor];
}
-(void)setModel:(lawLawyerDetailModle *)model{
    _model = model;
    self.FirstLB.text = [NSString stringWithFormat:@"%@元/次",model.phone_money];
    self.SecondLB.text = [NSString stringWithFormat:@"%@元/次",model.meet_money];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
