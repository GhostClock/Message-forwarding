//
//  ClothesSize.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/10.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "ClothesProvider.h"

@interface ClothesProvider() <ClothesProviderDelegate>

@end

@implementation ClothesProvider

- (void)purchaseClothesWithSize:(CLOTHES_SIZE)size {
    NSString *sizeStr;
    switch (size) {
        case CLOTHES_SIZE_LARGE:
            sizeStr = @"large size";
            break;
        case CLOTHES_SIZE_MEDIUM:
            sizeStr = @"medium size";
            break;
        case CLOTHES_SIZE_SMALL:
            sizeStr = @"simall size";
            break;
        default:
            break;
    }
    NSLog(@"You Clothes some size %@", sizeStr);
}

@end
