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
    
    NSArray *testNames = @[@"Binary",@"MaxEarnings",@"GCDTest",@"Test"];
    
    for (NSString *name in testNames) {
        Test *t = [[NSClassFromString(name) alloc] init];
        [self.tests addObject:t];
    }
    return YES;
}

@end
