//
//  BaseViewModel.m
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/10.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "BaseViewModel.h"
#import "HttpHelper.h"

@interface BaseViewModel ()
@property (nonatomic, strong) HttpHelper *helper;
@end

@implementation BaseViewModel

- (RACSignal *)getRequestWithURLString:(NSString *)URLString parametersDictionary:(NSDictionary *)param {
     @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.helper getRequestWithUrlString:URLString paramDic:param succeedBlock:^(id result) {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failBlock:^(NSError *error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (HttpHelper *)helper {
    if (!_helper) {
        _helper = [[HttpHelper alloc] init];
    }
    return _helper;
}
@end
