//
//  CXTimer.h
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

/// NSTimer 接触循环引用
/**
 VC 强引用 timer，因为 timer 的 target 是 CXTimer 实例，所以 timer 强引用 CXTimer 实例，而 CXTimer 实例弱引用 VC，解除循环引用。这种方案 VC 在退出时都不用管 timer，因为自己释放后自然会触发 timerSelector:中的[timer invalidate]逻辑，timer 也会被释放。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXTimer : NSObject


+ (NSTimer *)scheduledTimerWithTimerInterval:(NSTimeInterval)interval
                                      target:(id)target
                                    selector:(SEL)selector
                                    userInfo:(_Nullable id)userInfo
                                     repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
