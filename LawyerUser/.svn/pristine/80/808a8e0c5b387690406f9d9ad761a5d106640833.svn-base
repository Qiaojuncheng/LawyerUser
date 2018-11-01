//
//  QJMineTopView.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMineTopView.h"

@implementation QJMineTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)makeUI{

    [self.OneTip setCornerRadius:7];
    [self.TwoTip setCornerRadius:7];
    [self.ThreeTip setCornerRadius:7];
    self.chongzhiBtn.layer.masksToBounds = YES;
    self.chongzhiBtn.layer.cornerRadius = 5;
//    self.chongzhiBtn.layer.borderWidth = 1;
    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
//    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
//    // 设置边框颜色
    self.chongzhiBtn.layer.borderColor = MAINCOLOR.CGColor;
    self.tixanBtn.layer.masksToBounds = YES;
    self.tixanBtn.layer.cornerRadius = 5;
    self.tixanBtn.layer.borderWidth = 1;
    self.tixanBtn.layer.borderColor = MAINCOLOR.CGColor;

    self.TopImageView.layer.masksToBounds = YES;
    self.TopImageView.layer.cornerRadius =30;
    
}
-(void)makeWithModel:(QJPersonModel *)modle{

    [self.TopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,modle.avatar]]  placeholderImage:[UIImage imageNamed:@"头像.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    self.NameLabel.text = modle.name;
    
    self.Account.text= [NSString stringWithFormat:@"账户余额: %@",[NSString changeNullString:modle.money]];
    
    [self makeTishi];



}


- (IBAction)TopTouchAction:(UIButton *)sender {
     self.Block(sender);
 }
-(void)makeTishi{
    NSUserDefaults * userde =[NSUserDefaults standardUserDefaults];
//我的咨询
    NSString * MyCounsment  =  [userde objectForKey:@"MyCounsment"];
    if ( [MyCounsment isEqualToString:@"yes"]) {// 我的咨询
        self.OneTip.hidden = NO;
//        显示
    }else{
        self.OneTip.hidden = YES;

//         隐藏
     }
    
//    我的 预约
    NSString * MyAppoinment  =  [userde objectForKey:@"MyAppoinment"];
    if ( [MyAppoinment isEqualToString:@"yes"]) {// 我的咨询
        self.TwoTip.hidden = NO;
        //        显示
    }else{
        self.TwoTip.hidden = YES;
        
        //         隐藏
    }
    
//    我的需求
    NSString * MyNeeds  =  [userde objectForKey:@"MyNeeds"];
    if ( [MyNeeds isEqualToString:@"yes"]) {// 我的咨询
        self.ThreeTip.hidden = NO;
        //        显示
    }else{
        self.ThreeTip.hidden = YES;
        
        //         隐藏
    }
 
    
    
}

- (IBAction)TopImageACtion:(UIButton *)sender {
    self.TapTopBlock();
}
@end
