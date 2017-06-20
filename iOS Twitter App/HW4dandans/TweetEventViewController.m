//
//  TweetEventViewController.m
//  iOSHW2
//
//  Created by Dandan Shi on 13/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "TweetEventViewController.h"

@interface TweetEventViewController ()

@end

@implementation TweetEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eventDate.text = self.itemDate;
    self.eventName.text = self.itemName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
             // message add @08723Mapp (https://twitter.com/08723Mapp) [dandans]
             NSString *message = [@"@08723Mapp (https://twitter.com/08723Mapp) [dandans]" stringByAppendingFormat:@" %@", tweetMessage];
             
             [requestPostTweets addMultipartData:[message dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data" filename:nil];
             
             // Perform the request
             [requestPostTweets performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error2) {
                 // NSLog(@"HTTP Response: %li %@", (long)[urlResponse statusCode], [error2 localizedDescription]);
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
                                                                                    message:@"Request Forbidden Duplicated Message"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {}];
                     
                     [alert addAction:defaultAction];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
                 else if ([urlResponse statusCode] == 429) {
                     UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                                    message:@"Too Many Request"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {}];
                     
                     [alert addAction:defaultAction];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
                 else if ([urlResponse statusCode] == 200) {
                     UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                                    message:@"Successfully Tweet Message"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {}];
                     
                     [alert addAction:defaultAction];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
                 
                 if (error2!= nil) {// Do Something when gets error}
                     // The output of the request is placed in the log.
                     NSLog(@"HTTP Error Message: %@", [error2 localizedDescription]); // end of performRequestWithHandler: ^block
                 } // If permission is granted
                 
                 // If permission is not granted, do some error handling ...
             }]; // end of requestAccessToAccountsWithType: ^block
         }
         else {
             UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tweet Alert"
                                                                            message:@"No Twitter Account Permission"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
             
             [alert addAction:defaultAction];
             [self presentViewController:alert animated:YES completion:nil];
             
         }
     }];
}

@end
