//
//  Clothes.h
//  消息转发机制
//
//  Created by GhostClock on 2018/5/10.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CLOTHES_SIZE) {
    CLOTHES_SIZE_SMALL = 0,
    CLOTHES_SIZE_MEDIUM,
    CLOTHES_SIZE_LARGE,
};

@protocol ClothesProviderDelegate <NSObject>

- (void)purchaseClothesWithSize:(CLOTHES_SIZE)size;

@end

@interface ClothesProvider : NSObject

@end
