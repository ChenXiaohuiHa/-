//
//  CXTimer.m
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

#import "CXTimer.h"

@interface CXTimer ()

@property (nonatomic, assign) SEL outSelector;
@property (nonatomic, weak) id outTarget;

@end
@implementation CXTimer

+ (NSTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    
    CXTimer *cxTimer = [[CXTimer alloc] init];
    cxTimer.outTarget = target;
    cxTimer.outSelector = selector;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:cxTimer selector:@selector(timerSelector:) userInfo:userInfo repeats:repeats];
    return timer;
}
- (void)timerSelector:(NSTimer *)timer {
    
    if (self.outTarget && [self.outTarget respondsToSelector:self.outSelector]) {
        [self.outTarget performSelector:self.outSelector withObject:timer.userInfo];
    }else{
        [timer invalidate];
    }
}

@end
