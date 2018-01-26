//
//  CacheManager.h
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 05/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSArray *users;

- (void)loadUsersWithComplete:(void (^)(NSError * ))complete;

@end
