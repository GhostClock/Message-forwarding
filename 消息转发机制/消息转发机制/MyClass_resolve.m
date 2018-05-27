//
//  MyClass_resolve.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/2.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "MyClass_resolve.h"
#import <objc/runtime.h>

@implementation MyClass_resolve


void instenceMethodIMP(id self, SEL _cmd, NSString *log) {
    NSLog(@"instenceMethodIMP 消息已经处理 %@", log);
}

+ (void)classMethodIMP:( NSString *)log {
    NSLog(@"classMethodIMP 消息已经处理 %@", log);
}

#pragma mark - 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(instanceMethod:)) {
        // v@:@ 表示:v@:表示无返回值的函数，要是有返回值:比如i@:表示返回值是int类型
        class_addMethod([self class], sel, (IMP)instenceMethodIMP, "v@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

// 需要深刻理解[self class] 与 object_getClass(self) 甚至object_getClass([self class]) ,重点在于self的类型
// 1. 当self为实例对象时,[self class] 与 object_getClass(self) 等价,因为前者会调用后者, object_getClass([self class]) 得到元类
// 2. 当self是类对象时,[self class]返回值为自身，还是self，object_getClass(self)与object_getClass([self class])等价
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(classMethod:)) {
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(classMethodIMP:)), "v@:@");
        return YES;
    }
    return [super resolveClassMethod:sel];
}


@end
