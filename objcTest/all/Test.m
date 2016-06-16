//
//  Test.m
//  objcTest
//
//  Created by Jey on 6/5/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "Headers.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Test
- (instancetype)init {
    self = [super init];

    if (self) {
        [self performSelector:@selector(runAllTest) withObject:nil afterDelay:0];
    }

    return self;
}

- (void)runAllTest {
    if (self.ignoreTests
        || [self isMemberOfClass:[Test class]]) {
        return;
    }
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(self.class, &methodCount);
    
    OTLog(@"Found all methods(%d) on '%s'\n", methodCount, class_getName(self.class));
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        const char *nc = sel_getName(method_getName(method));
        //const char *type = method_getTypeEncoding(method);
        
        NSString *name = [NSString stringWithUTF8String:nc];
        if ([name hasPrefix:@"test"]) {
            typedef void (*send_type)(void *, SEL, int);
            send_type func = (send_type)objc_msgSend;
            func((__bridge void *)(self), NSSelectorFromString(name), 0);
        }
    }
    
    free(methods);
}

- (void)dealloc {
    OTLog(@"[dealloc : %p]", self);
}

@end
