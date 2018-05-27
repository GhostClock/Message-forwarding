//
//  MyClass_forwardInvocation.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/7.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "MyClass_forwardInvocation.h"
#import <objc/runtime.h>

@interface ProxyClass : NSObject

- (void)proxyMethod:(NSString *)log;

@end

@implementation ProxyClass

- (void)proxyMethod:(NSString *)log {
    NSLog(@"proxyMethod消息已经处理: %@", log);
}

@end


@implementation MyClass_forwardInvocation


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //方法一
//    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//    if (!signature) {
//        signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//    }
//    NSLog(@"signature = %@", signature);
//    return signature;
    
    // 方法二
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [ProxyClass instanceMethodSignatureForSelector:@selector(proxyMethod:)];
    }
    return signature;
}

- (void)proxyMethod2:(NSString *)log {
    NSLog(@"proxyMethod2消息已经处理: %@", log);
}

// anInvocation该消息封装了原始的消息和消息参数,对不能处理的消息做一些默认的处理
// 这个anInvocation是从methodSignatureForSelector消息传过来的，并取得方法签名用于生成anInvocation
// 所以在forwardInvocation之前要重写methodSignatureForSelector，否则会抛出异常
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    //方法一
//    SEL sel = anInvocation.selector;
//    [anInvocation setSelector:@selector(proxyMethod2:)];
//    NSString *str = @"123";
//    // argument 设置参数索引时不能从0开始,0被self占用，1被_cmd占用
//    [anInvocation setArgument:&str atIndex:2];
//    [anInvocation invokeWithTarget:self];
    
    //方法二
    NSString *info = [NSString stringWithFormat:@"Message {%@} send to {%@}", NSStringFromSelector(anInvocation.selector), NSStringFromClass([self class])];
    // 重定向
    [anInvocation setSelector:@selector(proxyMethod:)];
    // 传递调用信息
    [anInvocation setArgument:&info atIndex:2];
    //对象接受转发的消息并打印调用的信息
    [anInvocation invokeWithTarget:[ProxyClass new]];
}

@end
