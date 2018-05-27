//
//  DealerProxy.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/11.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookProvider.h"
#import "ClothesProvider.h"

@interface DealerProxy : NSProxy <BookProviderDelegate, ClothesProviderDelegate>

+ (instancetype)dealerProxy;

@end
