//
//  AddViewController.m
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "AddViewController.h"
#import "ThirdTableViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventName;
@property (weak, nonatomic) IBOutlet UITextField *eventTime;
@property (weak, nonatomic) IBOutlet UITextField *eventLocation;
- (IBAction)saveEvent:(id)sender;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)saveEvent:(id)sender {
    NSString *eventName=_eventName.text;
    NSString *eventTime=_eventTime.text;
    if (eventTime == nil || [eventTime length] == 0) {
        NSDate * currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss aa"];
        NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/New_York"];
        [dateFormatter setTimeZone:tz];
        NSString *localDateString = [dateFormatter stringFromDate:currentDate];
        eventTime = localDateString;
    }
    
    NSString *eventLocation=_eventLocation.text;
    // Get Master view controller
    ThirdTableViewController *masterController =
    (ThirdTableViewController
     *)[self.navigationController.viewControllers
        objectAtIndex:self.navigationController.viewControllers.count-2];
    [masterController insertNewObjectEventName:eventName
                                     eventTime:eventTime eventLocation:eventLocation];
    [self.navigationController popViewControllerAnimated:YES];
    
    // sent out log
    NSLog(@"%@ %@ at: %@", eventName, eventTime, eventLocation);

}
@end
