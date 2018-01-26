//
//  BookingDetailVC.m
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 05/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import "BookingDetailVC.h"
#import <AFNetworking.h>
#import "MovieSelectorVC.h"
#import "UserSelectorVC.h"

@interface BookingDetailVC ()

@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *pubDateTxt;
@property (strong, nonatomic) NSDictionary *user;
@end

@implementation BookingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    if (!self.bookingId) {
        return;
    }
    __weak BookingDetailVC *weakSelf = self;
    NSString *URLString = [NSString stringWithFormat:@"%@%@",@"http://localhost:30/api/bookings/",self.bookingId];;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        weakSelf.nameTxt.text = responseObject[@"user"][@"name"];
        weakSelf.user =  responseObject[@"user"];
        weakSelf.pubDateTxt.text = responseObject[@"pubDate"];
        weakSelf.movies = responseObject[@"movies"];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingMovieCell" forIndexPath:indexPath];
    
    NSDictionary *movieDic = self.movies[indexPath.row];
    cell.textLabel.text = movieDic[@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ -rank:%@",movieDic[@"director"],movieDic[@"ranking"]];
    
    return cell;
}


- (IBAction)saveBtnClicked:(id)sender {
    __weak BookingDetailVC *weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.user[@"id"];
    param[@"pubDate"] = self.pubDateTxt.text;
    param[@"movieIds"] = [NSSet setWithArray:[self.movies valueForKeyPath:@"id"]];
    
    if (self.bookingId) {
        NSString *URLString = [NSString stringWithFormat:@"%@%@", @"http://localhost:30/api/bookings/" , self.bookingId];
        [manager PUT:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    } else {
        NSString *URLString = @"http://localhost:30/api/bookings/";
        [manager POST:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    __weak BookingDetailVC *weakSelf = self;
    if ([segue.identifier isEqualToString:@"selectMovies"]) {
        
        MovieSelectorVC *desVC = segue.destinationViewController;
        desVC.selectedMovie = [self.movies mutableCopy];
        desVC.completeBlock = ^(NSArray *selectedItems) {
            weakSelf.movies = selectedItems;
            [weakSelf.tableView reloadData];
        };
        
    }
    
    if ([segue.identifier isEqualToString:@"changeUser"]) {
        UserSelectorVC *desVC = segue.destinationViewController;
        desVC.selectedUser = self.user;
        desVC.completeBlock = ^(NSDictionary *selectedUser) {
            weakSelf.user = selectedUser;
            weakSelf.nameTxt.text = selectedUser[@"name"];
        };
    }
}


@end
