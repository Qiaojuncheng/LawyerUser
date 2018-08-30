//
//  QJScrollItemView.m
//  Lawyer
//
//  Created by MYMAc on 2017/8/4.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJScrollItemView.h"
#import "QJNewCataModel.h"

@implementation QJScrollItemView{
    CGFloat SpaceofButton;// button 之间的间距
    UIButton * signButton;// 选中的button
    
    UIView *blueView;//滑块

}


-(instancetype)initWithFrame:(CGRect)frame{
  self =  [super initWithFrame:frame];
    
    return self;
}

-(void)setIteamArray:(NSMutableArray *)IteamArray{

    _IteamArray =[[NSMutableArray alloc]initWithArray:IteamArray];
    
    
    blueView = [[UIView alloc]init];
    blueView.backgroundColor = MAINCOLOR;
     //MAINCOLOR;
    [self addSubview:blueView];
     SpaceofButton = 20;
    CGFloat beginX = 20; //  每个button的起始 x 值  button 之间相差 20  px
    for (int i = 0; i <_IteamArray.count; i ++) {
        
        QJNewCataModel * model =_IteamArray[i];
        NSString  * typeStr = model.cate_name;

        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGFloat Width =   [typeStr boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(beginX , 5, Width, 40);
        beginX += (SpaceofButton+Width);
        
        
        [button setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        [button setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@"%@",typeStr] forState:UIControlStateNormal];
        button.tag = 10 +i;
        button.titleLabel.font =[UIFont systemFontOfSize:17];
        
        [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            button.selected = YES;
            signButton = button;
            
            blueView.frame = CGRectMake(20, 46, Width, 2);
        }
    }
    self.contentOffset = CGPointMake(0, 0);
    self.contentSize = CGSizeMake(beginX, 0);






}
-(void)categoryButtonClick:(UIButton *)sender{

//    [signButton setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
    signButton.selected = NO;
    sender.selected = YES;
    signButton = sender;
 
    blueView.frame = CGRectMake(CGRectGetMaxX(signButton.frame) -signButton.frame.size.width , 46,signButton.frame.size.width , 2);

    if([self.delegate respondsToSelector:@selector(QJScrollItemViewseleIndex:)]){
    
        [self.delegate QJScrollItemViewseleIndex:sender.tag-10];
    
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
