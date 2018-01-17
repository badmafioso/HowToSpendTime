//
//  HTCalendar.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 16.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTCalendar.h"

@interface HTCalendar()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSArray <HTCalendarDay *>*calendarDays;


@end

@implementation HTCalendar

- (instancetype)initWithStartDate:(NSString *)startDateString finishDate:(NSString *)finishDateString andDateFormat:(NSString *)dateFormatString {
    self = [super init];
    
    if (!self) { return nil; }
    
    _dateFormatter            = [[NSDateFormatter alloc] init];
    _dateFormatter.dateFormat = dateFormatString;
    _calendarDays             = [self calendarDaysOfMonthFromStartDate:startDateString toFinishDate:finishDateString];
    
    return self;
}

- (NSArray <HTCalendarDay *>*)calendarDaysOfMonthFromStartDate:(NSString *)startDateString toFinishDate:(NSString *)finishDateString {
    NSMutableArray *daysArray = [NSMutableArray array];
    
    NSDate *startDate  = [self.dateFormatter dateFromString:startDateString];
    NSDate *finishDate = [self.dateFormatter dateFromString:finishDateString];
    
    NSComparisonResult dateCompareResult = [startDate compare:finishDate];
    
    [daysArray addObject:startDate];
    if (dateCompareResult == NSOrderedAscending) {
        do {
            startDate = [startDate dateByAddingTimeInterval:1*60*60*24];
            
            startDateString = [self.dateFormatter stringFromDate:startDate];
            
            [daysArray addObject:startDate];
            
            dateCompareResult = [startDate compare:finishDate];
        } while (dateCompareResult == NSOrderedAscending);
    }
    
    [daysArray sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray *calendarDaysArray = [NSMutableArray array];
    
    NSInteger dayIndex = 0;
    for (NSDate *currentDate in daysArray) {
        HTCalendarDay *calendarDay = [[HTCalendarDay alloc] initWithDate:currentDate];
        
        if (calendarDay.isCurrentDate) {
            self.currentDayIndex = dayIndex;
        }
        
        [calendarDaysArray addObject:calendarDay];
        
        dayIndex++;
    }
    
    return [calendarDaysArray copy];
}

- (HTCalendarDay *)calendarDayByIndex:(NSInteger)dayIndex {
    return [self.calendarDays objectAtIndex:dayIndex];
}

- (NSInteger)countCalendarDays {
    return self.calendarDays.count;
}

@end
