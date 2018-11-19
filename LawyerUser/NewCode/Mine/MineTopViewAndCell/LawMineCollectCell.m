//
//  LawMineCollectCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/11.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMineCollectCell.h"

@implementation LawMineCollectCell
-(void)layoutSubviews{
    [super layoutSubviews];
    [Utile makeCorner:4 view:self.RedView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:5 view:self.CellImage];
    // Initialization code
}

@end
