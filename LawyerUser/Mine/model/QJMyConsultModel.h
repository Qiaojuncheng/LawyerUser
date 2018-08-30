//
//  QJMyConsultModel.h
//  Lawyer
//
//  Created by MYMAc on 2017/9/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJMyConsultModel : NSObject

/*
 "id":"12",
 "category_id":"11",
 "category_name":"婚姻继承",
 "user_id":"4",
 "title":" 房产纠纷",
 "content":"有一处房产存在纠纷问题",
 "create_time":"1499147085",
 "browse":"255",
 "status":"1",
 "pay_method":"2",
 "sn":"LW14991470853569",
 "money":"20.00",
 "huifu":null
 avatar ; 律师头像
 rid
 lawyer_name
*/

@property(strong , nonatomic) NSString * id;
@property(strong , nonatomic) NSString * category_id;
@property(strong , nonatomic) NSString * category_name;
@property(strong , nonatomic) NSString * user_id;
@property(strong , nonatomic) NSString * title;
@property(strong , nonatomic) NSString * content;
@property(strong , nonatomic) NSString * create_time;
@property(strong , nonatomic) NSString * browse;
@property(strong , nonatomic) NSString * status;
@property(strong , nonatomic) NSString * pay_method;
@property(strong , nonatomic) NSString * sn;
@property(strong , nonatomic) NSString * money;
@property(strong , nonatomic) NSString * huifu;
@property(strong , nonatomic) NSString * rid;
@property(strong , nonatomic) NSString * avatar;
@property(strong , nonatomic) NSString * lawyer_name;


@property(assign , nonatomic) CGFloat Height;
@property(strong , nonatomic) NSString * showMessage;


-(void)makeHeight;


@end
