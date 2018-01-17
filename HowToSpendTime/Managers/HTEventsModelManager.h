//
//  HTEventsModelManager.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 11.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTEvents.h"
#import "HTEvent.h"

@protocol HTEventsManagerDelegate <NSObject>

@optional

- (void)requestToGetEventsDidCompleted:(HTEvents *)events withError:(NSError *)error;
- (void)requestToGetEventDidCompleted:(HTEvent *)event withError:(NSError *)error;

@end

@interface HTEventsModelManager : NSObject

@property (weak, nonatomic) id<HTEventsManagerDelegate> delegate;

- (void)loadEventLits;
- (void)loadEventLitsByDate:(NSDate *)selectedDate;
- (void)loadEvent:(NSInteger)eventId;
- (void)reloadEventsManager;

@end
