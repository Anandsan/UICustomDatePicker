//
//  UICustomDatePicker.m
//  CustomDatePicker
//
//  Created by Anand Sankaran on 7/5/16.
//  Copyright © 2016 Anand Sankaran. All rights reserved.
//

#import "UICustomDatePicker.h"
#import "NSShortMonthComponent.h"
#import "NSMediumMonthComponent.h"
#import "NSLongMonthComponent.h"
#import "NSYearComponent.h"
#import "NSDayComponent.h"
#import "NSObject+Array.h"
#import "NSString+Date.h"


@interface UICustomDatePicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@property (nonatomic, strong) NSArray *componentOrderArray;
@property (nonatomic, strong) NSArray *componentsWidth;
@property (nonatomic, strong) NSArray *componentsHeight;


@end

@implementation UICustomDatePicker

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self load];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self load];
    }
    return self;
}



- (void) load {
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"UICustomDatePicker" owner:self options:nil] firstObject];
    [self addSubview:view];
    view.frame = self.bounds;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    self.currentDate = [NSDate date];
    self.order = NSCustomDatePickerOrderDayMonthAndYear;
    self.option = NSCustomDatePickerOptionDay | NSCustomDatePickerOptionLongMonth | NSCustomDatePickerOptionYear;
    
}

#pragma mark - local methods

- (NSBaseDateComponent *) componetForOption:(NSCustomDatePickerOption) option {
    NSBaseDateComponent *component = nil;
    switch (option) {
        case NSCustomDatePickerOptionDay:
            component = [[NSDayComponent alloc] init];
            break;
        case NSCustomDatePickerOptionShortMonth:
            component = [[NSShortMonthComponent alloc] init];
            break;
        case NSCustomDatePickerOptionMediumMonth:
            component = [[NSMediumMonthComponent alloc] init];
            break;
        case NSCustomDatePickerOptionLongMonth:
            component = [[NSLongMonthComponent alloc] init];
            break;
        case NSCustomDatePickerOptionYear:
            component = [[NSYearComponent alloc] init];
            break;
        default:
            break;
    }
    return component;
}

- (NSUInteger) getMonthOption:(NSUInteger) option {
    NSUInteger monthOption = 0;
    if (option & NSCustomDatePickerOptionLongMonth) {
        monthOption = NSCustomDatePickerOptionLongMonth;
    } else if (option & NSCustomDatePickerOptionMediumMonth) {
        monthOption = NSCustomDatePickerOptionMediumMonth;
    } else if (option & NSCustomDatePickerOptionShortMonth) {
        monthOption = NSCustomDatePickerOptionShortMonth;
    }
    return monthOption;
}

- (NSArray *) getComponentsWithOption:(NSUInteger) option andOrder:(NSCustomDatePickerOrder) order {
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger monthOption = [self getMonthOption:option];
    NSUInteger yearOption = option & NSCustomDatePickerOptionYear;
    NSUInteger dayOption = option & NSCustomDatePickerOptionDay;
    
    switch (order) {
        case NSCustomDatePickerOrderDayMonthAndYear:
            [[self componetForOption:dayOption] addToArray:array];
            [[self componetForOption:monthOption] addToArray:array];
            [[self componetForOption:yearOption] addToArray:array];
            break;
        case NSCustomDatePickerOrderMonthDayAndYear:
            [[self componetForOption:monthOption] addToArray:array];
            [[self componetForOption:dayOption] addToArray:array];
            [[self componetForOption:yearOption] addToArray:array];
            break;
        case NSCustomDatePickerOrderYearMonthAndDay:
            [[self componetForOption:yearOption] addToArray:array];
            [[self componetForOption:monthOption] addToArray:array];
            [[self componetForOption:dayOption] addToArray:array];
            break;
        default:
            [array addObjectsFromArray:[self getCustomComponentsWithOption:option andOrder:order]];
            break;
    }
    return [NSArray arrayWithArray:array];
}


- (NSArray *) getCustomComponentsWithOption:(NSUInteger)option andOrder:(NSCustomDatePickerOrder)order {
    return nil;
}


-(void) initComponent {
    self.componentOrderArray = [self getComponentsWithOption:self.option andOrder:self.order];
    if (self.minDate == nil) {
        self.minDate = [[NSString stringWithFormat:@"01/Jun/0001"] dateValueForFormatString:@"dd/MMM/yyyy"];
    }
    if (self.maxDate == nil) {
        self.maxDate = [[NSString stringWithFormat:@"31/Dec/9999"] dateValueForFormatString:@"dd/MMM/yyyy"];
    }
    for ( NSBaseDateComponent *component in self.componentOrderArray ) {
        [component setupComponentForCurrentSelectedDate:self.currentDate minDate:self.minDate maxDate:self.maxDate];
    }
    
    self.componentsWidth = [self getComponentsWidth:self.componentOrderArray];
    self.componentsHeight = [self getComponentsHeight:self.componentOrderArray];
    
}

