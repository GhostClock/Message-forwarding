//
//  BookProvider.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/10.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "BookProvider.h"

@interface BookProvider() <BookProviderDelegate>

@end

@implementation BookProvider

- (void)purchaseBookWithTitle:(NSString *)bookTitle {
    NSLog(@"The Book Title : %@", bookTitle);
}

@end
