//
//  QJSelectItemView.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/21.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJSelectItemView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{

    UIView * HeaderView ;
    UITableView  *_TV;
  
    void (^Block)(NSString * constr);
}


typedef void(^Blo)(int index);


@property (strong ,nonatomic) NSString * ViewTitlt;
@property (strong ,nonatomic) NSMutableArray *ViewDatArray;

@property (strong ,nonatomic ) Blo selectWithIndexBlcik;

-(void)showView;
-(void)dismissView;

@end
