//
//  QJMyConsultModel.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJMyConsultModel.h"

@implementation QJMyConsultModel





-(void)makeHeight{
    
//   self.showMessage =[NSString stringWithFormat:@"问题:%@\n\n回复:%@",self.content,self.huifu];
    
    self.showMessage =[NSString stringWithFormat:@"当事人信息:%@",self.title];

     CGSize  size = CGSizeMake(ConentViewWidth - 16, 1000);
    UIFont  * font = [UIFont systemFontOfSize:15];
      NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [self.showMessage boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    

    self.Height = rect.size.height +  85;
}
@end
