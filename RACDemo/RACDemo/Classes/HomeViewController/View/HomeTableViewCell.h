//
//  HomeTableViewCell.h
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/11.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

static NSString *const HomeTableViewCellID = @"HomeTableViewCell";

@interface HomeTableViewCell : UITableViewCell
@property (nonatomic, strong) TopicList *listInfo;
@end
