//
//  QJMyConsultDetail.m
//  Lawyer
//
//  Created by MYMAc on 2017/10/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMyConsultDetail.h"

@interface QJMyConsultDetail ()

@end

@implementation QJMyConsultDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"咨询详情";
    [self makeWithModel];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeWithModel{
    self.NoReplyLB.hidden = YES;
    
    [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,_model.avatar]]  placeholderImage:[UIImage imageNamed:@"头像.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.view.backgroundColor = MainBackColor;
    self.TypeLB.text= [NSString stringWithFormat:@"类型:%@",_model.category_name];
    self.QuestLB.text =[NSString stringWithFormat:@"%@",_model.content];
    self.TImeLB.text =[NSString stringWithFormat:@"%@",[NSString timeWithTimeIntervalString:_model.create_time]];
    CGSize  size = CGSizeMake(ConentViewWidth - 24, 1000);
    UIFont  * font = [UIFont systemFontOfSize:13];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [_model.content boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    
    
    self.QuestHeight.constant = rect.size.height + 8 ;
    
    
    
    self.ReplyLB.text =[NSString stringWithFormat:@"%@",_model.huifu];
    
    CGSize  sizes = CGSizeMake(ConentViewWidth - 76, 1000);
    NSDictionary *attributess = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rects = [_model.huifu boundingRectWithSize:sizes
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributess
                                             context:nil];
    
    self.ReplyViewHeight.constant  = rects.size.height +  47;
    self.BackViewHeight.constant = self.replyView.bottom;
    if([_model.status isEqualToString:@"2"]||[_model.status isEqualToString:@"4"]){
        self.NoReplyLB.hidden = YES;
        self.replyView.hidden = NO;
        self.HuifuName.text =[NSString stringWithFormat:@"%@ 律师回复：",_model.lawyer_name];
        self.ReplyViewHeight.constant  = rects.size.height +  37;
    
        self.BackViewHeight.constant = rects.size.height +  67  + self.replyView.top ;
    }else if([_model.status isEqualToString:@"1"]){
        
        self.NoReplyLB.hidden = NO;
        self.replyView.hidden = YES;
        self.NoReplyLB.text = @"暂无回复";
        
        self.BackViewHeight.constant = self.QuestLB.bottom + 50;
    }else if([_model.status isEqualToString:@"4"]){
        
        self.NoReplyLB.hidden = NO;
        self.replyView.hidden = YES;
        self.NoReplyLB.text = @"服务结束";
        
        self.BackViewHeight.constant = self.QuestLB.bottom + 50;
    }else if ([_model.status isEqualToString:@"3"]){
    
        self.NoReplyLB.hidden = NO;
        self.NoReplyLB.text = @"已过期";
        self.replyView.hidden = YES;
        self.BackViewHeight.constant = self.QuestLB.bottom + 50;
    }
    
    

}
-(void)setModel:(QJMyConsultModel *)model{
    _model = model;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
