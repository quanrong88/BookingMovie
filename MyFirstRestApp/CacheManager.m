//
//  CacheManager.m
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 05/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import "CacheManager.h"
#import <AFNetworking.h>

@implementation CacheManager

+ (instancetype)sharedInstance
{
    static CacheManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CacheManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)loadUsersWithComplete:(void (^)(NSError * _Nullable))complete {
    NSString *URLString = @"http://localhost:30/api/user/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [CacheManager sharedInstance].users = responseObject;
        complete(nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        complete(error);
    }];
}

- (void)loadMoviesWithComplete:(void (^)(NSError * _Nullable))complete {
    NSString *URLString = @"http://localhost:30/api/movies/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [CacheManager sharedInstance].movies = responseObject;
        complete(nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        complete(error);
    }];
}

@end
