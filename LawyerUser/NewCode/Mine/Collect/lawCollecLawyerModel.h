//
//  lawCollecLawyerModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/9.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawCollecLawyerModel : NSObject
/*
 "id": "1",
 "name": "张三",
 "avatar": "/Uploads/home/avatar/2018-09-04/1536072038_16005989655b8e9966c2e90.jpg",
 "company": "无锡双汇律师事务所",
 "practice_years": "9",
 "city_name": "郑州市" } ]
 */

@property(strong , nonatomic) NSString * id;
@property(strong , nonatomic) NSString * name;
@property(strong , nonatomic) NSString * avatar;
@property(strong , nonatomic) NSString * company;
@property(strong , nonatomic) NSString * practice_years;
@property(strong , nonatomic) NSString * city_name;
@end

NS_ASSUME_NONNULL_END
