//
//  FirstViewController.m
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set andrew ID value
    self.andrewID.text = NSLocalizedString(@"AndrewID", nil);
    
    // set current date and time with time zone @"America/New_York"
    NSDate * currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss aa"];
    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/New_York"];
    [dateFormatter setTimeZone:tz];
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
    self.currentTime.text = localDateString;
    
    // update datetime
    // [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];

    
    // get device info
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceModel = myDevice.model;
    NSString *deviceOSVersion = myDevice.systemVersion;
    NSString *deviceInfo = [NSString stringWithFormat:@"%@ %@", deviceModel, deviceOSVersion];;
    self.yourDevice.text = deviceInfo;
    
    // sent out log
    NSLog(@"%@ %@ %@",NSLocalizedString(@"AndrewID", nil), localDateString, deviceInfo);
    // NSLog(@"%@ %@",NSLocalizedString(@"AndrewID", nil), deviceInfo);
}


//-(void) updateTime
//{
//    NSDate * currentDate = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss aa"];
//    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/New_York"];
//    [dateFormatter setTimeZone:tz];
//    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
//    self.currentTime.text = localDateString;
//    NSLog(@"%@", localDateString);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
