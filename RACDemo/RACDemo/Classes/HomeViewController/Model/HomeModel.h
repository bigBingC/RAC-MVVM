//
//  HomeModel.h
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/11.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicInfo : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *maxid;
@property (nonatomic, copy) NSString *maxtime;
@end

@interface HomeModel : NSObject
@property (nonatomic, strong) TopicInfo *info;
@property (nonatomic, strong) NSArray *list;
@end

@interface TopicList : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *profile_image;

//自定义参数
@property (nonatomic, assign) BOOL isSeleted;
@end
