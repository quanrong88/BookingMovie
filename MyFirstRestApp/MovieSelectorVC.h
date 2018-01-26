//
//  MovieSelectorVC.h
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 05/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MovieSelectComplete)(NSArray *);

@interface MovieSelectorVC : UITableViewController

@property (strong, nonatomic) NSMutableArray *selectedMovie;
@property (copy, nonatomic) MovieSelectComplete completeBlock;

@end
