//
//  HTAPIClient.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 08.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//
#import "NSDate+HowToSpendTime.h"
#import "HTAPIClient.h"

@interface HTAPIClient ()

@property (strong, nonatomic) NSString *baseURLString;

@end

@implementation HTAPIClient

- (instancetype)initWithBaseURL:(NSString *)baseURLString {
    self = [super init];
    
    if (!self) return nil;
    
    _baseURLString = baseURLString;
    
    return self;
}

- (NSString *)addParametersToURLString:(NSString *)urlString parameters:(NSDictionary <NSString *, NSString *>*)parameters {
    if (parameters != nil) {
        urlString = [urlString stringByAppendingString:@"?"];
        
        int parameterIndex = 0;
        for (NSString *key in parameters) {
            NSString *value = [parameters objectForKey:key];
            
            if (parameterIndex > 0) {
                urlString = [urlString stringByAppendingString:@"&"];
            }
            
            urlString = [urlString stringByAppendingFormat:@"%@=%@", key, value];
            
            parameterIndex++;
        }
    }
    
    return urlString;
}

- (void)GET:(NSString *)urlString parameters:(NSDictionary <NSString *, NSString *>*)parameters
                            withSuccessBlock:(successBlock)successBlock
                                andFailBlock:(failBlock)failBlock {
    
    NSString *fullUrlString = [self.baseURLString stringByAppendingString:urlString];
    
    [self baseHTTPGETRequest:fullUrlString
                  parameters:parameters
           isNeedToParseData:YES
            withSuccessBlock:successBlock
                andFailBlock:failBlock];
}

- (void)baseHTTPGETRequest:(NSString *)urlString
                parameters:(NSDictionary <NSString *, NSString *>*)parameters
         isNeedToParseData:(BOOL)isNeedToParseData
          withSuccessBlock:(successBlock)successBlock
              andFailBlock:(failBlock)failBlock {
    
    urlString = [self addParametersToURLString:urlString parameters:parameters];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof (self) weakSelf = self;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        __strong typeof (self) strongSelf = weakSelf;
        
        if (error == nil) {
            if (isNeedToParseData) {
                id responseData = [strongSelf parseResponseData:data];
                if ([responseData isKindOfClass:[NSError class]]) {
                    failBlock((NSError *)responseData);
                } else {
                    successBlock(data, responseData);
                }
            } else {
                successBlock(data, response);
            }
        } else {
            failBlock(error);
        }
    }];
    
    [task resume];
}

- (void)imageFromURL:(NSString *)imageUrlString withSuccessBlock:(successBlock)successBlock andFailBlock:(failBlock)failBlock {
    [self baseHTTPGETRequest:imageUrlString
                  parameters:nil
           isNeedToParseData:NO
            withSuccessBlock:successBlock
                andFailBlock:failBlock];
}

- (id)parseResponseData:(NSData *)responseData {
    NSError *error = nil;
    
    id responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    if (error) {
        NSLog(@"HTAPIClient: %@", error.localizedDescription);
        
        return error;
    }
    
    return responseObject;
}

@end
