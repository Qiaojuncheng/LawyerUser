//
//  QJEspenseCell.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJXiaoFeiModel.h"
@interface QJEspenseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BigImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLB;
@property (weak, nonatomic) IBOutlet UILabel *DesLB;
@property (weak, nonatomic) IBOutlet UILabel *DateLB;

@property (strong ,nonatomic) QJXiaoFeiModel * model;

@end
