//
//  NSString+Date.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSString+Date.h"

@implementation NSString (Date)

-(NSDate*)dateValueForFormatString:(NSString *) formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:self];
}

@end
