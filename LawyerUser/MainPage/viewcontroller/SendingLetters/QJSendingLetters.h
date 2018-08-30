//
//  QJSendingLetters.h
//  Lawyer
//
//  Created by MYMAc on 2017/7/28.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJSendingLetters : BaseViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView * _TV;
    NSMutableArray * dataArray;

}

@end
