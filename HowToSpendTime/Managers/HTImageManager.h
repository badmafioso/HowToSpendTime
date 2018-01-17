//
//  HTImageManager.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTImageManager : NSObject

@property (copy, nonatomic, readonly) NSDictionary <NSString*, NSData *>* images;

- (void)imageFromUrl:(NSString *)urlString withCompletion:(void(^)(NSData *data))completion;
- (void)imagesFromArray:(NSArray <NSString *>*)imagesArray withCompletion:(void(^)(NSArray <NSData *>*))completion;

@end
