//
//  lawOrderResultModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/29.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawOrderResultModel : NSObject
/*
 "id":"1",
 "time":"前天 21:56",
 "describe":"合同审查竞标",
 "status":"0",
 "name":"方大同",
 "avatar":"/Uploads/app/Avatar/2018-11-09/1541741907_3338.jpg"
 }
 */
@property (strong ,nonatomic) NSString * id ;
@property (strong ,nonatomic) NSString * time ;
@property (strong ,nonatomic) NSString * describe ;
@property (strong ,nonatomic) NSString * status ;
@property (strong ,nonatomic) NSString * name ;
@property (strong ,nonatomic) NSString * avatar ;
@property (assign ,nonatomic) CGFloat  cellHeight ;

@end

NS_ASSUME_NONNULL_END
