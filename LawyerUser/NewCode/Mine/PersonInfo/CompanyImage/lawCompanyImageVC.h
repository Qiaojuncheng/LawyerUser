//
//  lawCompanyImageVC.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/22.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface lawCompanyImageVC : BaseViewController

 @property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (strong ,nonatomic) NSString * ImageStr;
 - (IBAction)AddImageAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ShiliImage;

- (IBAction)EnSureAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *EnsureBtn;


@end

NS_ASSUME_NONNULL_END
