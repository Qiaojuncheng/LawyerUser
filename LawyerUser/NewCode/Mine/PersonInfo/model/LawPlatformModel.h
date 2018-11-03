//
//  LawPlatformModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/19.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawPlatformModel : NSObject
/*
 
 cate
 certificate = " ";
 company = "\U6c5f\U82cf\U53cc\U6c47\U5f8b\U5e08\U4e8b\U52a1\U6240";
 id = 29;
 "lawyer_code" = 0;
 "meet_money" = "20.00";
 "phone_money" = "20.00";
 
 
 
 "area_name" = "\U6ee8\U6e56\U533a";
 avatar = "/Uploads/wap/avatar/2018-09-10/1536553700_18211419775b95f2e430f0a.jpg";
 "city_name" = "\U65e0\U9521\U5e02";
 "company_name" = "\U6c5f\U82cf\U5f8b\U6e90\U7f51\U7edc\U79d1\U6280\U6709\U9650\U516c\U53f8";
 "end_time" = 1571881702;
 id = 3;
 "is_vip" = 1;
 license = "/Uploads/home/avatar/2018-09-20/1537431618_10450624295ba35842a118a.jpg";
 name = "\U6f58\U68a6\U98de";
 phone = 15838308007;
 "province_name" = "\U6c5f\U82cf\U7701";
 sex = 1;
 */

@property(strong, nonatomic)  NSMutableArray * area_name;
@property(strong, nonatomic) NSString  * avatar;
@property(strong, nonatomic) NSString  * city_name;
@property(strong, nonatomic) NSString  * company_name;
@property(strong, nonatomic) NSString  * end_time; //vip到期时间
 @property(strong, nonatomic) NSString  * is_vip;// 1 ViP  0 不是VIP
@property(strong, nonatomic) NSString  * license;
@property(strong, nonatomic) NSString  * name;
@property(strong, nonatomic) NSString  * phone;
@property(strong, nonatomic) NSString  * province_name;
@property(strong, nonatomic) NSString  * sex;// 1 男 2 女


@property(strong, nonatomic) NSString  * lawyer_code;

@property(strong, nonatomic)  NSMutableArray * cate;// 规格数组
 @property(strong, nonatomic) NSString  * certificate;
@property(strong, nonatomic) NSString  * company;
@property(strong, nonatomic) NSString  * id;
@property(strong, nonatomic) NSString  * meet_money;
@property(strong, nonatomic) NSString  * phone_money;
@property(strong, nonatomic) NSString  * instru;

@end
