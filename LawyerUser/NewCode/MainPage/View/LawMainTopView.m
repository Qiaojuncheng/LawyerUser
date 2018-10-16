//
//  LawMainTopView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainTopView.h"
#import "LawNewHeaterModel.h"
@implementation LawMainTopView

 
-(void)makeDataWithScrollLBArray:(NSArray * )titleArray{
 
    _scrollTextView.delegate            = self;
    _scrollTextView.textStayTime        = 2;
    _scrollTextView.scrollAnimationTime = 1;
    _scrollTextView.textColor           = [UIColor colorWithHex:0x2D7FFF];
    _scrollTextView.textFont            = [UIFont boldSystemFontOfSize:13.f];
    _scrollTextView.textAlignment       = NSTextAlignmentLeft;
    _scrollTextView.touchEnable         = YES;
    
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"这是最后一条数据："];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = [UIImage imageNamed:@"icon"];
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:attrStr.length];
    NSMutableArray * titArray =[[NSMutableArray alloc]init];
    for (LawNewHeaterModel * model  in titleArray) {
        [titArray addObject:[NSString stringWithFormat:@"%@律师细心解答，收到心意%@元",model.lawyer_name,model.money]];
    }
    
    _scrollTextView.textDataArr =titArray;
    
    
    [_scrollTextView startScrollBottomToTopWithNoSpace];
}
- (void)scrollTextView2:(LMJScrollTextView2 *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content{
//    if (self.adsselectBlock) {
//        self.adsselectBlock(index);
//    }
//    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
}

-(void)makeItemWithTitleArray:(NSArray *)TitleArray ImageArray:(NSArray *)ImageArray{
    
    for(int i = 0 ; i< TitleArray.count ;i++){
        
        CGFloat ItemWidth = (SCREENWIDTH - 20) /4 ;
        
        
    UIView * ItemView =[[UIView alloc]initWithFrame:CGRectMake(ItemWidth * (i%4)+ 10, floor(i/4) * 80  + 50, ItemWidth, 80)];
        [self addSubview:ItemView];
        UIImageView * ima =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        ima.image =[UIImage imageNamed:ImageArray[i]];
        ima.centerX = ItemView.width/2;
        [ItemView addSubview:ima];
        UILabel * TitleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, ima.bottom+5, ItemWidth, 20)];
        TitleLB.text= TitleArray[i];
        TitleLB.textAlignment  =  NSTextAlignmentCenter;
        TitleLB.textColor = [UIColor colorWithHex:0x555555];
        TitleLB.font =[UIFont systemFontOfSize:14];
         [ItemView addSubview:TitleLB];
        [ItemView whenTapped:^{
            if(self.ItemselectBlock){
                self.ItemselectBlock(30+i);
            }
        }];
     }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
 - (IBAction)TopBtnACtion:(UIButton *)sender {
    
    if(self.ItemselectBlock){
        self.ItemselectBlock(sender.tag);
    }
}
@end
