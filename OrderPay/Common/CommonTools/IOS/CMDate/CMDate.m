//
//  CMDate.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMDate.h"

static NSString * ft_DefaultCalendarIdentifier = nil;
static NSLock * ft_DefaultCalendarIdentifierLock = nil;
static dispatch_once_t ft_DefaultCalendarIdentifierLock_onceToken;


NSDateComponents* _dateComponent(FTDateComponentFlag flag, NSDate *date, NSInteger value)
{
    NSDateComponents *dateComponents;
    if(date == nil) {
        dateComponents = [[NSDateComponents alloc] init];
    }
    else{
        NSInteger flags = NSCalendarUnitEra | NSCalendarUnitQuarter |  NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay;
        dateComponents = [[CMDate ft_currentCalendar] components:flags fromDate:date];
    }
    
    // Dates
    switch (flag) {
        case CMDateComponentFlagNone:
            break;
        case CMDateComponentFlagMonth:
            dateComponents.month = value;
            break;
        case CMDateComponentFlagEra:
            dateComponents.era = value;
            break;
        case CMDateComponentFlagYear:
            dateComponents.year = value;
            break;
        case CMDateComponentFlagDay:
            dateComponents.day = value;
            break;
        case CMDateComponentFlagSecond:
            dateComponents.second = value;
            break;
        case CMDateComponentFlagMinute:
            dateComponents.minute = value;
            break;
        case CMDateComponentFlagHour:
            dateComponents.hour = value;
            break;
        case CMDateComponentFlagWeek:
            dateComponents.weekOfYear = value;
            break;
        case CMDateComponentFlagQuarter:
            dateComponents.quarter = value;
            break;
    }
    
    return dateComponents;
}


NSDate* _dateSet(NSDate *date, FTDateComponentFlag flag, NSInteger value)
{
    if (date == nil){
        date = [NSDate date];
    }
    NSDateComponents *dateComponents = _dateComponent(flag, date, value);
    return [[CMDate ft_currentCalendar] dateFromComponents:dateComponents];
}

