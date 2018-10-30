//
//  lawMainPageLawyerCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/15.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawMainPageLawyerCell.h"

@implementation lawMainPageLawyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    for (UIView *  subLb in self.TypeView.subviews) {
        if ([subLb isKindOfClass:[UILabel class]]){
            [subLb removeFromSuperview];
        }
    }
    [Utile makeCorner:5 view:self.LawyerImaegView];
     [Utile makeCorner:4 view:self.TimeLB];
   
    // Initialization code
}
-(void)setModel:(lawLawyerModle *)model{
    _model   = model ;
    
    [self.LawyerImaegView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ImageUrl,model.avatar]] placeholderImage:nil];
    self.lawyerName.text = [NSString stringWithFormat:@"%@律师",model.name];
    self.TimeLB.text = [NSString stringWithFormat:@"执业%@年",model.practice_years];
    self.AddressLB.text = [NSString stringWithFormat:@"%@ | %@",model.city_name,model.company];
    if([model.is_recom isEqualToString:@"0"]){
        self.TuiImage.hidden = YES ;
    }else{
        self.TuiImage.hidden = NO  ;
     }
    
     CGFloat labelleft = 0;
    for (NSString * typeTitle in model.cate_name) {
        
        CGSize labWidth =   [NSString  GetHeightWithMaxSize:CGSizeMake(100, 22) AndFont:[UIFont systemFontOfSize:13] AndText:typeTitle];
        
        UILabel* typeLabel  =[[UILabel alloc]initWithFrame:CGRectMake(labelleft, 0, labWidth.width + 10, 22)];
        typeLabel.font = [UIFont systemFontOfSize:13];
        labelleft += typeLabel.width + 10;
        typeLabel.text  = typeTitle;
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [Utile  makecorner:3 view:typeLabel color:[UIColor colorWithHex:0x999999]];
        [self.TypeView addSubview:typeLabel];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
