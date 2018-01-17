//
//  HTCalendar.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 16.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCalendarDay.h"

@interface HTCalendar : NSObject

@property (nonatomic) NSInteger currentDayIndex;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithStartDate:(NSString *)startDateString finishDate:(NSString *)finishDateString andDateFormat:(NSString *)dateFormatString;
- (HTCalendarDay *)calendarDayByIndex:(NSInteger)dayIndex;
- (NSInteger)countCalendarDays;

@end
