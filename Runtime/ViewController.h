//
//  ViewController.h
//  Runtime
//
//  Created by Kristina on 6/1/17.
//  Copyright © 2017 Krystyna Havrylenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/objc.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController : UIViewController

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *secondName;
@property (strong, nonatomic) NSNumber *year;

@end