NSDate* _dateAdd(NSDate *date, FTDateComponentFlag flag, NSInteger value)
{
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateComponents *dateComponents = _dateComponent(flag, nil, value);
    return [[CMDate ft_currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
}

@implementation CMDate

+ (NSCalendar*)ft_currentCalendar
{
    NSString *key = @"ft_currentCalendar_";
    NSString *calendarIdentifier = [self ft_defaultCalendarIdentifier];
    
    if (calendarIdentifier) {
        key = [key stringByAppendingString:calendarIdentifier];
    }
    else{
        key = [key stringByAppendingString:[[NSCalendar currentCalendar] calendarIdentifier]];
    }
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *currentCalendar = [dictionary objectForKey:key];
    if (currentCalendar == nil) {
        if (calendarIdentifier == nil) {
            currentCalendar = [NSCalendar currentCalendar];
        }
        else {
            currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:calendarIdentifier];
            NSAssert(currentCalendar != nil, @"calendarIdentifier is invalid.");
        }
        [dictionary setObject:currentCalendar forKey:key];
    }
    return currentCalendar;
}

+ (NSString*)ft_defaultCalendarIdentifier
{
    dispatch_once(&ft_DefaultCalendarIdentifierLock_onceToken, ^{
        ft_DefaultCalendarIdentifierLock = [[NSLock alloc] init];
    });
    NSString *string;
    [ft_DefaultCalendarIdentifierLock lock];
    string = ft_DefaultCalendarIdentifier;
    [ft_DefaultCalendarIdentifierLock unlock];
    return string;
}

+ (void)ft_setDefaultCalendarIdentifier:(NSString *)calendarIdentifier
{
    dispatch_once(&ft_DefaultCalendarIdentifierLock_onceToken, ^{
        ft_DefaultCalendarIdentifierLock = [[NSLock alloc] init];
    });
    [ft_DefaultCalendarIdentifierLock lock];
    ft_DefaultCalendarIdentifier = calendarIdentifier;
    [ft_DefaultCalendarIdentifierLock unlock];
}

/*get current date*/
+ (NSDate*)date
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

/*tranfer for local date*/
+ (NSString*)tranferToLocalDate:(NSDate*)object
{
    NSCalendar *cal = [self ft_currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    
    
    NSString *string = [formatter stringFromDate:object];
    return string;
}

/*string to date*/
+ (NSDate*)dateWithString:(NSString *)string format:(NSString*)strFormat
{
    NSCalendar *cal = [self ft_currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:strFormat];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSDate *date = [formatter dateFromString:string];
    return date;
}

/*date to string*/
+ (NSString*)stringWithDate:(NSDate*)date format:(NSString*)strFormat
{
    NSCalendar *cal = [self ft_currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:strFormat];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSString* strDate = [formatter stringFromDate:date];
    return strDate;
}

/*the custom date from string*/
+ (NSString *)prefixStringFromDate:(NSDate*)date
{
    NSTimeInterval timeDiffrence = [date minutesAfterDate:[NSDate date]];
    NSString *preStr = nil;
    NSString *resultStr = nil;
    
    if (timeDiffrence < 10) {
        resultStr = @"刚刚";
    }
    else if (timeDiffrence < 60) {
        resultStr = [NSString stringWithFormat:@"%@秒前",@(timeDiffrence)];
    }
    else if (timeDiffrence < 60*60) {
        resultStr = [NSString stringWithFormat:@"%@分钟前", @(timeDiffrence/60)];
    }
    else if ([date isToday]) {
        preStr = @"今天";
        resultStr = [NSString stringWithFormat:@"%@ %@",preStr,[CMDate stringWithDate:date format:@"HH:mm"]];
    }
    else if ([date isYesterday]){
        preStr = @"昨天";
        resultStr = [NSString stringWithFormat:@"%@ %@",preStr,[CMDate stringWithDate:date format:@"HH:mm"]];
    }
    else if ([date isThisYear]){
        resultStr = [CMDate stringWithDate:date format:@"MM-dd HH:mm"];
    }
    else{
        resultStr = [CMDate stringWithDate:date format:@"yyyy-MM-dd HH:mm"];
    }
    
    return resultStr;
}
@end

@implementation NSDate (Escort)
@dynamic hour,minute,second,era,year,month,week,weekday,today,leapYear,day,weekOfMonth;

+ (NSDate *)dateTomorrow
{
    return [NSDate dateWithDaysAfterNow:1];
}

+ (NSDate *)dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithDaysAfterNow:(NSInteger)dDays
{
    return [[NSDate date] dateByAddingDays:dDays];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)dDays
{
    return [[NSDate date] dateByAddingDays:-dDays];
}

+ (NSDate *)dateWithHoursAfterNow:(NSInteger)dHours
{
    return [[NSDate date] dateByAddingHours:dHours];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours
{
    return [[NSDate date] dateByAddingHours:-dHours];
}

+ (NSDate *)dateWithMinutesAfterNow:(NSInteger)dMinutes
{
    return [[NSDate date] dateByAddingMinutes:-dMinutes];
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    return [[NSDate date] dateByAddingMinutes:-dMinutes];
}

+ (BOOL)isLeapYear:(NSInteger)year
{
    return ((year % 100 != 0) && (year % 4 == 0)) || year % 400 == 0;
}

- (BOOL)isSameDay:(NSDate *)date
{
    NSDateComponents *otherDay = _dateComponent(CMDateComponentFlagNone, self, 0);
    NSDateComponents *today = _dateComponent(CMDateComponentFlagNone, date, 0);
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (NSInteger)hour
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitHour fromDate:self];
    return comp.hour;
}

- (NSInteger)weekOfMonth
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
    return comp.weekOfMonth;
}

- (NSInteger)minute
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    return comp.minute;
}

- (NSInteger)second
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    return comp.second;
}

- (NSInteger)week
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
    return comp.weekOfYear;
}

- (NSInteger)weekday
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    return comp.weekday;
}

- (NSInteger)year
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return comp.year;
}

- (NSInteger)quarter
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitQuarter fromDate:self];
    return comp.quarter;
}

- (NSInteger)day
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return comp.day;
}

- (NSInteger)era
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitEra fromDate:self];
    return comp.era;
}

