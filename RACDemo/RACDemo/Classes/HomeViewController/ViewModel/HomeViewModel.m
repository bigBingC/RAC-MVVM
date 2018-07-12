//
//  HomeViewModel.m
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/10.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel ()
@property (nonatomic, strong) NSMutableArray <TopicList *>* listArray;
@end

@implementation HomeViewModel

- (void)sendRequest:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"list" forKey:@"a"];
    [dict setValue:@"data" forKey:@"c"];
    [dict setValue:@(29) forKey:@"type"];
    if (self.currentPages > 0) {
        [dict setValue:self.currentMaxTime forKey:@"maxtime"];
        [dict setValue:@([self.currentPages integerValue]) forKey:@"page"];
    }
    __weak typeof(self) weakSelf = self;
    [[self getRequestWithURLString:@"http://api.budejie.com/api/api_open.php" parametersDictionary:dict] subscribeNext:^(id rusult) {
        HomeModel *model = [HomeModel mj_objectWithKeyValues:rusult];
        [weakSelf.listArray addObjectsFromArray:model.list];
        !succeedBlock ?: succeedBlock(model);
    } error:^(NSError *error) {
        !failBlock ?: failBlock(error);
    }];
}

- (RACSignal *)fetchBaseData {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"list" forKey:@"a"];
        [dict setValue:@"data" forKey:@"c"];
        [dict setValue:@(29) forKey:@"type"];
        if (self.currentPages > 0) {
            [dict setValue:self.currentMaxTime forKey:@"maxtime"];
            [dict setValue:@([self.currentPages integerValue]) forKey:@"page"];
        }
        [[self getRequestWithURLString:@"http://api.budejie.com/api/api_open.php" parametersDictionary:dict] subscribeNext:^(id result) {
            HomeModel *model = [HomeModel mj_objectWithKeyValues:result];
            [self.listArray addObjectsFromArray:model.list];
            
//            if ([result isKindOfClass:[NSDictionary class]]) {
//                [((NSDictionary *)result).rac_sequence.signal subscribeNext:^(id x) {
//                    //RACTupleUnpack宏：专门用来解析元组
//                    //RACTupleUnpack 等式右边：需要解析的元组
//                    //宏的参数，填解析的什么样数据 元组里面有几个值，宏的参数就必须填几个
//                    RACTupleUnpack(id key,id value) = x;
//                    NSLog(@"+++%@,%@",key,value);
//
//                } completed:^{
//                    NSLog(@"---字典解析完成");
//                }];
//            }
            
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

#pragma mark - set
- (NSMutableArray<TopicList *> *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
