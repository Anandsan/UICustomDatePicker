//
//  UICustomDatePicker.h
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NSCustomDatePickerOrder) {
    
    NSCustomDatePickerOrderDayMonthAndYear,  //01 Jan 2016
    NSCustomDatePickerOrderMonthDayAndYear, //Jan 01 2016
    NSCustomDatePickerOrderYearMonthAndDay, //2016 Jan 01
    
};

typedef NS_ENUM(NSUInteger, NSCustomDatePickerOption) {
    //Consider the day as Jan 20 2016
    NSCustomDatePickerOptionDay = 0x1,              // 20
    NSCustomDatePickerOptionShortMonth = 0x10,      // 01
    NSCustomDatePickerOptionMediumMonth = 0x100,    // Jan
    NSCustomDatePickerOptionLongMonth = 0x1000,     // January
    NSCustomDatePickerOptionYear = 0x100000,    // 2016
};

IB_DESIGNABLE
@interface UICustomDatePicker : UIControl

@property (nonatomic, assign) IBInspectable CGFloat fontSize;

@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, assign) NSCustomDatePickerOrder order;
@property (nonatomic, assign) NSUInteger option;
@property (nonatomic, strong) NSDate *currentDate;


- (NSArray *) getCustomComponentsWithOption:(NSUInteger) option andOrder:(NSCustomDatePickerOrder) order;
-(void) reload;
@end
