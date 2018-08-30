//
//  QJNeedReplyTableViewCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNeedReplyTableViewCell.h"

@implementation QJNeedReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.OneLB setCornerRadius:3];
    [self.TwoLB setCornerRadius:3];
    [self.ThreeLB setCornerRadius:3];
    [self.XiangqingLB setCornerRadius:4];
    [self.RenZhengLB setCornerRadius:3];
    [Utile makeCorner:40 view:self.HeaderImageView];
    
    
    self.XiangqingLB.layer.masksToBounds = YES;
    self.XiangqingLB.layer.cornerRadius = 8;
    self.XiangqingLB.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 13/255.0, 122/255.0, 189/255.0, 1 });
    
    self.XiangqingLB.layer.borderColor =borderColorRef;
    self.XiangqingLB.hidden = YES;

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(QJGuanZhuModel *)model{


     [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:[UIImage imageNamed:@"头像.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         
     }];
    self.nameLB.text = [NSString stringWithFormat:@"%@ | 律师",model.name];
    
    self.OneWidth.constant = 0;
    self.TwoWidth.constant = 0;
    self.ThreeWidth.constant = 0;

    if(model.cate_name.count == 0) {

    }else if (model.cate_name.count > 0) {
       
        self.OneLB.text = model.cate_name[0];
        self.OneWidth.constant = [NSString GetHeightWithMaxSize:CGSizeMake(100, 15) AndFont:self.OneLB.font AndText:self.OneLB.text].width + 6;
        
        
      }else if (model.cate_name.count >1) {
          self.TwoLB.text = model.cate_name[1];
          self.TwoWidth.constant = [NSString GetHeightWithMaxSize:CGSizeMake(100, 15) AndFont:self.TwoLB.font AndText:self.TwoLB.text].width + 6;
     }else {
         self.ThreeLB.text = model.cate_name[2];
         self.ThreeWidth.constant = [NSString GetHeightWithMaxSize:CGSizeMake(100, 15) AndFont:self.ThreeLB.font AndText:self.ThreeLB.text].width + 6;
    }
    self.HuiDa.text = [NSString stringWithFormat:@"%@ 个回答",model.zixunCount];
    self.HuiFuWidth.constant = [NSString GetHeightWithMaxSize:CGSizeMake(100, 15) AndFont:self.HuiDa.font AndText:self.HuiDa.text].width + 6;
 
    self.GuanZhuLB.text = [NSString stringWithFormat:@"%@ 个关注",model.keepCount];
    self.GuanZhuWidth.constant = [NSString GetHeightWithMaxSize:CGSizeMake(100, 15) AndFont:self.GuanZhuLB.font AndText:self.GuanZhuLB.text].width + 6;
    
    
}






@end
