//
//  HTCalendarDay.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 16.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTCalendarDay : NSObject

@property (copy, nonatomic, readonly) NSString *shortDayOfWeekNameString;
@property (nonatomic, readonly) NSString * dayOfMonthString;
@property (nonatomic, readonly) NSString* yearString;
@property (nonatomic, readonly) NSInteger dayOfMonth;
@property (nonatomic, readonly) NSInteger year;
@property (strong, nonatomic, readonly) NSDate *currentDate;
@property (nonatomic, readonly) BOOL isCurrentDate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDate:(NSDate *)currentDate;

@end
