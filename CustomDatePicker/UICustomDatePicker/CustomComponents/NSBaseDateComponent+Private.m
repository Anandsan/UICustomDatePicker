//
//  NSBaseDateComponent+Private.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSBaseDateComponent+Private.h"
#import "NSDateElement.h"
#import "NSObject+Array.h"
#import "NSString+Date.h"

@implementation NSBaseDateComponent (Private)
@dynamic minDate,maxDate;

- (NSArray *) getComponetElements:(NSUInteger) startValue toEndValue:(NSUInteger) endValue status:(BOOL) status{
    NSMutableArray *array = [NSMutableArray array];
    for(NSInteger value = startValue; value <= endValue; value++) {
        NSDateElement *dateElement = [[NSDateElement alloc] init];
        dateElement.displayValue = [self getStringForValue:value];
        dateElement.status = status;
        [dateElement addToArray:array];
    }
    return [NSArray arrayWithArray:array];
}

- (NSDateComponents *) getDateComponentsForDate:(NSDate *) date {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
}

- (NSDate *) getDateForDateComponents:(NSDateComponents *) components {
    NSString *string = [NSString stringWithFormat:@"%02lu/%02lu/%04lu", (long)components.month, (long)components.day, (long)components.year];
    return [string dateValueForFormatString:@"MM/dd/yyyy"];
}
- (NSString *) getStringForValue:(NSUInteger) value {
    return nil;
}

@end
