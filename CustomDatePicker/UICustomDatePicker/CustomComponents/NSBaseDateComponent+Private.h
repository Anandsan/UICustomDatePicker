//
//  NSBaseDateComponent+Private.h
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSBaseDateComponent.h"

@interface NSBaseDateComponent (Private)

@property (nonatomic, strong, readonly) NSDate *minDate;
@property (nonatomic, strong, readonly) NSDate *maxDate;

- (NSDateComponents *) getDateComponentsForDate:(NSDate *) date;
- (NSDate *) getDateForDateComponents:(NSDateComponents *) components;
- (NSArray *) getComponetElements:(NSUInteger) startValue toEndValue:(NSUInteger) endValue status:(BOOL) status;
- (NSString *) getStringForValue:(NSUInteger) value;

@end
