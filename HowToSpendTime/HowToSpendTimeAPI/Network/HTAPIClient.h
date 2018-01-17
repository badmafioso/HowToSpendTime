//
//  HTAPIClient.h
//  HowToSpendTime
//
//  Created by Сергей Фролов on 08.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void(^successBlock)(NSData *responseData, id responseObject);
typedef void(^failBlock)(NSError *error);

@interface HTAPIClient : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBaseURL:(NSString *)baseURLString;

- (void)GET:(NSString *)urlString parameters:(NSDictionary <NSString *, NSString *>*)parameters
                            withSuccessBlock:(successBlock)successBlock
                                andFailBlock:(failBlock)failBlock;
- (void)imageFromURL:(NSString *)imageUrlString withSuccessBlock:(successBlock)successBlock andFailBlock:(failBlock)failBlock;

@end
