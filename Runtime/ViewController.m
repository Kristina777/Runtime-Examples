//
//  ViewController.m
//  Runtime
//
//  Created by Kristina on 6/1/17.
//  Copyright © 2017 Krystyna Havrylenko. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "NSMutableArray+Swizziling.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstName = @"FirstName";

    NSString *low = [self.firstName lowercaseString];
    NSLog(@"%@", low);
    NSString *upp = [self.firstName uppercaseString];
    NSLog(@"%@", upp);
    
//    Method addObject = class_getInstanceMethod([NSMutableArray class], @selector(addObject:));
//    Method logAddObject = class_getInstanceMethod([NSMutableArray class], @selector(logAddObject:));
//    method_exchangeImplementations(addObject, logAddObject);
    
     low = [self.firstName lowercaseString];
    NSLog(@"%@", low);
    upp = [self.firstName uppercaseString];
    NSLog(@"%@", upp);

//    self.secondName = @"SecondName";
//    self.year = @23;
//    NSLog(@"%@", [self description]);
//
//    SecondViewController *secondViewController = [[SecondViewController alloc] init];
//    secondViewController.name = @"Name";
//    secondViewController.someTitle = @"SomeTitle";
//    secondViewController.quantity = @55;
//    NSLog(@"%@", [secondViewController description]);
//
//    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//    [mutableArray addObject:@"first"];
//    [mutableArray addObject:@"second"];
//    [mutableArray addObject:@"third"];
}

//RUNTIME exaple for description method
//https://habrahabr.ru/post/177421/

- (NSString *)description {
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int i;
    unsigned int* propertyCount = &i;
    objc_property_t *properties = class_copyPropertyList([self class], propertyCount);
    
    for (unsigned int i = 0; i < *propertyCount; i++) {
        char const *propertyName = property_getName(properties[i]);
        const char *attr = property_getAttributes(properties[i]);
        
        if (attr[i + 1] == '@') {
            NSString *selector = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
            SEL sel = sel_registerName([selector UTF8String]);
            // id result = ((id (*)(id, SEL))objc_msgSend)(self, sel);
            NSObject *propertyValue = ((NSObject *(*)(UIViewController *, SEL))objc_msgSend)(self, sel);
            propertyValues[selector] = propertyValue.description;
        }
    }
    
    free(properties);
    return [NSString stringWithFormat:@"%@: %@", self.class, propertyValues];
}

@end


#pragma mark - Swizzling
