//
//  HttpHelper.h
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/11.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSucceedBlock)(id result);
typedef void(^RequestFailBlock)(NSError *error);

@interface HttpHelper : NSObject

/**
 GET请求
 
 @param urlString 接口地址
 @param param 参数字典
 @param succeedBlock 成功回调
 @param failBlock 失败回调
 */
- (void)getRequestWithUrlString:(NSString *)urlString
                       paramDic:(NSDictionary *)param
                   succeedBlock:(RequestSucceedBlock)succeedBlock
                      failBlock:(RequestFailBlock)failBlock;
@end
