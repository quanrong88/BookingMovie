//
//  MovieDetailVC.m
//  MyFirstRestApp
//
//  Created by Ta Minh Quan on 04/02/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

#import "MovieDetailVC.h"
#import <AFNetworking.h>

@interface MovieDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *titleTxt;
@property (weak, nonatomic) IBOutlet UITextField *directorTxt;
@property (weak, nonatomic) IBOutlet UITextField *rankingTxt;

@end

@implementation MovieDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.movieDic) {
        self.titleTxt.text = self.movieDic[@"title"];
        self.directorTxt.text = self.movieDic[@"director"];
        self.rankingTxt.text = [self.movieDic[@"ranking"] stringValue] ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClicked:(id)sender {
    __weak MovieDetailVC *weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (self.movieDic) {
        NSString *URLString = [NSString stringWithFormat:@"%@%@", @"http://localhost:81/api/movies/" , self.movieDic[@"id"]];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"title"] = self.titleTxt.text;
        param[@"director"] = self.directorTxt.text;
        param[@"ranking"] = self.rankingTxt.text;
        [manager PUT:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
                 
        }];
    } else {
        NSString *URLString = @"http://localhost:81/api/movies/";
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"title"] = self.titleTxt.text;
        param[@"director"] = self.directorTxt.text;
        param[@"ranking"] = self.rankingTxt.text;
        [manager POST:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
        }];
    }
}

#pragma mark - Table view data source


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
