//
//  AppDelegate.m
//  objcTest
//
//  Created by Jey on 6/1/16.
//  Copyright © 2016 jey. All rights reserved.
//

#import "AppDelegate.h"
#import "Headers.h"
@interface AppDelegate ()
@property (nonatomic, strong) NSMutableArray *tests;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.tests = [NSMutableArray array];
    
    NSArray *testNames = @[@"Binary",@"MaxEarnings",@"MsgSend",@"GCDTest",@"NSObject+OT",@"Test",@"UIView+OT"];
    
    for (NSString *name in testNames) {
        NSObject *t = [[NSClassFromString(name) alloc] init];
        if ([t isKindOfClass:[Test class]]) {
            [self.tests addObject:t];
        }
    }
    return YES;
}

@end
