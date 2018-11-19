//
//  lawMyOrderModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawMyOrderModel : NSObject
/*
 "id":"43",
 "content":"合同审查",
 "type":"2",
 "user_money":"0",
 "money":"0.01",
 "status":"1",
 "create_time":"2018-11-14 21:00:59",
 "pay_type":"2",
 "lawyer_num":"0",
 "name":"王岩",
 "avatar":"/Uploads/home/avatar/2018-09-04/1536072038_16005989655b8e9966c2e90.jpg",
 "province_name":"河南省",
 "city_name":"郑州市",
 "cate_name":"债权债务",
 "type_name":"合同审查"
 */

@property (strong ,nonatomic) NSString * id ;
@property (strong ,nonatomic) NSString * content ;
@property (strong ,nonatomic) NSString * type ;
@property (strong ,nonatomic) NSString * user_money ;
@property (strong ,nonatomic) NSString * money ;
@property (strong ,nonatomic) NSString * status ;
@property (strong ,nonatomic) NSString * create_time ;
@property (strong ,nonatomic) NSString * pay_type ;
@property (strong ,nonatomic) NSString * lawyer_num ;
@property (strong ,nonatomic) NSString * name ;
@property (strong ,nonatomic) NSString * avatar ;
@property (strong ,nonatomic) NSString * province_name ;
@property (strong ,nonatomic) NSString * city_name ;
@property (strong ,nonatomic) NSString * cate_name ;
@property (strong ,nonatomic) NSString * type_name ;
@property (assign ,nonatomic) CGFloat   cellHeight ;



@end

NS_ASSUME_NONNULL_END
