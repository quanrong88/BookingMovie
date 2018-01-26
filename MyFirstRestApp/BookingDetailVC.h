//
//  BookingDetailVC.h
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 05/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingDetailVC : UITableViewController

@property (strong, nonatomic) NSNumber *bookingId;
@property (strong, nonatomic) NSDictionary *bookingDic;

@end
