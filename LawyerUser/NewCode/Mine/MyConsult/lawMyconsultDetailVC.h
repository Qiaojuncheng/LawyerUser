//
//  lawMyconsultDetailVC.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/6.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"
#import "lawMyconsultListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface lawMyconsultDetailVC : BaseViewController
@property (strong , nonatomic) NSString  *ConstulId ;
@property (strong , nonatomic) NSString  *mid ;

@property (strong , nonatomic) lawMyconsultListModel *model ;

@end

NS_ASSUME_NONNULL_END
