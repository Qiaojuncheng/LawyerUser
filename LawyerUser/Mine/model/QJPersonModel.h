//
//  QJPersonModel.h
//  Lawyer
//
//  Created by MYMAc on 2017/9/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJPersonModel : NSObject
/*
 
 address = "<null>";
 area = 0;
 avatar = "/Uploads/Avatar/avatar.jpg";
 city = 0;
 "col_money" = "0.00";
 "create_time" = 1505443351;
 email = "<null>";
 id = 62;
 jf = 0;
 job = "<null>";
 money = "99999979.00";
 name = "<null>";
 password = cc5c16c8be565fd40f929ca9320da6de;
 phone = 18039678870;
 province = 0;
 "qq_openid" = "<null>";
 salt = 5498;
 sex = 0;
 status = 1;
 type = 1;
 unit = "<null>";
 username = "\U738b\U5efa\U9716";
 "wx_openid" = "<null>";
 "ytx_money" = "0.00";
 
 isExpire   0 不显示     1 到期显示
 };

 */


@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * area;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * col_money;
@property (nonatomic, strong) NSString * create_time;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * jf;
@property (nonatomic, strong) NSString * job;
@property (nonatomic, strong) NSString * money;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * salt;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * unit;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * wx_openid;
@property (nonatomic, strong) NSString * ytx_money;
@property (nonatomic, strong) NSString * isExpire;

















@end
