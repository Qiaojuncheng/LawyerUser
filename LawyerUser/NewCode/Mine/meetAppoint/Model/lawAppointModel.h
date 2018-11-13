//
//  lawAppointModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/13.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawAppointModel : NSObject
/*
 "id":"144",
 "lid":"31",
 "pay_type":"2",
 "money":"200.00",
 "status":"1",
 "create_time":"2018-11-12 23:44:45",
 "type":"1",
 "name":"潘梦飞",
 "avatar":"/Uploads/app/Avatar/2018-09-11/1536661759_4923.jpg",
 "phone":"15838308007"
 cate_name
 */

@property (strong ,nonatomic) NSString *  id;
@property (strong ,nonatomic) NSString *  lid;
@property (strong ,nonatomic) NSString *  pay_type;
@property (strong ,nonatomic) NSString *  money;
@property (strong ,nonatomic) NSString *  status;
@property (strong ,nonatomic) NSString *  create_time;
@property (strong ,nonatomic) NSString *  type;
@property (strong ,nonatomic) NSString *  name;
@property (strong ,nonatomic) NSString *  avatar;
@property (strong ,nonatomic) NSString *  phone;
@property (strong ,nonatomic) NSString *  meet_time;
@property (strong ,nonatomic) NSString *  cate_name;

@end

NS_ASSUME_NONNULL_END
