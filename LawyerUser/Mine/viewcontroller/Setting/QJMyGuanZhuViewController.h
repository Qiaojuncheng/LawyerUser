//
//  QJMyGuanZhuViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/9/26.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJMyGuanZhuViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray * DataArray ;
    UITableView *_tv;
}
@end
