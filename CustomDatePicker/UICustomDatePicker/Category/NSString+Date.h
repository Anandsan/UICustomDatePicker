//
//  NSString+Date.h
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (Date)

-(NSDate*)dateValueForFormatString:(NSString *) formatString;
@end
