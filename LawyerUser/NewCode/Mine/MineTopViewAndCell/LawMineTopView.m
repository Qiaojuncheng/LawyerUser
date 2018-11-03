//
//  LawMineTopView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/11.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMineTopView.h"

@implementation LawMineTopView
-(void)setInfoModel:(MyInfoModel *)infoModel{
    
    _infoModel = infoModel;
    [Utile makeCorner:5 view:self.EditBtn ];
    [self.certifi createBordersWithColor:[UIColor colorWithHex:0x3181FE] withCornerRadius:self.certifi.height/2 andWidth:1];
    [Utile makeCorner:self.HeaderImage.height/2 view:self.HeaderImage];
    self.PhoneLb.text =[NSString stringWithFormat:@"%@",_infoModel.name?_infoModel.name:_infoModel.phone];
    if([NSString changeNullString:_infoModel.id].length == 0){
        self.certifi.text  = @"";
        self.certifi.hidden = YES;
        self.EditBtn.hidden = YES ;
        self.LeftConcent.constant = 70;
        self.TopConcent.constant = 30;
        self.PhoneLb.text =[NSString stringWithFormat:@"登录／注册"];
        self.PhoneLb.textColor =[UIColor colorWithHex:0x3181FE];
        [self.PhoneLb whenTapped:^{
            if(self.TouchBtnBlock){
                self.TouchBtnBlock(100);
            }
        }];
    }else{
        self.certifi.hidden = NO;
        self.EditBtn.hidden = NO ;
        self.LeftConcent.constant = 20;
        self.TopConcent.constant = 13;
        self.PhoneLb.textColor =[UIColor colorWithHex:0x333333];
        self.certifi.hidden = YES;

    }
//    if ([_infoModel.renzheng isEqualToString:@"1"]) {
//        self.certifi.text = @"审核中";
//    }
    [self.certifi sizeToFit];
    self.CertifiCon.constant = self.certifi.width + 20;
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,_infoModel.avatar]] placeholderImage:[UIImage imageNamed:@"头像.png"]];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)BtnAction:(UIButton *)sender {
    
//     41 编辑 42 余额  43  券 44 爱心
    if(self.TouchBtnBlock){
        self.TouchBtnBlock(sender.tag);
    }
}
@end
