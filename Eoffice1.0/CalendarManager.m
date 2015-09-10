//
//  CalendarManager.m
//  NoteBook2.0_UI
//
//  Created by Dracula on 14-2-20.
//  Copyright (c) 2014年 Dracula. All rights reserved.
//

#import "CalendarManager.h"


@implementation CalendarManager
@synthesize calendar = _calendar;

NSDateFormatter *dateFormatter;

- (id)init{
    self = [super init];
    if (self) {
        NSCalendar *myCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        [self.calendar setLocale:[NSLocale currentLocale]];
        [self.calendar setTimeZone:[NSTimeZone systemTimeZone]];
        [self.calendar setMinimumDaysInFirstWeek:1];
        [self.calendar setFirstWeekday:2];
        self.calendar = myCalendar;
    }
    return self;
}


- (NSString *)stringFromDate:(NSDate *)date WithFormat:(NSString*)format{
    
    if (!date) {
        return nil;
    }
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    if (![dateFormatter.dateFormat isEqualToString:format]) {
        [dateFormatter setDateFormat:format];
    }
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
}


- (NSDate *)dateFromString:(NSString *)dateString WithFormat:(NSString*)format{
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    if (![dateFormatter.dateFormat isEqualToString:format]) {
        [dateFormatter setDateFormat:format];
    }
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}


- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}

- (int)dayNumberInMonthForDate:(NSDate *)date {
    NSRange days = [self.calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSMonthCalendarUnit
                                      forDate:date];
    return days.length;
}

- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}

- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

- (BOOL)dateIsToday:(NSDate *)date {
    NSDateComponents *otherDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

-(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [self.calendar components:unitFlags fromDate:date1];
    
    NSDateComponents* comp2 = [self.calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    
    [comp1 month] == [comp2 month] &&
    
    [comp1 year]  == [comp2 year];
    
}

- (void)dealloc{
    
    self.calendar = nil;
    
}

@end
