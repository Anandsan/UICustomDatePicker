//
//  NSDayComponent.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSDayComponent.h"
#import "NSBaseDateComponent+Private.h"

@implementation NSDayComponent

- (NSDate *) getLastDateForGivenDate:(NSDate *) date {
    NSDateComponents *components = [self getDateComponentsForDate:date];
    components.month += 1;
    components.day = 0;

    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSArray *) getElementsForCurrentSelectedDate:(NSDate *) selectedDate {
    
    NSDateComponents *selectedDateComponents = [self getDateComponentsForDate:selectedDate];
    NSDateComponents *fromDateComponents = [self getDateComponentsForDate:self.minDate];
    NSDateComponents *toDateComponents = [self getDateComponentsForDate:self.maxDate];
    NSDateComponents *lastDateComponents = [self getDateComponentsForDate:[self getLastDateForGivenDate:selectedDate]];
    
    
    NSUInteger minDay = 1;
    NSUInteger maxDay = 31;
    if (selectedDateComponents.year == fromDateComponents.year  && selectedDateComponents.month == fromDateComponents.month) {
        minDay = fromDateComponents.day;
    }
    
    if (selectedDateComponents.year == toDateComponents.year && selectedDateComponents.month == toDateComponents.month) {
        maxDay = toDateComponents.day;
    }

    if (maxDay > lastDateComponents.day) {
        maxDay = lastDateComponents.day;
    }

    
    NSMutableArray *array = [NSMutableArray array];
    // lower limit
    if (minDay != 1) {
        [array addObjectsFromArray:[self getComponetElements:1 toEndValue:minDay -1 status:NO]];
    }
    
    [array addObjectsFromArray:[self getComponetElements:minDay toEndValue:maxDay status:YES]];
    
    // uper limit
    if (maxDay != 31) {
        [array addObjectsFromArray:[self getComponetElements:maxDay + 1 toEndValue:31 status:NO]];
    }
    
    return [NSArray arrayWithArray:array];
}

- (NSString *) getValueForDate:(NSDate *) date {
    NSUInteger value = [[self getDateComponentsForDate:date] day];
    return [self getStringForValue:value];
}

- (NSString *) getStringForValue:(NSUInteger) value {
    return [NSString stringWithFormat:@"%lu", (long) value];
}


- (NSDate *) updateDate:(NSDate *) date {
    
    NSDateComponents *dateComponents = [self getDateComponentsForDate:date];
    dateComponents.day =  [[self valueForIndex:self.selectedIndex] integerValue];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar dateFromComponents:dateComponents];
}

@end
