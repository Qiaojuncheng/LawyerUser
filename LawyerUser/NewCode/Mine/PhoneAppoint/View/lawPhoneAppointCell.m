//
//  lawPhoneAppointCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPhoneAppointCell.h"

@implementation lawPhoneAppointCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    [Utile makecorner:5 view:self.SureBtn color:[UIColor colorWithHex:0x3181FE]];
    [Utile makeCorner:4 view:self.RedView];
    [Utile makeCorner:self.personImageView.height/2 view:self.personImageView];
    // Initialization code
}
-(void)setModel:(lawAppointModel *)model{
    _model = model;
    
  if (model.phone.length > 10){
      model.phone = [model.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

    }
    
    self.ticketImage.hidden = YES;
    self.PriceLB.hidden = YES ;
    [self.personImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];

    self.publicTimeLB.text = model.create_time;
    self.PersonImage.text =[NSString stringWithFormat:@"%@律师",model.name];
//    self.PhoneLB.text  = [NSString stringWithFormat:@"联系电话：%@",model.phone];
  
    self.TypeLB.text = model.cate_name;
    if ([model.type isEqualToString:@"1"]) {
 
    }else{
         self.MeetAddresLB.text = [NSString stringWithFormat:@"预约时间：%@",model.meet_time];
    }
    
    if ([model.pay_type isEqualToString:@"3"]) {
        self.ticketImage.hidden =  NO ;
    }else{
        self.PriceLB.text =[NSString stringWithFormat:@"￥%@",model.money];

        self.PriceLB.hidden = NO ;
    }
    self.PhoneImage.image = [UIImage imageNamed:@"list_phone1"];
    self.SureBtn.hidden = YES ;
    self.RedView.hidden  =  YES;
    self.ServiceLB.textColor = [UIColor colorWithHex:0x3181FE];
//    if([model.status isEqualToString:@"0"]) {// 代付款
//    }else
        if ([model.status isEqualToString:@"1"]||[model.status isEqualToString:@"0"]) { // 待服务
        self.ServiceLB.text = @"待服务";
        self.PhoneImage.image = [UIImage imageNamed:@"list_phone2"];

    }else if([model.status isEqualToString:@"2"]) {// 律师服务中 显示红点
        self.ServiceLB.text = @"律师服务中";
        self.RedView.hidden= NO;
    }else if([model.status isEqualToString:@"3"]) {// 已拒绝
        self.ServiceLB.text = @"律师已拒绝";
        self.PhoneImage.image = [UIImage imageNamed:@"list_phone2"];
        self.ServiceLB.textColor =[UIColor colorWithHex:0x999999];
    }else if([model.status isEqualToString:@"4"]) {//律师完成 显示确认完成按钮 显示红点
        self.RedView.hidden= NO;
        self.ServiceLB.text = @"服务已完成";
        self.SureBtn.hidden = NO ;
    }else if([model.status isEqualToString:@"5"]) { //已完成
        self.ServiceLB.text = @"服务结束";
    }
    
//    if ([model.status integerValue] >  2) {
////         可以打电话
//        self.PhoneImage.userInteractionEnabled = YES ;
//        [self.PhoneImage whenTapped:^{
//            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self->_model.phone];
//            UIWebView * callWebview = [[UIWebView alloc] init];
//            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//            [self addSubview:callWebview];
//
//
//        }];
//    }else{
////         不能打电话
//        self.PhoneImage.userInteractionEnabled = NO  ;
//    }
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SureAction:(id)sender {
    if (self.OverBlock) {
        self.OverBlock();
    }
    
}
@end
