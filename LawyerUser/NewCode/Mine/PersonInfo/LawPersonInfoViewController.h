//
//  LawPersonInfoViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "MyInfoModel.h"
@interface LawPersonInfoViewController : BaseViewController
@property(nonatomic,strong) MyInfoModel *infoModel;
@property(nonatomic,strong) NSString *mid;

@end
