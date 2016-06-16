//
//  ThreadTest.m
//  objcTest
//
//  Created by Jey on 6/16/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "Headers.h"
#import "pthread/pthread.h"

static void *pthreadRun(void *data) {
    OTLog(@"run thread : p_thread, %p", [NSRunLoop currentRunLoop]);
    return 0;
}

@implementation ThreadTest

- (void)dealloc {
}

- (void)testCreate {
    // 1.
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"normal"];
    [thread start];
    
    // 2.
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"detach"];
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"detach1"];
    
    // 3.
    [self performSelectorInBackground:@selector(run:) withObject:@"object_back_run"];
    [self performSelectorInBackground:@selector(run:) withObject:@"object_back_run1"];

    // 4.
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 执行任务
    [queue addOperationWithBlock:^{
        OTLog(@"operation block thread : %p", [NSRunLoop currentRunLoop]);
    }];
    
    queue.maxConcurrentOperationCount = 1;
    NSInvocationOperation *invation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run:) object:@"opration queue operate"];
    [queue addOperation:invation];
    
    // 5.
    dispatch_queue_t gcdQueue = dispatch_queue_create([[NSString stringWithFormat:@"test.%@", self] UTF8String], NULL);
    // 执行任务
    dispatch_async(gcdQueue, ^{
        OTLog(@"gcd block thread");
    });
    
    // 6.
    pthread_t pthread;
    int retval = pthread_create(&pthread, NULL, pthreadRun, (__bridge void *)(self));
    if (retval) {
        OTLog(@"error: %d", retval);
    }
    
}

- (void)run:(id)t {
    OTLog(@"run thread : %@, %p", t, [NSRunLoop currentRunLoop]);
}

@end
