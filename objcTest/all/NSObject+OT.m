//
//  NSObject+OT.m
//  objcTest
//
//  Created by Jey on 6/12/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "NSObject+OT.h"
#import <objc/runtime.h>

@implementation NSObject (OT)
+ (void)mk_swizzle:(SEL)aSelector {
    SEL bSelector = NSSelectorFromString([NSString stringWithFormat:@"mk_%@", NSStringFromSelector(aSelector)]);
    
    Method m1 = class_getInstanceMethod(self, aSelector);
    Method m2 = class_getInstanceMethod(self, bSelector);
    
    method_exchangeImplementations(m1, m2);
}

+ (void)mk_class_swizzle:(SEL)aSelector {
    SEL bSelector = NSSelectorFromString([NSString stringWithFormat:@"mk_%@", NSStringFromSelector(aSelector)]);
    
    Method m1 = class_getClassMethod(self, aSelector);
    Method m2 = class_getClassMethod(self, bSelector);
    
    method_exchangeImplementations(m1, m2);
}
@end
