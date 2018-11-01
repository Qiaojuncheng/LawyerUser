//
//  QJNetWork.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNetWork.h"
#import "AFNetworking.h"

@implementation QJNetWork

+ (void)netWorkHttpPostWithUrl:(NSString *)url With:(NSDictionary *)params WithSuccess:(void (^)(id result))success With:(void (^)(NSError *error))falure
{
    AFHTTPSessionManager *manager = [self manager];
    
      [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          success(responseObject);
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          falure(error);
      }];
   
}
+ (void)netWorkHttpGetWithUrl:(NSString *)url With:(NSDictionary *)params WithSuccess:(void (^)(id result))success With:(void (^)(NSError *error))falure
{
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falure(error);
    }];
}

+ (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //	manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    
    //	manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableStatusCodes = nil;
    return manager;
}

@end
