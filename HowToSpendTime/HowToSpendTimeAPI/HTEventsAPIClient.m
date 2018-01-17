//
//  HTEventsAPIClient.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 10.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEventsAPIClient.h"
#import "HTURLConstants.h"
#import "NSDate+HowToSpendTime.h"

@interface HTEventsAPIClient ()

@property (strong, nonatomic) HTAPIClient *apiClient;

@end

@implementation HTEventsAPIClient

- (instancetype)init {
    self = [super initWithBaseURL:kHTBaseURL];
    
    if (!self) return nil;
    
    return self;
}

- (void)requestEventsByDate:(NSDate *)eventDate
                       page:(NSInteger)pageNumber
               successBlock:(successBlock)successBlock
               andFailBlock:(failBlock)failBlock {
    
    NSString *eventDateTimestamp = [NSDate timestampStringByDate:eventDate];
    NSDictionary *parameters     = @{
                                     @"location" : @"nnv",
                                     @"actual_since" : eventDateTimestamp,
                                     @"actual_until" : eventDateTimestamp,
                                     @"fields" : @"id,title,description,images",
                                     @"page_size" : @(kHTEventItemsCountOnPage),
                                     @"page" : @(pageNumber)
                                     };
    
    [self GET:kHTGetEventsList parameters:parameters withSuccessBlock:successBlock andFailBlock:failBlock];
}

- (void)requestEventById:(NSInteger)eventId
            successBlock:(successBlock)successBlock
            andFailBlock:(failBlock)failBlock {
    NSString *urlString = [NSString stringWithFormat:kHTGetEvent, eventId];
    
    NSDictionary *parameters     = @{
                                     @"fields" : @"id,title,description,body_text,place,price,images"
                                     };
    
    [self GET:urlString parameters:parameters withSuccessBlock:successBlock andFailBlock:failBlock];
}

@end

