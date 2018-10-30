//
//  lawLawyerDetailModle.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/16.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lawLawyerDetailModle : NSObject
/*"id":"3",
"name":"田华锋",
"avatar":"/Uploads/admin/Lawyer/2018-09-06/1536215408_7616957045b90c97077f9d.jpg",
"company":"江苏双汇律师事务所（南京分所）",
"instru":"",
"is_recom":"1",
"practice_years":"15",
"province_name":"江苏省",
"city_name":"无锡市",
"area_name":"滨湖区",
"cate_name":[
             "融资借款",
             "经济仲裁",
             "一般刑事"
             ],
"is_keep":1
 */

@property (strong ,nonatomic) NSString * id ;
@property (strong ,nonatomic) NSString * name ;
@property (strong ,nonatomic) NSString * avatar ;
@property (strong ,nonatomic) NSString * company ;
@property (strong ,nonatomic) NSString * instru ;
@property (strong ,nonatomic) NSString * is_recom ;// 0 不推荐 1推荐
@property (strong ,nonatomic) NSString * practice_years ;
@property (strong ,nonatomic) NSString * province_name ;
@property (strong ,nonatomic) NSString * city_name ;
@property (strong ,nonatomic) NSString * area_name ;
@property (strong ,nonatomic) NSString * order_num ;
@property (strong ,nonatomic) NSString * phone_money ;
@property (strong ,nonatomic) NSString * meet_money ;
 @property (strong ,nonatomic) NSArray  * cate_name ;
@property (strong ,nonatomic) NSString * is_keep ;  // 1 未关注 2 关注

@end
