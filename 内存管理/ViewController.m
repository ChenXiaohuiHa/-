//
//  ViewController.m
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

#import "ViewController.h"

#import "CXTimer.h"
#import "NSTimer+Addtion.h"
#import "CXProxy.h"
@interface ViewController ()

@property (nonatomic, strong) CXTimer *timer;
@property (nonatomic, strong) NSTimer *myTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// NSTimer 循环引用问题
    [self timerCycle];
}

#pragma mark - NSTimer 循环引用问题
- (void)timerCycle {
    
    /// 1. 使用中间类
    [CXTimer scheduledTimerWithTimerInterval:1.0 target:self selector:@selector(doSomeThing) userInfo:nil repeats:YES];
    
    /// 2. 使用类方法
    self.myTimer = [NSTimer cx_scheduledTimerWithTimerInterval:1.0 block:^{
        
        [self doSomeThing];
    } repeats:YES];
    
    /// 3. 使用虚基类 weakProxy
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[CXProxy cx_proxyWithTarget:self] selector:@selector(doSomeThing) userInfo:nil repeats:YES];
    
    /// 4. 使用 GCD timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    if (timer) {
        
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^ {
            
            [self doSomeThing];
        });
        dispatch_resume(timer);
    }
}


- (void)doSomeThing {
    
    NSLog(@"doSomething");
}
- (void)dealloc {
    NSLog(@"MyViewController dealloc");
    
    if (_myTimer) {
        [_myTimer invalidate];
    }
}


@end
