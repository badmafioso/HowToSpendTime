//
//  HTEvents.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 13.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTEvents : NSObject

@property (nonatomic, readonly) NSInteger itemsCount;
@property (copy, nonatomic, readonly) NSArray *events;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
