//
//  Binary.m
//  objcTest
//
//  Created by Jey on 6/5/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "Binary.h"

@implementation Binary
- (instancetype)init {
    self = [super init];

    if (self) {
        //[self testSearch];
    }

    return self;
}

- (void)testSearch {
    NSArray *a = @[@1, @3, @6, @7, @9, @21, @23, @29, @33, @45, @46, @59, @60];

    NSLog(@"%ld", (long)[self searchIndexInArray:a targetItem:@3 minIndex:0 maxIndex:[a count] - 1]);
}

#pragma mark -
- (NSUInteger)searchIndexInArray:(NSArray<NSNumber *> *)array targetItem:(NSNumber *)item minIndex:(NSUInteger)minIndex maxIndex:(NSUInteger)maxIndex {
    if (maxIndex < minIndex) {
        return -1;
    }

    NSUInteger midIndex = (minIndex + maxIndex) / 2;
    id itemAtMidIndex = [array objectAtIndex:midIndex];

    NSComparisonResult comparison = [item compare:itemAtMidIndex];

    if (comparison == NSOrderedSame) {
        return midIndex;
    } else if (comparison == NSOrderedAscending) {
        return [self searchIndexInArray:array targetItem:item minIndex:minIndex maxIndex:midIndex - 1];
    } else {
        return [self searchIndexInArray:array targetItem:item minIndex:midIndex + 1 maxIndex:maxIndex];
    }
}

@end
