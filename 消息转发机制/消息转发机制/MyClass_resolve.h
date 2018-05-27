//
//  MyClass_resolve.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/2.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass_resolve : NSObject

// resolve动态解析

- (void)instanceMethod:(NSString *)log;

+ (void)classMethod:(NSString *)log;

@end
