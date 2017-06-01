//
//  ViewController.m
//  Runtime
//
//  Created by Kristina on 6/1/17.
//  Copyright © 2017 Krystyna Havrylenko. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        if (attr[i] == '@') {
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
