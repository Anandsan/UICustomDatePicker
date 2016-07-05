//
//  NSDateElement.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSDateElement.h"

@implementation NSDateElement

-(id) init {
    self = [super init];
    if (self) {
        self.status = NO;
        self.displayValue = nil;
    }
    return self;
}

@end
