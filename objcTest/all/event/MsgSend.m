//
//  MsgSend.m
//  objcTest
//
//  Created by Jey on 6/12/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "Headers.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (MSG_SEND)

@end

@implementation NSObject (MSG_SEND)
+ (void)load {
//    if (0) {
//        [self mk_class_swizzle:@selector(resolveClassMethod:)];
//        [self mk_class_swizzle:@selector(resolveInstanceMethod:)];
//        [self mk_class_swizzle:@selector(instancesRespondToSelector:)];
//        [self mk_class_swizzle:@selector(instanceMethodForSelector:)];
//        [self mk_swizzle:@selector(methodForSelector:)];
//        [self mk_swizzle:@selector(doesNotRecognizeSelector:)];
//        [self mk_swizzle:@selector(forwardingTargetForSelector:)];
//        [self mk_swizzle:@selector(forwardInvocation:)];
//        [self mk_swizzle:@selector(methodSignatureForSelector:)];
////        [self mk_swizzle:@selector(allowsWeakReference)];
////        [self mk_swizzle:@selector(retainWeakReference)];
//        [self mk_class_swizzle:@selector(instanceMethodSignatureForSelector:)];
//    }
}

+ (BOOL)mk_instancesRespondToSelector:(SEL)aSelector {
    BOOL v = [self mk_instancesRespondToSelector:aSelector];
    OTLog(@"class(%@:%p:%s), value(%d)", self.class, self, __FUNCTION__, v);
    return v;
}
- (IMP)mk_methodForSelector:(SEL)aSelector {
    IMP imp = [self mk_methodForSelector:aSelector];
    OTLog(@"class(%@:%p:%s), value(%p)", self.class, self, __FUNCTION__, imp);
    return imp;
}
+ (IMP)mk_instanceMethodForSelector:(SEL)aSelector {
    IMP imp = [self mk_instanceMethodForSelector:aSelector];
    OTLog(@"class(%@:%p:%s), value(%p)", self.class, self, __FUNCTION__, imp);
    return imp;
}

- (void)mk_doesNotRecognizeSelector:(SEL)aSelector {
    [self mk_doesNotRecognizeSelector:aSelector];
    OTLog(@"class(%@:%p:%s),", self.class, self, __FUNCTION__);
}

- (id)mk_forwardingTargetForSelector:(SEL)aSelector {
    id sign = [self mk_forwardingTargetForSelector:aSelector];
    OTLog(@"class(%@:%p:%s), value(%@)", self.class, self, __FUNCTION__, sign);
    return sign;
}

- (void)mk_forwardInvocation:(NSInvocation *)anInvocation {
    [self mk_forwardInvocation:anInvocation];
    OTLog(@"class(%@:%p:%s),", self.class, self, __FUNCTION__);
}

- (NSMethodSignature *)mk_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [self mk_methodSignatureForSelector:aSelector];
    OTLog(@"class(%@:%p:%s), value(%@)", self.class, self, __FUNCTION__, sign);
    return sign;
}

+ (NSMethodSignature *)mk_instanceMethodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [self mk_instanceMethodSignatureForSelector:aSelector];
    OTLog(@"class(%@:%p:%s), value(%@)", self.class, self, __FUNCTION__, sign);
    return sign;
}

// cannot swizzle
//- (BOOL)mk_allowsWeakReference {
//    BOOL v = [self mk_allowsWeakReference];
//    OTLog(@"class(%@:%p:%s), value(%d)", self.class, self, __FUNCTION__, v);
//    return v;
//}
//
//- (BOOL)mk_retainWeakReference {
//    BOOL v = [self mk_retainWeakReference];
//    OTLog(@"class(%@:%p:%s), value(%d)", self.class, self, __FUNCTION__, v);
//    return v;
//}


+ (BOOL)mk_resolveClassMethod:(SEL)name {
    BOOL v = [self mk_resolveClassMethod:name];
    OTLog(@"class(%@:%p:%s), %@, value(%d)", self.class, self, __FUNCTION__, NSStringFromSelector(name), v);
    return v;
}

+ (BOOL)mk_resolveInstanceMethod:(SEL)sel {
    BOOL v = [self mk_resolveInstanceMethod:sel];
    OTLog(@"class(%@:%p:%s), %@, value(%d)", self.class, self, __FUNCTION__, NSStringFromSelector(sel), v);
    return v;
}

@end





@interface OTObject : NSObject
- (void)superMethod:(int)tag;
- (void)superVirtualMethod:(int)tag;
@end

@implementation OTObject
- (void)superMethod:(int)tag {
    OTLog(@"--super method(%@) imp, tag: (%d)", NSStringFromSelector(_cmd), tag);
}
/****************************** runtime add ***********************************/
+ (BOOL)resolveInstanceMethod:(SEL)name {
    if (name == @selector(superVirtualMethod:)) {
        IMP imp = [self instanceMethodForSelector:@selector(superMethod:)];
        class_addMethod([self class], name, (IMP) imp, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:name];
}
/****************************** runtime add ***********************************/
@end


@interface OTSubObject : OTObject
@end

@implementation OTSubObject
/****************************** forward ***************************************/
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(superVirtualMethod:)) {
//        return self;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}
////+ (BOOL)instancesRespondToSelector:(SEL)aSelector {}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if (aSelector == @selector(superVirtualMethod:)) {
//        aSelector = @selector(superMethod:);
//    }
//    NSMethodSignature *sign = [super methodSignatureForSelector:aSelector];
//    return sign;
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation {
//    if (invocation.selector == @selector(superVirtualMethod:)) {
//        [invocation setSelector:@selector(superMethod:)];
//        [invocation invoke];
//    }
//}
//- (BOOL)respondsToSelector:(SEL)aSelector {
//    if (aSelector == @selector(superVirtualMethod:)) {
//        return YES;
//    }
//    return [super respondsToSelector:aSelector];
//}
/****************************** forward ***************************************/

// 避免消息分发

@end


@implementation MsgSend

- (BOOL)ignoreTests {
    return YES;
}

- (void)testMessage {
    OTSubObject *obj = [[OTSubObject alloc] init];
    
    
    BOOL v = [obj respondsToSelector:@selector(superVirtualMethod:)];
    OTLog(@"====%d", v);
    [obj superVirtualMethod:1];
    
    ((void * (*)(id, SEL, int))objc_msgSend)((id)obj, @selector(superMethod:), 2);
    
    //[obj superMethod];
}

@end
