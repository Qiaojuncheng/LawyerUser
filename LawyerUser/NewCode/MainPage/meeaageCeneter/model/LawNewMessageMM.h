//
//  LawNewMessageMM.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawNewMessageMM : NSObject
/*
 
 
 "id":"117",
 "uid":"1",
 "title":"你发布的预约已有律师答复了，快去看看吧",
 "create_time":"1542074764",
 "type":"2",
 "status":"1",
 "content":"潘梦飞律师同意了您的预约！",
 "tid":"144"
 
 */
@property (strong , nonatomic) NSString * id;
@property (strong , nonatomic) NSString * lid;
@property (strong , nonatomic) NSString * title;
@property (strong , nonatomic) NSString * create_time;
@property (strong , nonatomic) NSString * type;
@property (strong , nonatomic) NSString * status;
@property (strong , nonatomic) NSString * tid;
@end
