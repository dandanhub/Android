//
//  TimelineTableViewController.m
//  HW4dandans
//
//  Created by Dandan Shi on 15/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "TimelineTableViewController.h"

@interface TimelineTableViewController ()

@end

@implementation TimelineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // [self readTime];
    // NSLog(@"count %lu", (unsigned long)[self.timelineData count]);
}


- (void)viewDidAppear:(BOOL)animated {
    [self readTime];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.timelineData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twitterCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *timelineObject = [self.timelineData objectAtIndex: indexPath.row];
    NSDictionary  *entities = timelineObject[@"user"];
    NSString *name = [entities objectForKey:@"name"];
    cell.textLabel.text = timelineObject[@"text"];
    // cell.detailTextLabel.text= name;
    
    NSString *createdTime = timelineObject[@"created_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
    NSDate *date  = [dateFormatter dateFromString:createdTime];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    NSString *screenName = [entities objectForKey:@"screen_name"];
    NSString *message = [newDate stringByAppendingFormat:@" %@", screenName];
    
    cell.detailTextLabel.text= message;
    return cell;
}

- (void) readTime {
    // Create an account store
    ACAccountStore *twitter = [[ACAccountStore alloc] init];
    // Create an account type
    ACAccountType *twAccountType = [twitter accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter]; // Request Access to the twitter account
    [twitter requestAccessToAccountsWithType:twAccountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted)
        {
            // Create an Account
            ACAccount *twAccount = [[ACAccount alloc] initWithAccountType:twAccountType];
            NSArray *accounts = [twitter accountsWithAccountType:twAccountType];
            twAccount = [accounts lastObject];
            
            // Create an NSURL instance variable
            NSURL *twitterURL = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
            NSDictionary *param =@{@"count":@"10", @"include_entities":@"true"}; // Create a Http request
            SLRequest *requestUsersTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET
                                                                         URL:twitterURL
                                                                  parameters:param];
            // Set the account to be used with the request
            [requestUsersTweets setAccount:twAccount];
            // Perform the request
            [requestUsersTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2){
                //if error à show proper message to the user, if successà json
                
                NSLog(@"HTTP Response: %li", (long)[urlResponse statusCode]);
                
                if ([urlResponse statusCode] == 400) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                                   message:@"Bad Request. No Twitter Account Permission"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action) {}];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else if ([urlResponse statusCode] == 401) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                                   message:@"Access Denied"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action) {}];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                else if ([urlResponse statusCode] == 403) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                                   message:@"Request Forbidden"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action) {}];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
//                else if ([urlResponse statusCode] == 200) {
//                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
//                                                                                   message:@"Successfully Tweet Message"
//                                                                            preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                                          handler:^(UIAlertAction * action) {}];
//                    
//                    [alert addAction:defaultAction];
//                    [self presentViewController:alert animated:YES completion:nil];
//                }
                else if ([urlResponse statusCode] == 429) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                                   message:@"Too Many Request"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action) {}];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                if (error2!= nil) {// Do Something when gets error}
                    // The output of the request is placed in the log.
                    NSLog(@"HTTP Error Message: %@", [error2 localizedDescription]); // end of performRequestWithHandler: ^block
                }
                
                self.timelineData= [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error2];
                //JSON output serialization
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                if(self.timelineData.count > 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];});
                } //end of if
            }];//end of performRequestWithHandler: block
        } //end of if granted , if not à do something [HW4]
        else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                           message:@"No Twitter Account Permission"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }]; //end of requestAccessToAccountsWithType: completion^{} block
} //end of readTimeline block

/*
 - (IBAction)tweetButton:(id)sender {
 // Create an account store
 ACAccountStore *twitter = [[ACAccountStore alloc] init]; // Create an account type
 ACAccountType *twAccountType = [twitter accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
 
 // Request Access to the twitter account
 [twitter requestAccessToAccountsWithType:twAccountType
 options:nil completion:^(BOOL granted, NSError *error)
 {
 if (granted)
 {
 // Create an Account
 ACAccount *twAccount = [[ACAccount alloc] initWithAccountType:twAccountType];
 NSArray *accounts = [twitter accountsWithAccountType:twAccountType];
 twAccount = [accounts lastObject];
 
 // Create an NSURL instance variable as Twitter status_update end point.
 NSURL *twitterPostURL = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/update.json"]; // Create a request
 SLRequest *requestPostTweets = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST
 URL:twitterPostURL
 parameters:nil];
 // Set the account to be used with the request
 [requestPostTweets setAccount:twAccount];
 NSString *tweetMessage = [_itemName stringByAppendingFormat:@"%@ %@", @" on ", _itemDate];
 [requestPostTweets addMultipartData:[tweetMessage dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data" filename:nil];
 // Perform the request
 [requestPostTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2) {
 if (error2!= nil) {// Do Something when gets error}
 // The output of the request is placed in the log.
 NSLog(@"HTTP Response: %li", (long)[urlResponse statusCode]); // end of performRequestWithHandler: ^block
 } // If permission is granted
 // If permission is not granted, do some error handling ...
 }]; // end of requestAccessToAccountsWithType: ^block
 }
 }];
 }
 @end
 
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
