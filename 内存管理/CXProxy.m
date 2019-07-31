//
//  CXProxy.m
//  内存管理
//
//  Created by 陈晓辉 on 2019/5/23.
//  Copyright © 2019年 陈晓辉. All rights reserved.
//

#import "CXProxy.h"

@interface CXProxy ()

@property (nonatomic, weak, readonly) id weakTarget;

@end
@implementation CXProxy

+ (instancetype)cx_proxyWithTarget:(id)target {
    
    return [[CXProxy alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target {
    _weakTarget = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    SEL sel = [invocation selector];
    if (_weakTarget && [self.weakTarget respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.weakTarget];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.weakTarget methodSignatureForSelector:sel];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.weakTarget respondsToSelector:aSelector];
}

@end
