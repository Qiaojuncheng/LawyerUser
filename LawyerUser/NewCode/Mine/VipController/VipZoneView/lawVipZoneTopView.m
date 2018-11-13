//
//  lawVipZoneTopView.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/4.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawVipZoneTopView.h"
#import "lawPayViewController.h"
@implementation lawVipZoneTopView

-(void)makeSubviews{
    
//    [Utile makecorner:12 view:self.WhiteView color:[UIColor colorWithHex:0xE5E5E5]];
    [Utile makeCorner:12 view:self.YellView];
    [Utile makeCorner:6 view:self.SmallWhiteView];
    [Utile makeCorner:self.personHeaderImage.height/2 view:self.personHeaderImage];

    self.oneCardBtn.selected = YES;
    self.tempBtn = self.oneCardBtn;
//    [self makecornerwithType:51];
    self.ConcentView.hidden = YES ;
    if(!IsLogin){
        self.NameLB.text = @"未登录";
    }else{
        self.NameLB.text = [UD objectForKey:@"name"]?[UD objectForKey:@"name"]:[UD objectForKey:@"phone"];
        [self.personHeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,[UD objectForKey:@"avatar"]]] placeholderImage:nil];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"is_vip"] isEqualToString:@"1"]) {
            self.MessageLB.text=  [NSString stringWithFormat:@"您的企业VIP到期时间为%@",[NSString timeWithTimeIntervalString:[UD objectForKey:@"end_time"]]];
            
        }

    }
    
}
#pragma mark  购买套餐
- (IBAction)BuyVipAction:(UIButton *)sender {
    
    lawVipConcentModel * model  = self.DataArray[_tempBtn.tag - 51];
    lawPayViewController * lawrevc  = [[lawPayViewController alloc] initWithNibName:@"lawPayViewController" bundle:nil];
    lawrevc.Type = @"3";
    lawrevc.Pricestr= model.price;
    lawrevc.VIPNameStr =model.name;
    [[self belongViewController].navigationController pushViewController:lawrevc animated:YES];

}
//部分圆角显示
-(void)makecornerwithType:(NSInteger)index{
     UIBezierPath *maskPath;
      if (index ==51 ) {
        maskPath= [UIBezierPath bezierPathWithRoundedRect:self.WhiteView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight |UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];

    }else if (index == 54){
        maskPath= [UIBezierPath bezierPathWithRoundedRect:self.WhiteView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight |UIRectCornerTopLeft cornerRadii:CGSizeMake(5,5)];

    }else{
        maskPath= [UIBezierPath bezierPathWithRoundedRect:self.WhiteView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5,5)];

    }
     CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = CGRectMake(0, 0, self.WhiteView.width, self.WhiteViewHeight.constant);
    maskLayer.lineWidth  =1;
    maskLayer.borderColor = [UIColor colorWithHex:0xE5E5E5].CGColor;
    maskLayer.path = maskPath.CGPath;
     self.WhiteView.layer.mask = maskLayer;
    
}
//数组赋值
-(void)setDataArray:(NSArray *)DataArray{
    _DataArray = DataArray ;
    if (DataArray.count > 0) {
        [self makeListViewWithmodel:DataArray[0]];
//        [self makecornerwithType:51];

    }
}

//z显示 内容
-(void)makeListViewWithmodel:(lawVipConcentModel *)model {
    
    if ([model.num integerValue] > 0) {
        self.KaitongNumberLB.text  =[NSString stringWithFormat:@"（%@家企业已开通）",model.num];
    }else{
        self.KaitongNumberLB.text =@"";
    }
    
    [self.ConcentView removeAllSubviews];
    self.ConcentView.hidden = NO ;
    self.PriceLB.text = model.price;
    for (int i  = 0 ; i< model.content.count; i++) {
        UIImageView * ima =[[UIImageView alloc]initWithFrame:CGRectMake(17 ,3 + 20*i, 12, 14)];
        ima.image =[UIImage imageNamed:@"service_gou"];
        [self.ConcentView addSubview:ima];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(35,20 * i,SCREENWIDTH - 100,20);
        label.text = [NSString stringWithFormat:@"%@",model.content[i]];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
        label.textColor = [UIColor colorWithHex:0x333333];
        [self.ConcentView addSubview:label];
        
    }
    if(self.changHeightBlock){
        self.changHeightBlock(335+model.content.count*20);
        self.WhiteViewHeight.constant = 176 + model.content.count*20;
        [self setNeedsLayout];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//x选择卡
- (IBAction)CarBtnAction:(UIButton *)sender {
    
    if (self.tempBtn != sender) {
        sender.selected = YES ;
        self.tempBtn.selected = NO ;
        self.tempBtn = sender ;
        if (sender.tag == 51) {
            NSLog(@"银卡");
        }else if (sender.tag == 52){
            NSLog(@"金卡");
        }else if(sender.tag == 53){
            NSLog(@"白金卡");
        }else if(sender.tag == 54){
            NSLog(@"钻石卡");
            
        }
        NSInteger index = sender.tag - 51;
        [self makeListViewWithmodel:self.DataArray[index]];
        [self makecornerwithType:sender.tag];


    }
}
- (IBAction)MoreBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.ConcentView.hidden = YES ;
        self.WhiteViewHeight.constant = 176 ;

        if(self.changHeightBlock){
            self.changHeightBlock(335);

        }

    }else{
        lawVipConcentModel * modle = self.DataArray[self.tempBtn.tag - 51];
        self.WhiteViewHeight.constant = 176 + modle.content.count*20;

        if(self.changHeightBlock){
            self.changHeightBlock(335 + modle.content.count*20);
        }
        self.ConcentView.hidden = NO   ;

    }

    
}
@end
