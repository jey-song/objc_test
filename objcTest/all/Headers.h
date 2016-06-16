



#define OTLog(f, ...) NSLog(@"%s<%d>: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(f), ##__VA_ARGS__])


#import "Test.h"

#import "Binary.h"
#import "MaxEarnings.h"
#import "GCDTest.h"
#import "UIView+OT.h"
#import "MsgSend.h"
#import "NSObject+OT.h"
#import "ThreadTest.h"
