//
//  HTEventsModelManager.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 11.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEventsModelManager.h"
#import "HTEventsAPIClient.h"
#import "HTEvents.h"
#import "HTURLConstants.h"

typedef void(^eventsListSuccessBlock)(NSData *responseData, id responseObject);
typedef void(^eventsListFailBlock)(NSError *error);
typedef void(^eventSuccessBlock)(NSData *responseData, id responseObject);
typedef void(^eventFailBlock)(NSError *error);

@interface HTEventsModelManager()

@property (strong, nonatomic) HTEventsAPIClient *eventsAPIClient;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger pagesCount;

@end

@implementation HTEventsModelManager

- (instancetype)init {
    self = [super init];
    
    if (!self) return nil;
    
    _eventsAPIClient = [[HTEventsAPIClient alloc] init];
    _pageNumber      = 1;
    _pagesCount      = -1;
    
    return self;
}

- (void)reloadEventsManager {
    self.pageNumber = 1;
    self.pagesCount = -1;
}

- (void)loadEventLits {
    [self loadEventLitsByDate:[NSDate date]];
}

- (void)loadEventLitsByDate:(NSDate *)selectedDate {
    if (self.pageNumber > self.pagesCount && self.pagesCount != -1) { return; }
    
    [self.eventsAPIClient requestEventsByDate:selectedDate page:self.pageNumber
                                 successBlock:[self eventsListSuccessBlock]
                                 andFailBlock:[self eventsListFailBlock]];
}

- (void)loadEvent:(NSInteger)eventId {
    [self.eventsAPIClient requestEventById:eventId successBlock:[self eventSuccessBlock] andFailBlock:[self eventFailBlock]];
}

- (eventsListSuccessBlock)eventsListSuccessBlock {
    __weak typeof(self) weakSelf = self;
    return ^(NSData *responseData, id responseObject) {
        __strong typeof(self) strongSelf = weakSelf;        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            HTEvents *events = [[HTEvents alloc] initWithDictionary:responseObject];
            
            if (events) {
                strongSelf.pageNumber++;
                strongSelf.pagesCount = ceil((double)events.itemsCount / kHTEventItemsCountOnPage);
            }
            
            if ([strongSelf.delegate respondsToSelector:@selector(requestToGetEventsDidCompleted:withError:)]) {
                [strongSelf.delegate requestToGetEventsDidCompleted:events withError:nil];
            }
        }
    };
}

- (eventSuccessBlock)eventSuccessBlock {
    __weak typeof(self) weakSelf = self;
    return ^(NSData *responseData, id responseObject) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            HTEvent *event = [[HTEvent alloc] initWithDictionary:responseObject];
            
            if (event) {
                if ([strongSelf.delegate respondsToSelector:@selector(requestToGetEventDidCompleted:withError:)]) {
                    [strongSelf.delegate requestToGetEventDidCompleted:event withError:nil];
                }
            }
        }
    };
}

- (eventsListFailBlock)eventsListFailBlock {
    return ^(NSError *error) {
        
    };
}

- (eventFailBlock)eventFailBlock {
    return ^(NSError *error) {
        
    };
}

@end
