//
//  lawCompanyModel.h
//  Lawyer
//
//  Created by MYMAc on 2018/11/5.
//  Copyright © 2018年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface lawCompanyModel : NSObject
/*
 "id":"1",
 "name":"无锡市高端机电设备安装工程有限公司",
 "region":"江苏省无锡市滨湖区",
 "img":"/Uploads/admin/Enterprise/2018-09-14/1536893263_19927593165b9b214f16a49.png"
 */
@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * region;
@property (strong, nonatomic) NSString * img;
@end

NS_ASSUME_NONNULL_END
