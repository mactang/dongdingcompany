//
//  CalendarManager.h
//  NoteBook2.0_UI
//
//  Created by Dracula on 14-2-20.
//  Copyright (c) 2014年 Dracula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarManager : NSObject{
    NSCalendar *calendar;
}
@property (nonatomic,retain)NSCalendar *calendar;

- (NSString *)stringFromDate:(NSDate *)date WithFormat:(NSString*)format;
- (NSDate *)dateFromString:(NSString *)dateString WithFormat:(NSString*)format;
- (int)dayOfWeekForDate:(NSDate *)date;
- (int)weekNumberInMonthForDate:(NSDate *)date;
- (int)dayNumberInMonthForDate:(NSDate *)date;
- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date;
- (NSDate *)nextDay:(NSDate *)date;
- (BOOL)dateIsToday:(NSDate *)date;
- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

@end
