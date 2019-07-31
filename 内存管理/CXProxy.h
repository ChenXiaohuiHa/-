//
//  CXProxy.h
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

/**
 创建一个继承 NSProxy 的子类 MyProxy，并实现消息转发的相关方法。NSProxy 是 iOS 开发中一个消息转发的基类，它不继承自 NSObject。因为他也是 Foundation 框架中的基类, 通常用来实现消息转发, 我们可以用它来包装 NSTimer 的 target, 达到弱引用的效果
 */

/**
 了解一下消息转发的过程就可以知道 -forwardInvocation: 是会有一个 NSInvocation 对象，这个 NSInvocation 对象保存了这个方法调用的所有信息，包括 Selector 名，参数和返回值类型，最重要的是有所有参数值，可以从这个 NSInvocation 对象里拿到调用的所有参数值。这时候我们把转发过来的消息和 weakTarget 的 selector 信息做对比，然后转发过去即可。
 这里需要注意的是，在调用方的 dealloc 中一定要调用 timer 的 invalidate 方法，因为如果这里不清理 timer，这个调用方 dealloc 被释放后，消息转发就找不到接收方了，就会 crash。
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXProxy : NSProxy

+ (instancetype)cx_proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
