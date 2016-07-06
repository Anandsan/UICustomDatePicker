//
//  ViewController.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//

#import "ViewController.h"
#import "UICustomDatePicker.h"
#import "NSString+Date.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UICustomDatePicker *customDatePicker;
@property (nonatomic, weak) IBOutlet UICustomDatePicker *customDatePicker2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCustomDatePicker:self.customDatePicker withOption:NSCustomDatePickerOptionLongMonth | NSCustomDatePickerOptionYear | NSCustomDatePickerOptionDay andOrder:NSCustomDatePickerOrderDayMonthAndYear];
    [self initCustomDatePicker:self.customDatePicker2 withOption:NSCustomDatePickerOptionLongMonth | NSCustomDatePickerOptionYear  andOrder:NSCustomDatePickerOrderMonthDayAndYear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initCustomDatePicker:(UICustomDatePicker *) picker withOption:(NSUInteger) option andOrder:(NSUInteger) order {
    picker.minDate = [[NSString stringWithFormat:@"06/July/2016"] dateValueForFormatString:@"dd/MMM/yyyy"];
    picker.maxDate = [[NSString stringWithFormat:@"06/Aug/2022"] dateValueForFormatString:@"dd/MMM/yyyy"];
    picker.currentDate = [NSDate date];
    picker.order = order;
    picker.option = option;
}


- (IBAction)didCustomDatePickerValueChanged:(id)sender {
    NSLog(@"%@",[(UICustomDatePicker *)sender currentDate]);
}

@end
