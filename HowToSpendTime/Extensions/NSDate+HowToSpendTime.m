//
//  NSDate+HowToSpendTime.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 08.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "NSDate+HowToSpendTime.h"

@implementation NSDate (HowToSpendTime)

+ (NSString *)timestampStringFromCurrentDate {
    return [NSDate timestampStringByAddingDay:0];
}

+ (NSString *)timestampStringByAddingDay:(NSInteger)dayNumber {
    NSDate *currentDate = [NSDate date];
    
    [currentDate dateByAddingTimeInterval:dayNumber*24*60*60];
    
    return [NSDate timestampStringByDate:currentDate];
}

+ (NSString *)timestampStringByDate:(NSDate *)currentDate {
    return [NSString stringWithFormat:@"%d", (int)[currentDate timeIntervalSince1970]];
}

@end
