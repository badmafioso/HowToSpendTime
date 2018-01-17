//
//  HTEvent.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 11.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTEvent.h"

@implementation HTEvent

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super self];
    
    if (!self) { return nil; }
    
    if (dictionary && dictionary.allKeys.count > 0 ) {
        if (![[dictionary objectForKey:@"id"] isEqual:[NSNull null]]) {
            _eventId = [[dictionary objectForKey:@"id"] integerValue];
        }
        
        if (![[dictionary objectForKey:@"title"] isEqual:[NSNull null]]) {
            _title = [[dictionary objectForKey:@"title"] copy];
        }
        
        if (![[dictionary objectForKey:@"description"] isEqual:[NSNull null]]) {
            _descriptionString = [[dictionary objectForKey:@"description"] copy];
        }
        
        if (![[dictionary objectForKey:@"description"] isEqual:[NSNull null]]) {
            _descriptionString = [[dictionary objectForKey:@"description"] copy];
        }
        
        if (![[dictionary objectForKey:@"place"] isEqual:[NSNull null]]) {
            _place = [[dictionary objectForKey:@"place"] copy];
        }
        
        if (![[dictionary objectForKey:@"body_text"] isEqual:[NSNull null]]) {
            _bodyText = [[dictionary objectForKey:@"body_text"] copy];
        }
        
        if (![[dictionary objectForKey:@"price"] isEqual:[NSNull null]]) {
            _price = [[dictionary objectForKey:@"price"] copy];
        }
        
        id images = [dictionary objectForKey:@"images"];
        
        if (![images isEqual:[NSNull null]]) {
            if ([images isKindOfClass:[NSArray class]]) {
                NSMutableArray *imagesArray = [NSMutableArray array];
                for (id imageDictionary in (NSArray *)images) {
                    if ([imageDictionary isEqual:[NSNull null]]) { continue; }
                         
                    if ([imageDictionary isKindOfClass:[NSDictionary class]]) {
                        if ([[(NSDictionary *)imageDictionary objectForKey:@"image"] isEqual:[NSNull null]]) { continue; }
                        
                        NSString *imageString = [(NSDictionary *)imageDictionary objectForKey:@"image"];
                        
                        [imagesArray addObject:imageString];
                    }
                }
                
                _imageUrls = [imagesArray copy];
            }
        }
    }
    
    return self;
}

@end
