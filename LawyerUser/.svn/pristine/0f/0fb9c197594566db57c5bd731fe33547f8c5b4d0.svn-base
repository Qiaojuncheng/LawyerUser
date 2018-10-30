//
//  QJNeedCell.h
//  Lawyer
//
//  Created by MYMAc on 2017/9/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJNeedModel.h"


@interface QJNeedCell : UITableViewCell

typedef void (^Block)(BOOL Pingjia);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BtnWidth;


@property (weak, nonatomic) IBOutlet UILabel *PriceLB;

@property (weak, nonatomic) IBOutlet UILabel *TJTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *FBTimeLB;

@property (weak, nonatomic) IBOutlet UILabel *DingDanID;

@property (weak, nonatomic) IBOutlet UILabel *NameLB;

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;

@property (weak, nonatomic) IBOutlet UIButton *Btn;

@property (strong, nonatomic) QJNeedModel * modle;

@property (strong ,nonatomic) Block SeleBlock;
- (IBAction)SelectBtn:(id)sender;

@end
