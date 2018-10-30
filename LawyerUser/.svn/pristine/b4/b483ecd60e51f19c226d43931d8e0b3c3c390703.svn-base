//
//  QJMineTopView.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJPersonModel.h"
@interface QJMineTopView : UIView{


}



- (IBAction)TopImageACtion:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *TopImageView;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *Account;

typedef void(^Btnaction)(UIButton *btntag);

typedef void (^TaptopViewBlocks)() ;

@property (nonatomic,copy)Btnaction Block;
@property (nonatomic,copy)TaptopViewBlocks TapTopBlock;
@property (weak, nonatomic) IBOutlet UIButton *tixanBtn;
@property (weak, nonatomic) IBOutlet UIButton *chongzhiBtn;

@property (weak, nonatomic) IBOutlet UILabel *OneTip;
@property (weak, nonatomic) IBOutlet UILabel *TwoTip;
@property (weak, nonatomic) IBOutlet UILabel *ThreeTip;



-(void)makeUI;
-(void)makeWithModel:(QJPersonModel *)modle;
- (IBAction)TopTouchAction:(UIButton *)sender;
-(void)makeTishi;


@end
