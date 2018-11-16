//
//  lawDetailTopCell.m
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawDetailTopCell.h"

@implementation lawDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:5 view:self.LawImageView];
    // Initialization code
}
-(void)setModel:(lawLawyerDetailModle *)model{
    _model = model;
    
    [self.LawImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,_model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.LawName.text = [NSString stringWithFormat:@"%@律师",_model.name];
    self.YearsLB.text = [NSString stringWithFormat:@"%@年",_model.practice_years];
    self.AdressLB.text = [NSString stringWithFormat:@"%@ %@",_model.city_name,_model.area_name];
    self.CompanyLB.text = [NSString stringWithFormat:@"%@",_model.company];
    self.NumberLB.text = [NSString stringWithFormat:@"%@单",_model.order_num];
    CGFloat labelleft = 0;
    for (NSString * typeTitle in model.cate_name) {
        
        CGSize labWidth =   [NSString  GetHeightWithMaxSize:CGSizeMake(100, 22) AndFont:[UIFont systemFontOfSize:13] AndText:typeTitle];
        
        UILabel* typeLabel  =[[UILabel alloc]initWithFrame:CGRectMake(labelleft, 0, labWidth.width + 10, 22)];
        typeLabel.font = [UIFont systemFontOfSize:13];
        labelleft += typeLabel.width + 10;
        typeLabel.text  = typeTitle;
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.textColor =[UIColor colorWithHex:0x999999];
        [Utile  makecorner:3 view:typeLabel color:[UIColor colorWithHex:0x999999]];
        [self.TypeView addSubview:typeLabel];
    }

     if ([_model.is_keep isEqualToString:@"1"]) {
//        未关注
        self.CollectBtn.selected = NO;
         [self.CollectBtn createBordersWithColor:MAINCOLOR withCornerRadius:12 andWidth:1];
         
    }else{
//     已关注
        self.CollectBtn.selected = YES ;
        [self.CollectBtn createBordersWithColor:[UIColor colorWithHex:0x999999] withCornerRadius:12 andWidth:1];

    }
    if ([_model.is_recom isEqualToString:@"0"]) {
        self.TuiImage.hidden = YES ;
    }else{
        self.TuiImage.hidden = NO ;
    }
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)collectionActon:(UIButton *)sender {
    
    
    if (IsLogin) {
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        NewCaseNewscollect
        NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
 
        [valuedic setValue:UserId forKey:@"id"];
        [valuedic setValue:@"2" forKey:@"type"];
        [valuedic setValue:@"1" forKey:@"role"];
        [valuedic setValue:_model.id forKey:@"tid"];
        
        NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
        __weak typeof(self.CollectBtn)  weakConsultBtn = self.CollectBtn;
        [AFManagerHelp POST:MainUrl parameters:dic success:^(id responseObjeck) {
             // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
                
                weakConsultBtn.selected = !weakConsultBtn.selected;
                if (weakConsultBtn.selected) {
                    [weakConsultBtn createBordersWithColor:[UIColor colorWithHex:0x999999] withCornerRadius:12 andWidth:1];
                }else{
                    [weakConsultBtn createBordersWithColor:MAINCOLOR withCornerRadius:12 andWidth:1];
                }
            }
 
        } failure:^(NSError *error) {
 
        }];
        
    }else{
        
        LawLogionViewController *view = [LawLogionViewController new];
        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
        [UIApplication sharedApplication].delegate.window.rootViewController = na;
    }
    

}
@end
