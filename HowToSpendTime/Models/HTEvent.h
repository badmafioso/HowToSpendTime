//
//  HTEvent.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 11.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTEvent : NSObject

@property (nonatomic, readonly) NSInteger eventId;
@property (copy, nonatomic, readonly) NSArray *imageUrls;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *descriptionString;
@property (copy, nonatomic, readonly) NSString *place;
@property (copy, nonatomic, readonly) NSString *bodyText;
@property (copy, nonatomic, readonly) NSString *price;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
