//
//  QJMainPageTopView.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/19.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMainPageTopView.h"

@implementation QJMainPageTopView

-(void)awakeFromNib{
    [super awakeFromNib ];
    self.CenterView.layer.masksToBounds = YES;
    self.CenterView.layer.cornerRadius = 38;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
