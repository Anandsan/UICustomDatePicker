//
//  NSShortMonthComponent.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSShortMonthComponent.h"
#import "NSBaseDateComponent+Private.h"

@implementation NSShortMonthComponent

- (NSArray *) getElementsForCurrentSelectedDate:(NSDate *) selectedDate {
    
    NSDateComponents *selectedDateComponents = [self getDateComponentsForDate:selectedDate];
    NSDateComponents *fromDateComponents = [self getDateComponentsForDate:self.minDate];
    NSDateComponents *toDateComponents = [self getDateComponentsForDate:self.maxDate];
    
    
    NSUInteger minMonth = 1;
    NSUInteger maxMonth = 12;
    if (selectedDateComponents.year == fromDateComponents.year ) {
        minMonth = fromDateComponents.month;
    }

    if (selectedDateComponents.year == toDateComponents.year) {
        maxMonth = toDateComponents.month;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    // lower limit
    if (minMonth != 1) {
        [array addObjectsFromArray:[self getComponetElements:1 toEndValue:minMonth -1 status:NO]];
    }
    
    [array addObjectsFromArray:[self getComponetElements:minMonth toEndValue:maxMonth status:YES]];
    
    // uper limit
    if (maxMonth != 12) {
        [array addObjectsFromArray:[self getComponetElements:maxMonth + 1 toEndValue:12 status:NO]];
    }

    return [NSArray arrayWithArray:array];
}

- (NSString *) getValueForDate:(NSDate *) date {
    NSUInteger value = [[self getDateComponentsForDate:date] month];
    return [self getStringForValue:value];
}

- (NSString *) getStringForValue:(NSUInteger) value {
    return [NSString stringWithFormat:@"%lu", (long) value];
}

- (NSDate *) updateDate:(NSDate *) date {
    
    NSDateComponents *dateComponents = [self getDateComponentsForDate:date];
    dateComponents.month =  self.selectedIndex + 1;
    NSDate *newDate = [self getDateForDateComponents:dateComponents];
    while (newDate == nil) {
        dateComponents.day -= 1;
        newDate = [self getDateForDateComponents:dateComponents];
    }
    return newDate;
}

@end