- (NSInteger)month
{
    NSDateComponents *comp = [[CMDate ft_currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return comp.month;
}

- (BOOL)isToday
{
    return [self isSameDay:[NSDate date]];
}

- (BOOL)isTomorrow
{
    return [self isSameDay:[[NSDate date] dateByAddingDays:1]];
}

- (BOOL)isYesterday
{
    return [self isSameDay:[[NSDate date] dateByAddingDays:-1]];
}


- (BOOL)isInCurrentWeek
{
    NSDate *cd = [NSDate date];
    return (cd.era == self.era && cd.week == self.week && cd.year == self.year);
}

- (BOOL)isLeapYear
{
    return [self.class isLeapYear:self.year];
}

- (NSDate *)dateByAddingComponents:(NSDateComponentsBlock)block
{
    if (block == nil) {
        return [self dateByAddingDays:0];
    }
    NSDateComponents *comp = _dateComponent(CMDateComponentFlagNone, nil, 0);
    block(comp);
    return [[CMDate ft_currentCalendar] dateByAddingComponents:comp toDate:self options:0];
}

- (NSDate *)dateBySettingComponents:(NSDateComponentsBlock)block
{
    if (block == nil) {
        return [self dateByAddingDays:0];
    }
    NSDateComponents *comp = _dateComponent(CMDateComponentFlagNone, self, 0);
    block(comp);
    return [[CMDate ft_currentCalendar] dateFromComponents:comp];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    return _dateAdd(self, CMDateComponentFlagHour, hours);
}

- (NSDate *)dateBySettingHours:(NSInteger)hours
{
    return _dateSet(self, CMDateComponentFlagHour, hours);
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    return _dateAdd(self, CMDateComponentFlagMinute, minutes);
}

- (NSDate *)dateBySettingMinutes:(NSInteger)minutes
{
    return _dateSet(self, CMDateComponentFlagMinute, minutes);
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    return _dateAdd(self, CMDateComponentFlagSecond, seconds);
}

- (NSDate *)dateBySettingSeconds:(NSInteger)seconds
{
    return _dateSet(self, CMDateComponentFlagSecond, seconds);
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    return _dateAdd(self, CMDateComponentFlagDay, days);
}

- (NSDate *)dateBySettingDays:(NSInteger)days
{
    return _dateSet(self, CMDateComponentFlagDay, days);
}

- (NSDate *)dateBySettingWeekDay:(NSInteger)weekday
{
    return _dateSet(self, CMDateComponentFlagDay, self.day - (self.weekday - weekday));
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    return _dateAdd(self, CMDateComponentFlagWeek, weeks);
}

- (NSDate *)dateBySettingWeeks:(NSInteger)weeks
{
    return _dateSet(self, CMDateComponentFlagWeek, weeks);
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    return _dateAdd(self, CMDateComponentFlagMonth, months);
}

- (NSDate *)dateBySettingMonths:(NSInteger)months
{
    return _dateSet(self, CMDateComponentFlagMonth, months);
}

- (NSDate *)dateByAddingYears:(NSInteger)years
{
    return _dateAdd(self, CMDateComponentFlagYear, years);
}

- (NSDate *)dateBySettingYears:(NSInteger)years
{
    return _dateSet(self, CMDateComponentFlagYear, years);
}

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters
{
    return _dateAdd(self, CMDateComponentFlagQuarter, quarters);
}

- (NSDate *)dateBySettingQuarters:(NSInteger)quarters
{
    return _dateSet(self, CMDateComponentFlagQuarter, quarters);
}

- (NSDate *)dateByAddingEras:(NSInteger)eras
{
    return _dateAdd(self, CMDateComponentFlagEra, eras);
}

- (NSDate *)dateBySettingEras:(NSInteger)eras
{
    return _dateSet(self, CMDateComponentFlagEra, eras);
}

- (NSInteger)secondsAfterDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitSecond fromDate:aDate toDate:self options:0];
    return [components minute];
}

- (NSInteger)secondsBeforeDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitSecond fromDate:self toDate:aDate options:0];
    return [components minute];
}

- (NSInteger)minutesAfterDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitMinute fromDate:aDate toDate:self options:0];
    return [components minute];
}

- (NSInteger)minutesBeforeDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitMinute fromDate:self toDate:aDate options:0];
    return [components minute];
}

- (NSInteger)hoursAfterDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitHour fromDate:aDate toDate:self options:0];
    return [components hour];
}

- (NSInteger)hoursBeforeDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitHour fromDate:self toDate:aDate options:0];
    return [components hour];
}

- (NSInteger)daysAfterDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitDay fromDate:aDate toDate:self options:0];
    return [components day];
}

- (NSInteger)daysBeforeDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [components day];
}

- (NSInteger)monthsAfterDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitMonth fromDate:aDate toDate:self options:0];
    return [components month];
}

- (NSInteger)monthsBeforeDate:(NSDate*)aDate
{
    NSDateComponents *components = [[CMDate ft_currentCalendar] components:NSCalendarUnitMonth fromDate:self toDate:aDate options:0];
    return [components month];
}

