# UICustomDatePicker

This Custom Date picker component is used to  customize the date picker option. 

##Date Picker Option
> NSCustomDatePickerOption

    //Consider the day as Jan 20 2016
    NSCustomDatePickerOptionDay = 0x1,              // 20
    NSCustomDatePickerOptionShortMonth = 0x10,      // 01
    NSCustomDatePickerOptionMediumMonth = 0x100,    // Jan
    NSCustomDatePickerOptionLongMonth = 0x1000,     // January
    NSCustomDatePickerOptionYear = 0x100000,    // 2016

###31 Jan 2016
>customDatePicker.option = NSCustomDatePickerOptionDay | NSCustomDatePickerOptionMediumMonth | NSCustomDatePickerOptionYear; 

###31 January 2016
>customDatePicker.option = NSCustomDatePickerOptionDay | NSCustomDatePickerOptionLongMonth | NSCustomDatePickerOptionYear; 

###Jan 2016
>customDatePicker.option =  NSCustomDatePickerOptionMediumMonth | NSCustomDatePickerOptionYear; 

###January 2016
>customDatePicker.option =  NSCustomDatePickerOptionLongMonth | NSCustomDatePickerOptionYear; 

###1 2016
>customDatePicker.option =  NSCustomDatePickerOptionShortMonth | NSCustomDatePickerOptionYear; 

##Date Picker Order
>NSCustomDatePickerOrder
    
    NSCustomDatePickerOrderDayMonthAndYear,  //01 Jan 2016
    NSCustomDatePickerOrderMonthDayAndYear, //Jan 01 2016
    NSCustomDatePickerOrderYearMonthAndDay, //2016 Jan 01

### 1 Jan 2016
> customDatePikcer.order = NSCustomDatePickerOrderDayMonthAndYear

### Jan 1 2016
> customDatePikcer.order = NSCustomDatePickerOrderMonthDayAndYear

### 2016 Jan 1
> customDatePikcer.order = NSCustomDatePickerOrderYearMonthAndDay