- (NSArray *) getComponentsWidth:(NSArray *) components {
    NSMutableArray *array  = [NSMutableArray array];
    CGFloat totalWidth = 0.0;
    for ( NSBaseDateComponent *component in components ) {
        CGFloat width = [self getWidthForComponent:component];
        totalWidth += width;
        [array addObject:[[NSNumber alloc] initWithFloat:width]];
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    CGFloat viewWidth = self.frame.size.width;
    viewWidth -= array.count * 5;
    for (NSNumber *number in array) {
        CGFloat width = number.floatValue/totalWidth * viewWidth;
        [tempArray addObject:[[NSNumber alloc] initWithFloat:width]];
    }
    
    return [NSArray arrayWithArray:tempArray];
}

- (NSArray *) getComponentsHeight:(NSArray *) components {
    NSMutableArray *array  = [NSMutableArray array];
    for ( NSBaseDateComponent *component in components ) {
        [array addObject:[[NSNumber alloc] initWithFloat:[self getHeightForComponent:component]]];
    }
    
    return [NSArray arrayWithArray:array];
}

- (CGFloat) getHeightForComponent:(NSBaseDateComponent *) component {
    CGFloat height = 0.0;
    for(NSUInteger index = 0; index < component.count; ++index) {
        NSString *string = [component valueForIndex:index];
        
        CGRect expectedRect = [string boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]} context:nil];
        if (height < expectedRect.size.height) {
            height = expectedRect.size.height;
        }
    }
    return height;
}

- (CGFloat) getWidthForComponent:(NSBaseDateComponent *) component {
    CGFloat width = 0.0;
    for(NSUInteger index = 0; index < component.count; ++index) {
        NSString *string = [component valueForIndex:index];
        
        CGRect expectedRect = [string boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]} context:nil];
        if (width < expectedRect.size.width) {
            width = expectedRect.size.width;
        }
    }
    return width;
}


- (void) updateDate:(NSDate *) date forSelectedComponent:(NSBaseDateComponent *) dateComponent {
    self.currentDate = date;
    
    if ([self.currentDate compare:self.minDate] == NSOrderedAscending) {
        self.currentDate = self.minDate;
    } else if ([self.currentDate compare:self.maxDate] == NSOrderedDescending) {
        self.currentDate = self.maxDate;
    }
    
    NSUInteger index = 0;
    for (NSBaseDateComponent *dComponent in self.componentOrderArray) {
        if (dateComponent != dComponent) {
            [dComponent setupComponentForCurrentSelectedDate:self.currentDate minDate:self.minDate maxDate:self.maxDate];
            [self.pickerView reloadComponent:index];
            NSInteger rowIndex = [dComponent nearByActiveValue:[dComponent valueForIndex:dComponent.selectedIndex]];
            if (rowIndex != dComponent.selectedIndex) {
                dComponent.selectedIndex = rowIndex;
                [self.pickerView selectRow:rowIndex inComponent:index animated:YES];
            }
        }
        ++index;
    }
    [self updateSelection];
}

- (void) updateSelection {
    NSDate *date = self.currentDate;
    for (NSBaseDateComponent *dComponent in self.componentOrderArray) {
        date = [dComponent updateDate:date];
    }
    
    self.currentDate = date;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - public methods
-(void) reload {
    [self initComponent];
    [self.pickerView reloadAllComponents];
    NSUInteger index = 0;
    for (NSBaseDateComponent *component in self.componentOrderArray) {
        [self.pickerView selectRow:[component getIndexForDate:self.currentDate] inComponent:index animated:NO];
        ++index;
    }
    
    [self updateDate:self.currentDate forSelectedComponent:nil];
    
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self reload];
}

#pragma mark - UIPickerViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [[self.componentsWidth objectAtIndex:component] floatValue];
}

-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.componentsHeight.count > component? [[self.componentsHeight objectAtIndex:component] floatValue]:0;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSBaseDateComponent *dateComponent = [self.componentOrderArray objectAtIndex:component];
    if ([dateComponent statusForIndex:row] == NO) {
        NSUInteger rowIndex = [dateComponent nearByActiveValue:[dateComponent valueForIndex:row]];
        if (rowIndex != NSUIntegerMax) {
            [self.pickerView selectRow:rowIndex inComponent:component animated:YES];
        }
        dateComponent.selectedIndex = rowIndex;
    } else {
        
        dateComponent.selectedIndex = row;
    }
    [self updateDate:[dateComponent updateDate:self.currentDate] forSelectedComponent:dateComponent];
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, [[self.componentsWidth objectAtIndex:component] floatValue], [[self.componentsHeight objectAtIndex:component] floatValue]);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
        [pickerLabel setTextColor:[UIColor darkTextColor]];
    }
    
    @try {
        NSBaseDateComponent *dateComponent = [self.componentOrderArray objectAtIndex:component];
        [pickerLabel setTextColor:[dateComponent statusForIndex:row]?[UIColor darkTextColor]: [UIColor lightTextColor]];
        
        [pickerLabel setText:[dateComponent valueForIndex:row]];
        
        if (dateComponent.isNumber) {
            [pickerLabel setTextAlignment:NSTextAlignmentRight];
        } else {
            [pickerLabel setTextAlignment:NSTextAlignmentLeft];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"Exception occured %@",exception);
    }
    return pickerLabel;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.componentOrderArray.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self.componentOrderArray objectAtIndex:component] count];
}

@end
