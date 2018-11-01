//
//  lawDetailTopCell.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lawLawyerDetailModle.h"
@interface lawDetailTopCell : UITableViewCell
@property (strong ,nonatomic )lawLawyerDetailModle * model;
@property (weak, nonatomic) IBOutlet UIImageView *LawImageView;
@property (weak, nonatomic) IBOutlet UILabel *LawName;
@property (weak, nonatomic) IBOutlet UIImageView *TuiImage;
@property (weak, nonatomic) IBOutlet UIButton *CollectBtn;

- (IBAction)collectionActon:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *YearsLB;
@property (weak, nonatomic) IBOutlet UILabel *AdressLB;

@property (weak, nonatomic) IBOutlet UILabel *CompanyLB;
@property (weak, nonatomic) IBOutlet UILabel *NumberLB;

@property (weak, nonatomic) IBOutlet UIView *TypeView;








@end
