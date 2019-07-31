//
//  NSTimer+Addtion.h
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

/**
 VC 强引用 timer，但是不会被 timer 强引用，但有个问题是 VC 退出被释放时，如果要停掉 timer 需要自己调用一下 timer 的 invalidate 方法。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Addtion)

+ (NSTimer *)cx_scheduledTimerWithTimerInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
