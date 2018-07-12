//
//  BaseViewModel.h
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/10.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^RequestSucceed)(id result);
typedef void(^RequestFailure)(NSError *error);

@interface BaseViewModel : NSObject

/**
 请求数据(GET)
 */
- (RACSignal *)getRequestWithURLString:(NSString *)URLString parametersDictionary:(NSDictionary *)param;
@end
