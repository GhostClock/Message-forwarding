//
//  BookProvider.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/10.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookProviderDelegate <NSObject>

- (void)purchaseBookWithTitle:(NSString *)bookTitle;

@end

@interface BookProvider : NSObject

@end
