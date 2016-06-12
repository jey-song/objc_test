//
//  MaxEarnings.m
//  objcTest
//
//  Created by Jey on 6/5/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "MaxEarnings.h"
#import <Foundation/Foundation.h>

@interface NSMutableArray (Reverse)
- (void)reverse;
@end

@implementation NSMutableArray (Reverse)

- (void)reverse {
    if ([self count] <= 1) {
        return;
    }

    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;

    while (i < j) {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];

        i++;
        j--;
    }
}

@end


@implementation MaxEarnings
- (void)testEarnings {
    NSMutableArray *a = @[@15, @3, @6, @7, @19, @16, @11, @2, @18, @7, @9, @4, @10].mutableCopy;
    NSInteger t = [self earningsInPrices:a amount:1];

    NSAssert((17 == t), @"error: %ld", (long)t);

    a[4] = @13;
    t = [self earningsInPrices:a amount:1];
    NSAssert((14 == t), @"error: %ld", (long)t);

    [a reverse];
    t = [self earningsInPrices:a amount:1];
    NSAssert((16 == t), @"error: %ld", (long)t);

    a[5] = @4;
    t = [self earningsInPrices:a amount:1];
    NSAssert((15 == t), @"error: %ld", (long)t);
}

#pragma mark -
// 一个股票序列中买卖1次的最大值
- (NSInteger)earningsInPrices:(NSArray *)prices amount:(NSUInteger)amount {
    NSInteger t = 0;
    NSUInteger max = 0, min = NSIntegerMax;
    NSUInteger preMax = 0;

    for (int i = 0; i < [prices count] - 1; i++) {
        NSInteger p = [prices[i] integerValue];
        NSInteger np = [prices[i + 1] integerValue];

        if (p > preMax) {
            preMax = p;
        }

        if (np < min) {
            min = np;

            if (preMax > max) {
                max = preMax;
            }

            t = max - min;
        }
    }

    NSLog(@"max: %lu, min: %lu", (unsigned long)max, (unsigned long)min);
    return amount * t;
}

@end
