//
//  lawVipConcentModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/4.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawVipConcentModel : NSObject

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * price;
@property (strong, nonatomic) NSMutableArray * content;

@end

NS_ASSUME_NONNULL_END
