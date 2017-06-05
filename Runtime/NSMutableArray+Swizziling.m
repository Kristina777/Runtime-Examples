//
//  NSMutableArray+Swizziling.m
//  Runtime
//
//  Created by Kristina on 6/2/17.
//  Copyright © 2017 Krystyna Havrylenko. All rights reserved.
//

#import "NSMutableArray+Swizziling.h"
#import <objc/message.h>

@implementation NSMutableArray (Swizziling)

- (void)logAddObject:(id)aObject {
    [self logAddObject:aObject];
    NSLog(@" \n %@", aObject);
}

+ (void)load {
    Method addObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), NSSelectorFromString(@"addObject:"));
    Method logAddObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(logAddObject:));
    method_exchangeImplementations(addObject, logAddObject);
}

@end
