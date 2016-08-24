//
//  UserDefaultTest.m
//  objcTest
//
//  Created by jey on 8/24/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "UserDefaultTest.h"
#import "Headers.h"

@implementation UserDefaultTest
- (void)dealloc {
}

- (void)testCacheInMemeroy {
    NSString *s = @"sssss";
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:@"key"];
    OTLog(@"===s: %p", s);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    id n = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    id p = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    OTLog(@"===n: %p, %@", n, n);
    OTLog(@"===n: %p, p: %p, (n==p) : %d", n, p, n == p);// 有内存缓存
}

- (void)testCacheInMemeroy_1 {
    id n = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    OTLog(@"===s: %p, %@", n, n);
}

@end
