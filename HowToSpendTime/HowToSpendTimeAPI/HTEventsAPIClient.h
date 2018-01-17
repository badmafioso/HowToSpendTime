//
//  HTEventsAPIClient.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 10.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HTAPIClient.h"

@interface HTEventsAPIClient : HTAPIClient

- (instancetype)init;

- (void)requestEventsByDate:(NSDate *)eventDate
                       page:(NSInteger)pageNumber
               successBlock:(successBlock)successBlock
               andFailBlock:(failBlock)failBlock;
- (void)requestEventById:(NSInteger)eventId
            successBlock:(successBlock)successBlock
            andFailBlock:(failBlock)failBlock;

@end
