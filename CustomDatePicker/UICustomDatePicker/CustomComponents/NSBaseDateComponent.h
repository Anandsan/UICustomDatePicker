//
//  NSBaseDateComponent.h
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSBaseDateComponent : NSObject

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign, readonly) BOOL isNumber;

- (void) setupComponentForCurrentSelectedDate:(NSDate *) selectedDate minDate:(NSDate *) minDate maxDate:(NSDate *) maxDate;
- (NSArray *) getElementsForCurrentSelectedDate:(NSDate *) selectedDate;

- (BOOL) statusForIndex:(NSUInteger) index;
- (NSString *) valueForIndex:(NSUInteger) index;
- (NSUInteger) indexForValue:(NSString *) value;
- (NSUInteger) nearByActiveValue:(NSString *) value;

- (NSUInteger) getIndexForDate:(NSDate *) date;
- (NSString *) getValueForDate:(NSDate *) date;

- (NSDate *) updateDate:(NSDate *) date;

@end
