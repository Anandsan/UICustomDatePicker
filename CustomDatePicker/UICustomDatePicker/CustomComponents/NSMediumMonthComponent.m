//
//  NSMediumMonthComponent.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//

#import "NSMediumMonthComponent.h"

@interface NSMediumMonthComponent()

@property (nonatomic, strong) NSArray *monthArray;

@end
@implementation NSMediumMonthComponent

-(id) init {
    self = [super init];
    if (self) {
        self.monthArray = [self monthArray];
    }
    return self;
}

-(NSArray *)monthNames {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    return [dateFormatter shortStandaloneMonthSymbols];
}

- (NSString *) getStringForValue:(NSUInteger) value {
    return [self.monthNames objectAtIndex:value-1];
}

- (BOOL) isNumber {
    return NO;
}

@end
