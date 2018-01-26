//
//  UserSelectorVC.h
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 05/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserSelectComplete)(NSDictionary *);

@interface UserSelectorVC : UITableViewController

@property (strong, nonatomic) NSDictionary *selectedUser;
@property (copy, nonatomic) UserSelectComplete completeBlock;

@end
