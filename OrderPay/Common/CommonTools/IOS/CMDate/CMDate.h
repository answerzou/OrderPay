//
//  CMDate.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, FTDateComponentFlag) {
    CMDateComponentFlagNone = 0,
    CMDateComponentFlagMonth,
    CMDateComponentFlagDay,
    CMDateComponentFlagQuarter,
    CMDateComponentFlagWeek,
    CMDateComponentFlagYear,
    CMDateComponentFlagMinute,
    CMDateComponentFlagHour,
    CMDateComponentFlagSecond,
    CMDateComponentFlagEra
};
typedef void (^NSDateComponentsBlock)(NSDateComponents *comp);

@interface CMDate : NSObject
+ (NSCalendar*)ft_currentCalendar;
+ (NSString *)ft_defaultCalendarIdentifier;
+ (void)ft_setDefaultCalendarIdentifier:(NSString *)calendarIdentifier;

/**
 *reference:get current local date
 *parameters:null
 *return:NSDate object
 */
+ (NSDate*)date;

/**
 *reference:tranfer for local date(default:yyyy-MM-dd HH:mm:ss)
 *parameters:object(source date)
 *return:date string
 */
+ (NSString*)tranferToLocalDate:(NSDate*)object;

/**
 *reference:string to local date
 *parameters:string(date string),format:(MM/dd/yyyy,yyyy/MM/dd HH:mm:ss,yyyy-MM-dd HH:mm:ss)
 *return:NSDate object
 */
+ (NSDate*)dateWithString:(NSString *)string format:(NSString*)strFormat;

/**
 *reference:date from string
 *parameters:date(date),format:(MM/dd/yyyy,yyyy/MM/dd HH:mm:ss,yyyy-MM-dd HH:mm:ss)
 *return:date string
 */
+ (NSString*)stringWithDate:(NSDate*)date format:(NSString*)strFormat;

/**
 *reference:The custom date from NSDate
 *parameters:date(date)
 *return:yes or no
 */
+ (NSString*)prefixStringFromDate:(NSDate*)date;
@end

@interface NSDate (Escort)

@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger week;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger era;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly, getter=isToday) BOOL today;
@property (nonatomic, readonly, getter=isTomorrow) BOOL tomorrow;
@property (nonatomic, readonly, getter=isYesterday) BOOL yesterday;
@property (nonatomic, readonly, getter=isInCurrentWeek) BOOL inCurrentWeek;
@property (nonatomic, readonly, getter=isLeapYear) BOOL leapYear;

+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysAfterNow:(NSInteger)dDays;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)dDays;
+ (NSDate *)dateWithHoursAfterNow:(NSInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithMinutesAfterNow:(NSInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;


+ (BOOL)isLeapYear:(NSInteger)year;
- (BOOL)isSameDay:(NSDate *)date;
- (BOOL)isEqualToDateIgnoringTime:(NSDate *) otherDate;
- (BOOL)isSameWeekAsDate:(NSDate *) aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *) aDate;
- (BOOL)isThisMonth;
- (BOOL)isSameYearAsDate:(NSDate *) aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *) aDate;
- (BOOL)isLaterThanDate:(NSDate *) aDate;
- (BOOL)isEarlierThanOrEqualDate:(NSDate *) aDate;
- (BOOL)isLaterThanOrEqualDate:(NSDate *) aDate;
- (BOOL)isInFuture;
- (BOOL)isInPast;
- (BOOL)isTypicallyWorkday;
- (BOOL)isTypicallyWeekend;


- (NSDate *)dateByAddingComponents:(NSDateComponentsBlock)block;
- (NSDate *)dateBySettingComponents:(NSDateComponentsBlock)block;

- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySettingHours:(NSInteger)hours;

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySettingMinutes:(NSInteger)minutes;

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)dateBySettingSeconds:(NSInteger)seconds;

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateBySettingWeeks:(NSInteger)weeks;

- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySettingDays:(NSInteger)days;

- (NSDate *)dateBySettingWeekDay:(NSInteger)weekday;

- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateBySettingMonths:(NSInteger)months;

- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateBySettingYears:(NSInteger)years;

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters;
- (NSDate *)dateBySettingQuarters:(NSInteger)quarters;

- (NSDate *)dateByAddingEras:(NSInteger)eras;
- (NSDate *)dateBySettingEras:(NSInteger)eras;

- (NSInteger)secondsAfterDate:(NSDate*)aDate;
- (NSInteger)secondsBeforeDate:(NSDate*)aDate;
- (NSInteger)minutesAfterDate:(NSDate*)aDate;
- (NSInteger)minutesBeforeDate:(NSDate*)aDate;
- (NSInteger)hoursAfterDate:(NSDate*)aDate;
- (NSInteger)hoursBeforeDate:(NSDate*)aDate;
- (NSInteger)daysAfterDate:(NSDate*)aDate;
- (NSInteger)daysBeforeDate:(NSDate*)aDate;
- (NSInteger)monthsAfterDate:(NSDate*)aDate;

- (NSInteger)monthsBeforeDate:(NSDate *) aDate;

- (NSDate *)dateOfFirstDayOfFirstWeekForWeekDay:(NSInteger)weekday;
- (BOOL)isBetweenDates:(NSDate *)beginDate andDate:(NSDate *)endDate;
- (BOOL)isBeyondBeforeOneYear:(NSDate*)date;
@end
