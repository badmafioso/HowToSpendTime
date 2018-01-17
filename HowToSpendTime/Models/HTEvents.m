//
//  HTEvents.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 13.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEvents.h"
#import "HTEvent.h"

@implementation HTEvents

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (!self) { return nil; }
    
    if (dictionary && dictionary.allKeys.count > 0) {
        id results = [dictionary objectForKey:@"results"];
        
        if (![results isKindOfClass:[NSArray class]] && [results isEqual:[NSNull null]]) {
            NSLog(@"HTEvents error: results  isn't array");
            
            return nil;
        }
        
        NSMutableArray *eventsArray = [NSMutableArray array];
        for (NSDictionary *eventDictionary in (NSArray *)results) {
            if ([eventDictionary isEqual:[NSNull null]]) {
                continue;
            }
            
            HTEvent *event = [[HTEvent alloc] initWithDictionary:eventDictionary];
            
            [eventsArray addObject:event];
        }
        
        _events = [eventsArray copy];
        
        id count = [dictionary objectForKey:@"count"];
        if (![count isEqual:[NSNull class]]) {
            _itemsCount = [count integerValue];
        }
    }
    
    return self;
}

@end
