//
//  QJChangPersonInfoViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/13.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJChangPersonInfoViewController : BaseViewController<UITextFieldDelegate>

typedef void(^Blocks)(NSString * showStr);

@property(nonatomic,strong) Blocks changBlock;

@end
