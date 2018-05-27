//
//  DealerProxy.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/11.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "DealerProxy.h"
#import <objc/runtime.h>

@interface DealerProxy(){
    BookProvider        *_bookProvider;
    ClothesProvider     *_clotherProvider;
    NSMutableDictionary *_methodMap;
}
@end

@implementation DealerProxy


- (void)registerMethodWithTarget:(id)target {
    unsigned int numberOfMethods = 0;
    // 获取target方法列表
    Method *method_list = class_copyMethodList([target class], &numberOfMethods);
    
    for (int i = 0; i < numberOfMethods; i ++) {
        // 获取方法名并存入字典
        Method temp_method = method_list[i];
        SEL temp_sel = method_getName(temp_method);
        const char *temp_method_name = sel_getName(temp_sel);
        [_methodMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    }
    free(method_list);
}

- (instancetype)init {
    _methodMap = [NSMutableDictionary dictionary];
    _bookProvider = [[BookProvider alloc] init];
    _clotherProvider = [[ClothesProvider alloc] init];
    
    [self registerMethodWithTarget:_bookProvider];
    [self registerMethodWithTarget:_clotherProvider];
    
    return self;
}

+ (instancetype)dealerProxy {
    return [[DealerProxy alloc] init];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    // 获取选择器的方法名
    NSString *methodName = NSStringFromSelector(sel);
    
    // 在字典中查找对应的taeget
    id target = _methodMap[methodName];
    
    // 检查target
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}


- (void)forwardInvocation:(NSInvocation *)invocation {
    // 获取当前的选择器
    SEL sel = [invocation selector];
    
    // 获取选择器的方法名
    NSString *methodName = NSStringFromSelector(sel);
    
    // 在字典中查找对应的target
    id target = _methodMap[methodName];
    
    // 检查target
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
