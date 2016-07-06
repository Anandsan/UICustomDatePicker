//
//  NSYearComponent.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//

#import "NSYearComponent.h"
#import "NSBaseDateComponent+Private.h"

@interface NSYearComponent()

@property (nonatomic, assign) NSInteger startyear;
@property (nonatomic, assign) NSInteger endyear;

@end

@implementation NSYearComponent

- (NSArray *) getElementsForCurrentSelectedDate:(NSDate *) selectedDate {
    NSInteger minYear = 1;
    NSInteger maxYear =  9999;
    
    if (self.minDate) {
        minYear = [[self getDateComponentsForDate:self.minDate] year];
    }
    
    if (self.maxDate) {
        maxYear = [[self getDateComponentsForDate:self.maxDate] year];
    }
    
    self.startyear = minYear - 100;
    self.endyear = maxYear + 100;
    
    if (self.startyear < 1) {
        self.startyear = 1;
    }
    
    if (self.endyear > 9999) {
        self.endyear = 9999;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    // lower limit
    if (minYear != self.startyear) {
        [array addObjectsFromArray:[self getComponetElements:self.startyear toEndValue:minYear -1 status:NO]];
    }
    
    [array addObjectsFromArray:[self getComponetElements:minYear toEndValue:maxYear status:YES]];
    
    // uper limit
    if (maxYear != self.endyear) {
        [array addObjectsFromArray:[self getComponetElements:maxYear + 1 toEndValue:self.endyear status:NO]];
    }
    
    return [NSArray arrayWithArray:array];
}

- (NSString *) getValueForDate:(NSDate *) date {
    NSUInteger value = [[self getDateComponentsForDate:date] year];
    return [self getStringForValue:value];
}

- (NSString *) getStringForValue:(NSUInteger) value {
    return [NSString stringWithFormat:@"%4lu", (long) value];
}

- (NSDate *) updateDate:(NSDate *) date {
    NSDateComponents *dateComponents = [self getDateComponentsForDate:date];
    dateComponents.year =  self.startyear + self.selectedIndex;
    NSDate *newDate = [self getDateForDateComponents:dateComponents];
    
    return newDate;
}

@end
