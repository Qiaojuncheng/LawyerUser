//
//  lawVipRecodeModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/3.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//充值记录
/*
 "id":"5",
 "time":"1539701547",
 "order_sn":"ST15397015416236",
 "price":"25800.00",
 "name":"钻石卡"
  */
 @interface lawVipRecodeModel : NSObject
@property (strong , nonatomic) NSString * id;
@property (strong , nonatomic) NSString * time;
@property (strong , nonatomic) NSString * order_sn;
@property (strong , nonatomic) NSString * price;
@property (strong , nonatomic) NSString * name;

//使用记录

/*
 "id":"26",
 "remark":"发布见面预约",
 "time":"1539744210",
 "num":"1",
 "lawyer_name":"小姑娘"
*/
@property (strong , nonatomic) NSString * remark;
@property (strong , nonatomic) NSString * num;
@property (strong , nonatomic) NSString * lawyer_name;


@end

NS_ASSUME_NONNULL_END