- (NSDate *)dateOfFirstDayOfFirstWeekForWeekDay:(NSInteger)weekday
{
    NSDate *date = [self dateBySettingComponents:^(NSDateComponents *comp) {
        comp.hour = 0;
        comp.minute = 0;
        comp.second = 0;
        comp.day = 1;
    }];
    NSInteger dif = [date weekday] - weekday;
    if (dif < 0) {
        dif += 7;
    }
    return [date dateByAddingDays:-dif];
}

- (BOOL)isBetweenDates:(NSDate *)beginDate andDate:(NSDate *)endDate
{
    if ([self compare:beginDate] == NSOrderedAscending) {
        return NO;
    }
    
    if ([self compare:endDate] == NSOrderedDescending) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isBeyondBeforeOneYear:(NSDate*)date
{
    NSDate* currentDate = [NSDate date];
    NSDate* beforeDate = [currentDate dateByAddingYears:-1];
    beforeDate = [beforeDate dateByAddingDays:-1];
    return ![self isBetweenDates:beforeDate andDate:currentDate];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfDaysInWeek
{
    return [[CMDate ft_currentCalendar] maximumRangeOfUnit:NSCalendarUnitWeekday].length;
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate*)otherDate
{
    NSCalendar *currentCalendar = [CMDate ft_currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components1 = [currentCalendar components:unitFlags fromDate:self];
    NSDateComponents *components2 = [currentCalendar components:unitFlags fromDate:otherDate];
    return (components1.era == components2.era) &&
    (components1.year == components2.year) &&
    (components1.month == components2.month) &&
    (components1.day == components2.day);
}

- (BOOL)isSameWeekAsDate:(NSDate*)aDate
{
    NSCalendar *calendar = [CMDate ft_currentCalendar];
    NSInteger leftWeekday = self.weekday + ((self.weekday < calendar.firstWeekday) ? 7 : 0);
    NSDate *left = [self dateByAddingDays:leftWeekday];
    NSInteger rightWeekday = aDate.weekday + ((aDate.weekday < calendar.firstWeekday) ? 7 : 0);
    NSDate *right = [aDate dateByAddingDays:-rightWeekday];
    return [left isEqualToDateIgnoringTime:right];
}

- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
    NSDate *nextWeek = [NSDate dateWithDaysAfterNow:[self numberOfDaysInWeek]];
    return [self isSameWeekAsDate:nextWeek];
}

- (BOOL)isLastWeek
{
    NSDate *lastWeek = [NSDate dateWithDaysBeforeNow:[self numberOfDaysInWeek]];
    return [self isSameWeekAsDate:lastWeek];
}

- (BOOL)isSameMonthAsDate:(NSDate*)aDate
{
    NSCalendar *calendar = [CMDate ft_currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *componentsArgs = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return (componentsSelf.era == componentsArgs.era && componentsSelf.year == componentsArgs.year && componentsSelf.month == componentsArgs.month);
}

- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isSameYearAsDate:(NSDate*)aDate
{
    NSCalendar *calendar = [CMDate ft_currentCalendar];
    NSDateComponents *componentsSelf = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:self];
    NSDateComponents *componentsArgs = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:aDate];
    return (componentsSelf.era == componentsArgs.era && componentsSelf.year == componentsArgs.year);
}

- (BOOL)isThisYear
{
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear
{
    NSDate *nextYear = [[NSDate date] dateByAddingYears:1];
    return [self isSameYearAsDate:nextYear];
}

- (BOOL)isLastYear
{
    NSDate *lastYear = [[NSDate date] dateByAddingYears:-1];
    return [self isSameYearAsDate:lastYear];
}

- (BOOL)isEarlierThanDate:(NSDate*)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate*)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isEarlierThanOrEqualDate:(NSDate*)aDate
{
    NSComparisonResult comparisonResult = [self compare:aDate];
    return (comparisonResult == NSOrderedAscending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isLaterThanOrEqualDate:(NSDate*)aDate
{
    NSComparisonResult comparisonResult = [self compare:aDate];
    return (comparisonResult == NSOrderedDescending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isInPast
{
    return [self isEarlierThanDate:[NSDate date]];
}

- (BOOL)isInFuture
{
    return [self isLaterThanDate:[NSDate date]];
}

- (BOOL)isTypicallyWorkday
{
    return ([self isTypicallyWeekend] == NO);
}

- (BOOL)isTypicallyWeekend
{
    NSCalendar *calendar = [CMDate ft_currentCalendar];
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekdayOfDate = [components weekday];
    return (weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.location + weekdayRange.length - 1);
}
@end

