//
//  MyClass_forwardingTargetSelector.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/4.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "MyClass_forwardingTargetSelector.h"
#import <objc/runtime.h>

@interface MyClass : NSObject

- (void)instanceMethod:(NSString *)log;

@end

@implementation MyClass

- (void)instanceMethod:(NSString *)log {
    NSLog(@"instanceMethod 消息已经处理 %@", log);
}

@end

@implementation MyClass_forwardingTargetSelector

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}

// 如果 resolveInstanceMethod 或者 resolveClassMethod 返回值为NO时，就会触法重定向

void forwardingInstanceMethod(id self, SEL _cmd, NSString *log) {
    NSLog(@"forwardingInstanceMethod 消息已经处理 %@", log);
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(instanceMethod:)) {
        // 方法一: 动态实现类
        id MyClass = objc_getClass("MyClass");
        class_addMethod(object_getClass(MyClass), aSelector, (IMP)forwardingInstanceMethod, "v@:@"); // 注意这里必须要用 object_getClass(MyClass)。获取元类
        return MyClass;
        
        // 方法二: 自己实现类     注意:如果是自己实现类，其方法必须和原来的一样，否则就会找不到该方法，还是会Crash
//        MyClass *my = [[MyClass alloc] init];
//        return my;
    }
    return [super forwardingTargetForSelector:aSelector];
}


void forwardingClassMethod(id self, SEL _cmd, NSString *log) {
    NSLog(@"C 语言实现 forwardingClassMethod 消息已经处理 %@", log);
}

+ (void)forwardingClassMethod:(NSString *)log {
    NSLog(@"OC 实现 forwardingClassMethod 消息已经处理 %@", log);
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(classMethod:)) {
        Class myClass = object_getClass(@"MyClass");
        
        // 在调用class_addMethod的时候必须要用object_getClass(myClass)添加
//        class_addMethod(object_getClass(myClass), aSelector, class_getMethodImplementation(object_getClass(self), @selector(forwardingClassMethod:)), "v@:@"); // OC实现
        
        class_addMethod(object_getClass(myClass), aSelector, (IMP)forwardingClassMethod, "v@:@"); // C语言实现
        return myClass;
    }
    return [super forwardingTargetForSelector:aSelector];
}


@end
