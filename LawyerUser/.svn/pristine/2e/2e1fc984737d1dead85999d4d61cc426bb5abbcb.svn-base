//
//  QJNeedCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNeedCell.h"

@implementation QJNeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.Btn createBordersWithColor:MAINCOLOR withCornerRadius:4 andWidth:.5];
    // Initialization code
}
-(void)setModle:(QJNeedModel *)modle{
    _modle = modle;
     self.DingDanID.text  =[NSString stringWithFormat:@"订单号:%@",[NSString changeNullString:modle.order_sn]];
     if([NSString changeNullString:modle.lawyer_name].length > 0){
       self.NameLB.text  =[NSString stringWithFormat:@"受理律师:%@",[NSString changeNullString:modle.lawyer_name]];
    }else{
        self.NameLB.text  =[NSString stringWithFormat:@"受理律师:暂无受理律师"];
    }
    self.TypeLB.text = [NSString stringWithFormat:@"服务类型:%@",[NSString changeNullString:modle.type_name]];
    if ([modle.status isEqualToString:@"1"]) {
        self.FBTimeLB.text = [NSString stringWithFormat:@"发布时间:%@",[NSString timeWithTimeIntervalString:modle.create_time]];
        self.TJTimeLB.text =  [NSString stringWithFormat:@"交付时间:%@",[NSString timeWithTimeIntervalString:modle.time]];
        self.PriceLB.text =   [NSString stringWithFormat:@"服务报价:￥%@",[NSString changeNullString:modle.offer]];
    }else{
        self.FBTimeLB.text = [NSString stringWithFormat:@"发布时间:%@",[NSString timeWithTimeIntervalString:modle.create_time]];
        self.TJTimeLB.text =  [NSString stringWithFormat:@"交付时间:%@",[NSString timeWithTimeIntervalString:modle.finish_time]];
        self.PriceLB.text =   [NSString stringWithFormat:@"服务报价:￥%@",[NSString changeNullString:modle.price]];

    }
    //    "status": "1", // 1：显示律师列表 3 律师已聘用 4：待评价 5：已完成
    self.Btn.userInteractionEnabled = YES;
    self.BtnWidth.constant = 79;
    if ([modle.status isEqualToString:@"1"]) {
        [self.Btn setTitle:@"律师列表" forState:UIControlStateNormal];
        
 
    }else if ([modle.status isEqualToString:@"3"]){
        [self.Btn setTitle:@"律师已聘用" forState:UIControlStateNormal];
        self.Btn.userInteractionEnabled = NO;

        self. BtnWidth.constant = 89;
    }else if ([modle.status isEqualToString:@"4"]){
        [self.Btn setTitle:@"去评价" forState:UIControlStateNormal];
    }else if ([modle.status isEqualToString:@"5"]){
        [self.Btn setTitle:@"服务结束" forState:UIControlStateNormal];
        self.Btn.userInteractionEnabled = NO;

    }

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SelectBtn:(id)sender {
    if ([_modle.status isEqualToString:@"1"]) {
        self.SeleBlock(NO);
   
    }else if ([_modle.status isEqualToString:@"4"]){
        self.SeleBlock(YES);

    }
}
@end
