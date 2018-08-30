//
//  QJMiddleBuyView.m
//  Lawyer
//
//  Created by MYMAc on 2017/7/28.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMiddleBuyView.h"

@implementation QJMiddleBuyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    _BaojiaButton.layer.masksToBounds = YES;
    _BaojiaButton.layer.cornerRadius = 10;
    _BaojiaButton.layer.borderWidth= 1;
    _BaojiaButton.layer.borderColor = [MAINCOLOR CGColor];
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.ShwoMessageLB.text];
    NSRange redRange = NSMakeRange(4, [[noteStr string] rangeOfString:@"购买套餐"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:redRange];
    [self.ShwoMessageLB setAttributedText:noteStr] ;
}
- (IBAction)BaojiaAction:(id)sender {
    
    
    
}
@end
