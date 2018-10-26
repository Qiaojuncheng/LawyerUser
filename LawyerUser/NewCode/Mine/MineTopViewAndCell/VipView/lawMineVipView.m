//
//  lawMineVipView.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/22.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMineVipView.h"

@implementation lawMineVipView

-(void)setTimeStr:(NSString *)timeStr{
    _timeStr  = timeStr ;
    
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(16,15,133,14);
        label.text = @"企业VIP会员中心";
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self   addSubview:label];
        
        
        UILabel *Timelabel = [[UILabel alloc] init];
        Timelabel.frame = CGRectMake(16,15,148,14);
        Timelabel.text = [NSString stringWithFormat:@"您的企业VIP到期时间%@",timeStr];
        Timelabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        Timelabel.textColor = [UIColor colorWithRed:219/255.0 green:176/255.0 blue:114/255.0 alpha:1];
        [self addSubview:Timelabel];
        
        //
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(SCREENWIDTH - 24,17,7,9.5);
       imageView.image = [UIImage imageNamed:@"list_arrow"];
        [self addSubview:imageView];
        CGSize  labelSize = [NSString GetHeightWithMaxSize:CGSizeMake(200, 15) AndFont:[UIFont systemFontOfSize:10] AndText:Timelabel.text];
        Timelabel.left = SCREENWIDTH - 30 - labelSize.width ;
                          
        UIImageView *VipimageView = [[UIImageView alloc] init];
        VipimageView.frame = CGRectMake(Timelabel.left - 14,16,10,10);
        VipimageView.image = [UIImage imageNamed:@"icon_vip.png"];
        [self addSubview:VipimageView];
                          
 }

-(void)setVipType:(NSString *)VipType{
    
    
    UIImageView * Backview = [[UIImageView alloc] init];
    Backview.frame =self.bounds;
    Backview.image =[UIImage imageNamed:@"bg_vip1"];
     Backview.layer.cornerRadius = 5;
    [self addSubview:Backview];
    
    UIImageView *LeftImageView = [[UIImageView alloc] init];
    LeftImageView.frame = CGRectMake(12.1,6,59,16);
    LeftImageView.image = [UIImage imageNamed:@"label_vip"];
    [self addSubview:LeftImageView];
    
   
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(24,38,170,16);
    label.text = @"汇融法·企业VIP会员";
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self addSubview:label];
    
    
    
    UILabel *labeldes = [[UILabel alloc] init];
    labeldes.frame = CGRectMake(24,63,127,12);
    labeldes.text = @"办卡福利，新人特享";
    labeldes.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    labeldes.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    [self addSubview:labeldes];
    
    
    UILabel *Looklabel = [[UILabel alloc] init];
    Looklabel.frame = CGRectMake(SCREENWIDTH - 122,42,84,28);
    Looklabel.text = @"立即查看";
    Looklabel.textAlignment = NSTextAlignmentCenter;
    [Utile makecorner:4 view:Looklabel color:[UIColor colorWithHex:0x757575]];
    Looklabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    Looklabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self addSubview:Looklabel];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
