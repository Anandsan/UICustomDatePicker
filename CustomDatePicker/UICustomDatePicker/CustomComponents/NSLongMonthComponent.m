//
//  NSLongMonthComponent.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSLongMonthComponent.h"


@implementation NSLongMonthComponent

-(NSArray *)monthNames {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    return [dateFormatter standaloneMonthSymbols];
}

- (BOOL) isNumber {
    return NO;
}

@end
