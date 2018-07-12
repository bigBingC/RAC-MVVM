//
//  RACView.m
//  RACDemo
//
//  Created by 崔冰 on 2018/7/6.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "RACView.h"

@interface RACView()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation RACView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithSubviews];
    }
    return self;
}

- (void)initWithSubviews {
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

}

- (void)btnClick:(UIButton *)btn {
    
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        [_btn setTitle:@"RACBtn" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
