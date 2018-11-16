//
//  lawMyconsultListModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/12.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawMyconsultListModel : NSObject
/*
 avatar = "/Public/avatar.png";
 "cate_name" = "\U4e00\U822c\U6c11\U4e8b";
 content = "\U5bb6\U6709\U623f\U4ea7\U4e00\U5957\Uff0c\U623f\U672c\U4e3a\U6bcd\U4eb2\U540d\U5b57\Uff0c\U4e3a\U5355\U4f4d\U5206\U623f\U540e\U4e70\U7684\U4ea7\U6743\U3002\U723697\U5e74\U53bb\U4e16\Uff0c\U5976\U5976\U540e\U53bb\U4e16\U3002\U54a8\U8be2\U6b64\U623f\U4ea7\U4e0e\U59d1\U59d1\U53d4\U53d4\U5bb6\U6709\U5173\U5417\Uff1f\U5982\U6709\U5173\Uff0c\U53d4\U53d4\U59d1\U59d1\U5360\U591a\U5c11\U4efd\U989d\U3002\U6211\U5bb6\U5171\U5144\U59b9\U4e24\U4eba\U3002\U8c22\U8c22\n";
 "create_time" = "11\U670808\U65e5 20:28";
 id = 59;
 name = "\U4e54\U4fca\U6210";
 red = 1;
 "reply_count" = 0;
 
 name
 cate_name
 */
 
@property (strong , nonatomic) NSString *avatar ;
@property (strong , nonatomic) NSString *cate_name ;
@property (strong , nonatomic) NSString *content ;
@property (strong , nonatomic) NSString *create_time ;
@property (strong , nonatomic) NSString *id ;
@property (strong , nonatomic) NSString *name ;
@property (strong , nonatomic) NSString *red ;// 0 显示  1 不显示
@property (strong , nonatomic) NSString *reply_count ;//回复次数（大于0显示已回答，0显示未回答）


@property (assign, nonatomic) CGFloat CellHeight;


@end

NS_ASSUME_NONNULL_END
