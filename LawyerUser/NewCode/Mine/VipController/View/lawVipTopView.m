//
//  lawVipTopView.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/2.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipTopView.h"
#import "lawVipZoneVC.h"
#import "lawPayViewController.h"
@implementation lawVipTopView

-(void)initSubview{
    self.VipTypeBtn.userInteractionEnabled = NO ;
    [Utile makeCorner:self.HeaderImageView.height/2 view:self.HeaderImageView];
    [Utile makecorner:self.OneBtn.height/2 view:self.OneBtn color:[UIColor colorWithHex:0xFFEAC1]];
    [Utile makecorner:self.TwoBtn.height/2 view:self.TwoBtn color:[UIColor colorWithHex:0xffffff]];
    
}
-(void)setModel:(MyInfoModel *)Model{
    _Model = Model;
   

    self.HeaderNameLB.text = [UD objectForKey:@"name"] ?[UD objectForKey:@"name"]:@"";
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,[UD objectForKey:@"avatar"]]] placeholderImage:nil];
    self.OneTimeLB.text=  [NSString stringWithFormat:@"您的企业VIP到期时间为%@",[NSString timeWithTimeIntervalString:[UD objectForKey:@"end_time"]]];
    self.TwoTimeLB.text=  [NSString stringWithFormat:@"将于 %@ 到期",[NSString timeWithTimeIntervalString:[UD objectForKey:@"end_time"]]];
    [self.VipTypeBtn setTitle:[UD objectForKey:@"vip_name"] forState:UIControlStateNormal];

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
        lawVipZoneVC * VIPzoneVC =[[lawVipZoneVC alloc]init];
        
        [[self belongViewController].navigationController pushViewController:VIPzoneVC animated:YES];
    }else{
        
        lawPayViewController * lawrevc  = [[lawPayViewController alloc] initWithNibName:@"lawPayViewController" bundle:nil];
        lawrevc.Type = @"3";
        lawrevc.Pricestr= self.VipPriceStr;
        lawrevc.VIPNameStr =[UD objectForKey:@"vip_name"];
        [[self belongViewController].navigationController pushViewController:lawrevc animated:YES];

        NSLog(@"续费");
    }
    
}

- (IBAction)BackVC:(id)sender {
    [self.belongViewController.navigationController popViewControllerAnimated:YES];
}
@end
