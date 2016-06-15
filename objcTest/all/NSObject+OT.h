//
//  NSObject+OT.h
//  objcTest
//
//  Created by Jey on 6/12/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OT)
+ (void)mk_swizzle:(SEL)aSelector;// mk_origin_method
+ (void)mk_class_swizzle:(SEL)aSelector;// mk_origin_method
@end
