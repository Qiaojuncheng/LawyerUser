//
//  lawConsultdetailModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/12.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawConsultdetailModel : NSObject

/*
 "id":"71",
 "lid":"31",
 "content":"比不了",
 "time":"44分钟前",
 "is_adopt":"1",
 "lawyer_name":"潘梦飞律师",
 "avatar":"/Uploads/app/Avatar/2018-09-11/1536661759_4923.jpg",
 "adopt":1
 
 */
@property (strong , nonatomic) NSString * id ;
@property (strong , nonatomic) NSString * lid ;
@property (strong , nonatomic) NSString * content ;
@property (strong , nonatomic) NSString * time ;
@property (strong , nonatomic) NSString * is_adopt ;
@property (strong , nonatomic) NSString * lawyer_name ;
@property (strong , nonatomic) NSString * avatar ;
@property (strong , nonatomic) NSString * adopt ;





@property (assign , nonatomic ) float CellHeight;

@end

NS_ASSUME_NONNULL_END
