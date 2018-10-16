//
//  lawMainMiddleView.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/13.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMainMiddleView.h"

@implementation lawMainMiddleView
-(instancetype)initWithFrame:(CGRect)frame{
  self  = [super initWithFrame:frame];
         return self;

}

-(void)setImageStr:(NSString *)ImageStr{
     UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 57, 67)];
    image.image =[UIImage imageNamed:ImageStr];
    image.centerX = self.width/2;
 
    [self addSubview:image];
}
-(void)setTitleStr:(NSString *)TitleStr{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHex:0x333333];
    label.text = TitleStr;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
 
    [self addSubview:label];
 }
-(void)setDesStr:(NSString *)DesStr{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.width, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHex:0x999999];
    label.text = DesStr;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
 
    [self addSubview:label];
 }
-(void)setBackImageStr:(NSString *)BackImageStr
{
    
    UIImageView *image =[[UIImageView alloc]initWithFrame:self.bounds];
    image.image =[UIImage imageNamed:BackImageStr];
    [self addSubview:image];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
