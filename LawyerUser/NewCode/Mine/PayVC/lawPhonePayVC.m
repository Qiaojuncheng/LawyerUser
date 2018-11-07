//
//  lawPhonePayVC.m
//  Lawyer
//
//  Created by MYMAc on 2018/11/7.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "lawPhonePayVC.h"

@interface lawPhonePayVC (){
    NSArray * BtnArary ;

}
@end

@implementation lawPhonePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"电话咨询服务费" titleColor:nil];
    self.PriceTextField.text = [NSString stringWithFormat:@"￥%@",self.Pricestr];
    BtnArary =@[self.WXpayBtn,self.AirPayBtn,self.YeBtn];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)PayBtnAction:(UIButton *)sender {
    for (UIButton * tempBtn in BtnArary) {
        tempBtn.selected = NO ;
    }
    sender.selected = YES ;
    
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
