//
//  GCDTest.m
//  objcTest
//
//  Created by Jey on 6/1/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "GCDTest.h"

@interface GCDTest () {
    dispatch_source_t _timer;
}

@end

@implementation GCDTest
- (instancetype)init {
    self = [super init];
    if (self) {
        self.ignoreTests = YES;
    }
    return self;
}

- (void)testRunloop {
    NSLog(@"main runloop: %p", [NSRunLoop mainRunLoop]);
    // 1.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"dispatch main runloop: %p", [NSRunLoop currentRunLoop]);
    });

    // 2.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"global_queue runloop: %p", [NSRunLoop currentRunLoop]);
    });

    // 3.
    dispatch_queue_t queue = dispatch_queue_create([[NSString stringWithFormat:@"test.%@", self] UTF8String], NULL);
    //[NSTimer scheduledTimerWithTimeInterval:2 target:weakself selector:@selector(timer:) userInfo:@{@"runloop": [NSRunLoop currentRunLoop]} repeats:YES];
    dispatch_sync(queue, ^{
        NSLog(@"global_queue runloop: %p", [NSRunLoop currentRunLoop]);
        NSAssert([NSRunLoop currentRunLoop] == [NSRunLoop mainRunLoop], @"test_queue sync runloop: %p", [NSRunLoop currentRunLoop]);
    });

    // 4.
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2), 2ull * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            // this block does not called
            NSLog(@"temp timer_queue runloop: %p", [NSRunLoop currentRunLoop]);
            //dispatch_cancel(timer);
        });
        dispatch_resume(timer);
    }

    // 5.
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }

    if (_timer) {
        __weak dispatch_source_t t = _timer;
        dispatch_source_set_timer(t, dispatch_walltime(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2), 2ull * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
        dispatch_source_set_event_handler(t, ^{
            NSLog(@"global timer_queue runloop: %p", [NSRunLoop currentRunLoop]);
            dispatch_cancel(t);
        });
        dispatch_resume(_timer);
    }

    // 6.
    __weak __typeof(self) weakself = self;
    dispatch_async(queue, ^{
        [NSTimer scheduledTimerWithTimeInterval:2 target:weakself selector:@selector(timer:) userInfo:@{ @"runloop": [NSRunLoop currentRunLoop] } repeats:NO];
        //NSLog(@"global_queue runloop: %@", [NSRunLoop currentRunLoop]);
        NSAssert([NSRunLoop currentRunLoop] != [NSRunLoop mainRunLoop], @"test_queue async runloop: %p", [NSRunLoop currentRunLoop]);
    });
}

- (void)timer:(NSTimer *)t {
    //NSLog(@"test_queue1 timer runloop: %p", [NSRunLoop currentRunLoop]);
}

@end
