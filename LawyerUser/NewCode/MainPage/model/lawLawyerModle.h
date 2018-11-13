//
//  lawLawyerModle.h
//  Lawyer
//
//  Created by MYMAc on 2018/10/15.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lawLawyerModle : NSObject
/*
 {
 "id":"24",
 "name":"丁力",
 "avatar":"/Uploads/admin/Lawyer/2018-09-06/1536219218_15662156215b90d8524a747.png",
 "company":"江苏双汇律师事务所",
 "practice_years":"8",
 "is_recom":"1",
 "city_name":"无锡市",
 "cate_name":[
 "合同纠纷",
 "婚姻家庭",
 "融资借款"
 ]
 
 },
 */
@property (strong , nonatomic ) NSString *distance ;

@property (strong , nonatomic ) NSString *id ;
@property (strong , nonatomic ) NSString *name ;
@property (strong , nonatomic ) NSString *avatar ;
@property (strong , nonatomic ) NSString *company ;
@property (strong , nonatomic ) NSString *practice_years ;
@property (strong , nonatomic ) NSString *is_recom ;
@property (strong , nonatomic ) NSString *city_name ;
@property (strong , nonatomic ) NSArray *cate_name ;
 
@end
