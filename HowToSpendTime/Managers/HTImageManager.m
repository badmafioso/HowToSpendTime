//
//  HTImageManager.m
//  HowToSpendTime
//
//  Created by Сергей Фролов on 14.01.18.
//  Copyright © 2018 Smart Capitan. All rights reserved.
//

#import "HTImageManager.h"
#import "HTAPIClient.h"
#import "HTURLConstants.h"

typedef void(^successImageBlock)(NSData *data, id responseObject);
typedef void(^failImageBlock)(NSError *error);

@interface HTImageManager()

@property (strong, nonatomic) HTAPIClient *apiClient;
@property (strong, nonatomic) NSCache *cache;

@end

@implementation HTImageManager

- (instancetype)init {
    self = [super init];
    
    if (!self) { return nil; }
    
    _apiClient = [[HTAPIClient alloc] initWithBaseURL:kHTBaseURL];
    _cache     = [[NSCache alloc] init];
    
    return self;
}

- (void)imagesFromArray:(NSArray <NSString *>*)imagesArray withCompletion:(void(^)(NSArray <NSData *>*))completion {
    if (imagesArray.count > 0) {
        dispatch_group_t imagesGroup = dispatch_group_create();
        dispatch_queue_t imagesQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        __block NSMutableArray *imagesDataArray = [NSMutableArray array];
        __weak typeof(self) weakSelf = self;
        for (NSString *imageUrl in imagesArray) {
            dispatch_group_enter(imagesGroup);
                [weakSelf imageFromUrl:imageUrl withCompletion:^(NSData *imageData) {
                    if (imageData) {
                        @synchronized(self) {
                            [imagesDataArray addObject:imageData];
                        }
                    }
                    dispatch_group_leave(imagesGroup);
                }];
            
        }
        
        dispatch_group_notify(imagesGroup, imagesQueue, ^{
            completion([imagesDataArray copy]);
        });
    }
}

- (void)imageFromUrl:(NSString *)urlString withCompletion:(void(^)(NSData *data))completion {
    NSData *imageData = [self.cache objectForKey:urlString];
    if (imageData) {
        completion(imageData);
    } else {
        [self.apiClient imageFromURL:urlString
                    withSuccessBlock:[self successImageBlockWithCompletion:completion andURLString:urlString]
                        andFailBlock:[self failImageBlockWithCompletion:completion]];
    }
}

- (successBlock)successImageBlockWithCompletion:(void(^)(NSData *data))completion andURLString:(NSString *)urlString {
    __weak typeof(self) weakSelf = self;
    return ^(NSData *data, id responseObject) {
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.cache setObject:data forKey:urlString];
        
        completion(data);
    };
}

- (failBlock)failImageBlockWithCompletion:(void(^)(NSData *data))completion {
    return ^(NSError *error) {
        NSData *data = nil;
        
        completion(data);
    };
}

@end
