//
//  AOP_NSProxy.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/14.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "AOP_NSProxy.h"

@interface AOP_NSProxy()
{
    id _object;
}
@end

@implementation AOP_NSProxy

- (instancetype)initWithProxy:(id)obj {
    _object = obj;
    return self;
}

+ (id)proxyForObject:(id)obj {
    return [[self alloc] initWithProxy:obj];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_object methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
//    [self getValue:invocation];
    if ([_object respondsToSelector:invocation.selector]) {
        NSString *selectorName = NSStringFromSelector(invocation.selector);
        NSLog(@"正在调用 \"%@\".", selectorName);
        [invocation invokeWithTarget:_object];
        NSLog(@"调用完毕 \"%@\".", selectorName);
    }
}

- (void)getValue:(NSInvocation *)invocation {
    NSURL *url;
    [invocation getReturnValue:&url];
    [invocation getArgument:&url atIndex:0];
    [invocation getArgument:&url atIndex:1];
}

@end
