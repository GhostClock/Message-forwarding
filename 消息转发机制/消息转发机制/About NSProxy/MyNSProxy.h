//
//  MyNSProxy.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/10.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

// 继承自NSProxy来销毁定时器的强引用

@interface MyNSProxy : NSProxy

@property (weak, nonatomic, readonly) id target;

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end
