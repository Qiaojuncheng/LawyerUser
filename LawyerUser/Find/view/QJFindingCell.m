//
//  QJFindingCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/14.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJFindingCell.h"

@implementation QJFindingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HeaderImage.layer.masksToBounds = YES;
    self.HeaderImage.layer.cornerRadius = 40;
    
     _StarView = [[RatingBar alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 33, 100, 25)];
    _StarView.centerY  = self.FenLB.centerY -1;
    _StarView.enable = NO;
    _StarView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_StarView];
    [self.businessYearsLB createBordersWithColor:MAINCOLOR withCornerRadius:3 andWidth:1];
    

     // Initialization code
}

-(void)setModel:(QJLawyer *)model{
 
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,model.thumb]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.NameLB.text = [NSString stringWithFormat:@"%@ 律师",model.name];
    [Utile setUILabel:self.NameLB data:[NSString stringWithFormat:@"%@ ",model.name] setData:@"律师" color:TintColor font:14 underLine:NO];
    self.CompanerLB.text =[NSString stringWithFormat:@"%@",model.company];
    
    self.AdressLB.text =[NSString stringWithFormat:@"%@ %@ %@",model.province_name,model.city_name,model.area_name];
    self.AdressLB.text = [self.AdressLB.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    
    self.businessYearsLB.text =[NSString stringWithFormat:@" 执业%@年 ",model.work_time];
    

    
    if ([model.lawyer_level_id intValue] > 3) {
        self.FenLB.text = [NSString stringWithFormat:@"%@ 好评",model.lawyer_level_id];
        [Utile setUILabel:self.FenLB data:[NSString stringWithFormat:@"%@ ",model.lawyer_level_id] setData:@"好评" color:TintColor font:14 underLine:NO];

    }else if([model.lawyer_level_id intValue] == 3){
        self.FenLB.text = [NSString stringWithFormat:@"%@ 中评",model.lawyer_level_id];
        [Utile setUILabel:self.FenLB data:[NSString stringWithFormat:@"%@ ",model.lawyer_level_id] setData:@"中评" color:TintColor font:14 underLine:NO];
    }else{
        self.FenLB.text = [NSString stringWithFormat:@"%@ 差评",model.lawyer_level_id];
        [Utile setUILabel:self.FenLB data:[NSString stringWithFormat:@"%@ ",model.lawyer_level_id] setData:@"差评" color:TintColor font:14 underLine:NO];
    }
    
    self.StarView.starNumber = [model.lawyer_level_id integerValue];
    
    
    

    float b = 0;
    for (int a= 0; a < model.cate_name.count;  a ++ ) {
        UILabel *laes = [[UILabel alloc]init];
        laes.text = [NSString stringWithFormat:@"%@",model.cate_name[a]];
        laes.font = [UIFont systemFontOfSize:12];
        CGRect labelOne = [laes boundingRectWithInitSize:laes.frame.size];
        
        laes.frame  = CGRectMake(b , 0, labelOne.size.width+ 15, 18);
        b  += labelOne.size.width + 20;
        laes.textColor = [UIColor whiteColor];
        laes.textAlignment = NSTextAlignmentCenter;
        laes.layer.masksToBounds = YES;
        laes.layer.cornerRadius = 8;
        laes.backgroundColor = MAINCOLOR;
        [self.labelsView addSubview:laes];
    }

    if (b> self.labelsView.width){
        self.labelsView.contentSize = CGSizeMake(b, self.labelsView.height);
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
