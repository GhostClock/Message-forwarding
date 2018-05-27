//
//  AOP_NSProxy.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/14.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOP_NSProxy : NSProxy

+ (id)proxyForObject:(id)obj;

@end
