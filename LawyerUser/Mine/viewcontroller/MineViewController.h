//
//  MineViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/10.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
  
    UITableView * TV;
    
    NSArray * DataArray;

}

@end
