//
//  MyClass_forwardingTargetSelector.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/4.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass_forwardingTargetSelector : NSObject

// forwarding重定向

- (void)instanceMethod:(NSString *)log;

+ (void)classMethod:(NSString *)log;

@end
