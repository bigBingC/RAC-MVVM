//
//  HomeViewModel.h
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/10.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

@interface HomeViewModel : BaseViewModel
/**
 请求传参
 */
@property (nonatomic, copy) NSString *currentPages;
@property (nonatomic, copy) NSString *currentMaxTime;

/**
 返回出参
 */
@property (nonatomic, strong, readonly) NSMutableArray <TopicList *>* listArray;

/**
 请求方法 block传值
 */
- (void)sendRequest:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

/**
 信号量代替block实现请求
 */
- (RACSignal *)fetchBaseData;
@end
