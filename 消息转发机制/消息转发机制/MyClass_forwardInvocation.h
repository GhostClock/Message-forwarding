//
//  MyClass_forwardInvocation.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/7.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass_forwardInvocation : NSObject

// forwardInvocation 转发

- (void)instanceMethod:(NSString *)log;

+ (void)classMethod:(NSString *)log;

@end
