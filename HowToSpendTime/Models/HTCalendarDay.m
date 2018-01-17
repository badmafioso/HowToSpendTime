//
//  HTCalendarDay.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 16.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTCalendarDay.h"

@implementation HTCalendarDay

- (instancetype)initWithDate:(NSDate *)currentDate {
    self = [super init];
    
    if (!self) { return nil; }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"E"];
    
    _shortDayOfWeekNameString = [NSString stringWithFormat:@"%@.", [dateFormatter stringFromDate:currentDate]];
    
    [dateFormatter setDateFormat:@"d"];
    
    _dayOfMonth       = [[dateFormatter stringFromDate:currentDate] integerValue];
    _dayOfMonthString = [dateFormatter stringFromDate:currentDate];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    _year       = [[dateFormatter stringFromDate:currentDate] integerValue];
    _yearString = [dateFormatter stringFromDate:currentDate];
    
    _currentDate = currentDate;
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *dateNow = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    
    NSComparisonResult dateCompareResult = [dateNow compare:currentDate];
    if (dateCompareResult == NSOrderedSame) {
        _isCurrentDate = YES;
    }
    
    return self;
}

@end
