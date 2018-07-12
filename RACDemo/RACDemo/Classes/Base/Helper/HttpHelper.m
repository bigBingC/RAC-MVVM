//
//  HttpHelper.m
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/11.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "HttpHelper.h"
#import <AFNetworking.h>

@implementation HttpHelper

- (void)getRequestWithUrlString:(NSString *)urlString paramDic:(NSDictionary *)param succeedBlock:(RequestSucceedBlock)succeedBlock failBlock:(RequestFailBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", nil];
    [manager GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !succeedBlock ? : succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failBlock ? : failBlock(error);
    }];
}

@end
