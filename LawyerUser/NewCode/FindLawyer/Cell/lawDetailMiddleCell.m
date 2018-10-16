//
//  lawDetailMiddleCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawDetailMiddleCell.h"

@implementation lawDetailMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self.ActionView whenTouchedUp:^{
        if(self.reloadDateBlock){
            self.reloadDateBlock();
        }
     }];
  }
-(void)setShow:(BOOL)show{
    if(show){
        [UIView animateWithDuration:0.2f animations:^{
            if (self.MoreImaeg) {
                self.MoreImaeg.transform = CGAffineTransformMakeRotation(M_PI);
            }
        }];

    }else{
        
        
    }
    
}
-(void)setModel:(lawLawyerDetailModle *)model{
    _model = model;
    self.ConcentLB.text = model.instru;
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
