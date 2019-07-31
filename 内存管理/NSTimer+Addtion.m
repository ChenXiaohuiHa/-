//
//  NSTimer+Addtion.m
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

#import "NSTimer+Addtion.h"

@implementation NSTimer (Addtion)


+ (NSTimer *)cx_scheduledTimerWithTimerInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(cx_blockInvake:) userInfo:[block copy] repeats:repeats];
}
- (void)cx_blockInvake:(NSTimer *)timer {
    
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end
