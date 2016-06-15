//
//  OTView.m
//  objcTest
//
//  Created by Jey on 6/12/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "UIView+OT.h"
#import "NSObject+OT.h"

@implementation UIView (OT)
+ (void)load {
    [self mk_swizzle:@selector(hitTest:withEvent:)];
    [self mk_swizzle:@selector(pointInside:withEvent:)];
}

- (nullable UIView *)mk_hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"--view(%@:%p:%ld)", self.class, self, self.tag);
    UIView *v = [self mk_hitTest:point withEvent:event];
//    if (v.tag == 300) {
//        v = nil;
//    }
//    if (self.tag == 301) {
//        v = self;
//    }
    NSLog(@"==view(%@:%p:%ld), hitTest:(%p) tag: %ld", self.class, self, self.tag, v, (long)v.tag);
    return v;
}

- (BOOL)mk_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"~~view(%@:%p:%ld)", self.class, self, self.tag);
    BOOL v = [self mk_pointInside:point withEvent:event];
//    if (self.tag == 200) {
//        v = NO;
//    }
    NSLog(@"==view(%@:%p:%ld), %d", self.class, self, self.tag, v);
    return v;
}

@end
