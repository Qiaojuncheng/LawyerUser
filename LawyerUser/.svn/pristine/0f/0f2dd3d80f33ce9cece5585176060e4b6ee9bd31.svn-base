//
//  QJMainPageMiddleView.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/19.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMainPageMiddleView.h"
#import "Masonry.h"
#import "UIViewAdditions.h"

@implementation QJMainPageMiddleView


-(void)awakeFromNib{

    [super awakeFromNib];
  
    
    
}
-(void)MakeMiddleViewUI{


    __weak typeof(self) weakSelf = self;
    [self.LeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(-ConentViewWidth/2);
        make.leading.equalTo(weakSelf.mas_leading).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
    }];
    
    [self.FirstView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(weakSelf.mas_right).with.offset(-ConentViewWidth/4 );
         make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ConentViewWidth/4 -1,self.height/2));
     }];
    

    [self.SecondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ConentViewWidth/4 -1,self.height/2));
    }];
    [self.ThirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-ConentViewWidth/4 );
        make.top.equalTo(weakSelf.mas_top).with.offset(self.height/2+1);
        make.size.mas_equalTo(CGSizeMake(ConentViewWidth/4 -1,self.height/2 -1));
    }];
    [self.LastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(self.height/2 +1);
        make.size.mas_equalTo(CGSizeMake(ConentViewWidth/4 -1,self.height/2 -1));
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
