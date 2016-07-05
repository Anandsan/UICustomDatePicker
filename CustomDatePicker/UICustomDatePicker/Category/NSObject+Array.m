//
//  NSObject+Array.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//


#import "NSObject+Array.h"

@implementation NSObject (Array)

-(void) addToArray:(NSMutableArray *)array {
    [array addObject:self];
}

@end
