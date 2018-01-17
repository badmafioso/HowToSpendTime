//
//  NSDate+HowToSpendTime.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 08.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HowToSpendTime)

+ (NSString *)timestampStringFromCurrentDate;
+ (NSString *)timestampStringByDate:(NSDate *)currentDate;
+ (NSString *)timestampStringByAddingDay:(NSInteger)dayNumber;

@end
