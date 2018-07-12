//
//  RACSignalViewController.m
//  RACDemo
//
//  Created by 崔冰 on 2018/7/6.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "RACSignalViewController.h"
#import "RACView.h"

@interface RACSignalViewController ()
@property (nonatomic, strong) UIButton *sendMessageBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) RACView *racView;
@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createBaseView];
    [self testKVO];
    [self testAction];
    [self testNotification];
    [self testTextField];
    [self testDelegate];
    
    [self testRAC];
}

- (void)createBaseView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.sendMessageBtn];
    [self.sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(100);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sendMessageBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(80);
        make.right.equalTo(self.view.mas_right).offset(-80);
        make.height.mas_equalTo(30);
    }];
    
    self.racView = [[RACView alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    self.racView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.racView];
}

/**
 代替kvo
 * rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变
 */
- (void)testKVO {
   //RACSiganl（信号类）只是表示当数据改变时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者subscriber去发出。
    [[self.racView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
        NSLog(@"修改了%@",x);
    }];
}

/**
 替代代理
 * rac_signalForSelector：用于替代代理。
 */

- (void)testDelegate {
    [[self.racView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击了%@",x);
    }];
}

/**
 代替事件监听
 * rac_signalForControlEvents：用于监听某个事件
 */
- (void)testAction {
    [[self.sendMessageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"%@被点击了",x);
    }];
}

/**
 代替通知
 * rac_addObserverForName:用于监听某个通知
 */
- (void)testNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出通知");
    }];
}

/**
 监听文本
 * rac_textSignal:只要文本框发出改变就会发出这个信号
 */
- (void)testTextField {
    [[self.textField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"文本改变%@",x);
    }];
}

- (void)testRAC {
    /**
     1、+ (RACSignal *)interval:(NSTimeInterval)interval onScheduler:(RACScheduler *)scheduler方法返回一个在主线程上间隔一秒执行一次的signal，RAC内部是利用dispatch_source_set_timer dispatch_source_set_event_handler dispatch_resume这一系列的GCD方法来实现的。注意这个signal所sendnext的值是当前日期的NSDate对象，不过这个值对于整个功能是没有用处的。
     2、- (instancetype)take:(NSUInteger)count取前numberLimit次sendnext的值，相当于我们需要倒计时多久
     3、通过- (instancetype)startWith:(id)value修改第一次sendnext的值，并且立即sendnext这个值。理论上对于sendnext的值是不需要处理的，原因是+ (RACSignal *)interval:(NSTimeInterval)interval onScheduler:(RACScheduler *)scheduler所返回的signal会停顿1秒才执行，利用startWith来立即开始倒计时罢了，所以说startWith:的参数值是什么不重要
     4、利用- (instancetype)map:(id (^)(id value))block修改sendnext最终的值返回@YES或者@NO
     5、- (RACSignal *)takeUntil:(RACSignal *)signalTrigger意思是当这个VC的即将dealloc的时候停止倒计时，RAC内部其实就是sendCompleted。
     6、最后把timeSignal和sendMessageBtn.rac_command绑定判断按钮是否可用，并且启动timeSignal。按钮被点击的时候恢复time的值，return buttonSignal来重新启动倒计时timeSignal
     
     */
    __block NSInteger time = 5;
    @weakify(self);
    //倒计时
    RACSignal *timeSignal = [[[[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] take:5] startWith:@(1)] map:^id(NSDate *date) {
        NSLog(@"%@", date);
        @strongify(self);
        if (time == 0) {
            [self.sendMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            return @YES;
        } else {
            [self.sendMessageBtn setTitle:[NSString stringWithFormat:@"%@s后重新发送",@(time--)] forState:UIControlStateDisabled];
            [self.sendMessageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            return @NO;
        }
    }] takeUntil:self.rac_willDeallocSignal];
    
    //按钮点击
    self.sendMessageBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        time = 5;
        return timeSignal;
    }];
}

#pragma mark - set
- (UIButton *)sendMessageBtn {
    if (!_sendMessageBtn) {
        _sendMessageBtn = [[UIButton alloc] init];
        _sendMessageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_sendMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendMessageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _sendMessageBtn;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.layer.borderColor = [UIColor grayColor].CGColor;
        _textField.layer.borderWidth = 1;
    }
    return _textField;
}
@end
