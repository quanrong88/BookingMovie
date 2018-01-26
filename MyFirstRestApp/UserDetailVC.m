//
//  UserDetailVC.m
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 04/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import "UserDetailVC.h"
#import <AFNetworking.h>

@interface UserDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;

@end

@implementation UserDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.userDic) {
        self.nameTxt.text = self.userDic[@"name"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClicked:(id)sender {
    __weak UserDetailVC *weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (self.userDic) {
        NSString *URLString = [NSString stringWithFormat:@"%@%@", @"http://localhost:30/api/user/" , self.userDic[@"id"]];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"name"] = self.nameTxt.text;
        [manager PUT:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    } else {
        NSString *URLString = @"http://localhost:30/api/user/";
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"name"] = self.nameTxt.text;
        [manager POST:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (IBAction)showBookingsBtnClicked:(id)sender {
    if (!self.userDic) {
        return;
    }
    
    
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
