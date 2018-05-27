//
//  AOP_TestClass.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/14.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "AOP_TestClass.h"
#import "AOP_NSProxy.h"

@implementation AOP_TestClass

- (void)getData {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    void(^block)(NSData *data) = ^(NSData *data) {
        NSError *error;
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//        NSLog(@"%@", json);
    };
    NSURL *url = [AOP_NSProxy proxyForObject:[NSURL URLWithString:@"https://api.huaban.com"]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_semaphore_signal(sem);
        block(data);
    }];
    [task resume];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

@end
