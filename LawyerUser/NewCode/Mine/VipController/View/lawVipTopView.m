//
//  lawVipTopView.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/2.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipTopView.h"

@implementation lawVipTopView

-(void)initSubview{
    self.VipTypeBtn.userInteractionEnabled = NO ;
    [Utile makeCorner:self.HeaderImageView.height/2 view:self.HeaderImageView];
    [Utile makecorner:self.OneBtn.height/2 view:self.OneBtn color:[UIColor colorWithHex:0xFFEAC1]];
    [Utile makecorner:self.TwoBtn.height/2 view:self.TwoBtn color:[UIColor colorWithHex:0xffffff]];
    
}
-(void)setModel:(MyInfoModel *)Model{
    _Model = Model;
   

    self.HeaderNameLB.text = Model.name?Model.name:@"";
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,Model.avatar]] placeholderImage:nil];
    self.OneTimeLB.text=  [NSString stringWithFormat:@"您的企业VIP到期时间%@",[NSString timeWithTimeIntervalString:Model.end_time]];
    self.TwoTimeLB.text=  [NSString stringWithFormat:@"将于 %@ 到期",[NSString timeWithTimeIntervalString:Model.end_time]];
    [self.VipTypeBtn setTitle:Model.vip_name forState:UIControlStateNormal];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)BtnAction:(UIButton *)sender {
    
    NSLog(@"%@ ",self.HeaderImageView);

    
    if (sender.tag == 41) {
        NSLog(@"升级");
    }else{
        NSLog(@"续费");
    }
    
}
@end
