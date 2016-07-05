//
//  NSBaseDateComponent.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSBaseDateComponent.h"
#import "NSDateElement.h"


@interface NSBaseDateComponent()

@property (nonatomic, strong) NSArray *dateElements;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;

@end

@implementation NSBaseDateComponent

- (NSUInteger) count {
    return self.dateElements.count;
}

- (void) setupComponentForCurrentSelectedDate:(NSDate *) selectedDate minDate:(NSDate *) minDate maxDate:(NSDate *) maxDate {
    self.minDate = minDate;
    self.maxDate = maxDate;
    self.dateElements = [self getElementsForCurrentSelectedDate:selectedDate];
}


- (NSString *) valueForIndex:(NSUInteger) index {
    NSDateElement *element = [self.dateElements objectAtIndex:index];
    return element.displayValue;
}

- (BOOL) statusForIndex:(NSUInteger) index {
    NSDateElement *element = [self.dateElements objectAtIndex:index];
    return element.status;
}

- (NSUInteger) indexForValue:(NSString *) value {
    NSUInteger index = NSUIntegerMax;
    NSUInteger counter = 0;
    for (NSDateElement *element in self.dateElements) {
        if ([element.displayValue isEqualToString:value]) {
            index = counter;
            break;
        }
        ++counter;
    }
    
    return index;
}

- (NSUInteger) nearByActiveValue:(NSString *) value {
    NSUInteger index = NSUIntegerMax;
    NSUInteger counter = 0;
    BOOL foundFlag = NO;
    for (NSDateElement *dateElement in self.dateElements){
        if (dateElement.status) {
            index = counter;
            // In case already visited the element then get the nearst nest active element
            if (foundFlag) {
                break;
            }
        }
        if ([dateElement.displayValue isEqualToString:value]) {
            if (dateElement.status) {
                index = counter;
                break;
            }
            foundFlag = YES;
        }
        ++counter;
    }
    
    return  index;
}

- (NSArray *) getElementsForCurrentSelectedDate:(NSDate *) selectedDate{
    return nil;
}

- (NSUInteger) getIndexForDate:(NSDate *) date {
    NSString *value= [self getValueForDate:date];
    NSUInteger index = NSIntegerMax;
    NSUInteger counter = 0;
    for (NSDateElement *element in self.dateElements){
        if ([element.displayValue isEqualToString:value]) {
            index = counter;
            break;
        }
        ++counter;
    }
    return  index;
}

- (NSString *) getValueForDate:(NSDate *) date {
    return nil;
}

- (NSDate *) updateDate:(NSDate *) date {
    return nil;
}

- (BOOL) isNumber {
    return YES;
}
@end
